import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';

import '../../application_layer/application_layer.dart';
import '../../core/enums.dart';
import '../../core/services/database.dart';
import '../../product/constants/constants.dart';
import '../data.dart';

part 'invoices_daos.g.dart';

@DriftAccessor(tables: [
  Products,
  Users,
  Accounts,
  ProductUnits,
  ProductCategories,
  Invoices,
  Sales,
  Debts,
])
class InvoicesDao extends DatabaseAccessor<MyDatabase>
    with _$InvoicesDaoMixin
    implements InvoicesDataSource {
  InvoicesDao(super.attachedDatabase);

  @override
  Future<List<ProductCategory>> get categories =>
      select(productCategories).get();

  @override
  Future<int> insertCategory(ProductCategoriesCompanion category) {
    return into(productCategories).insert(category);
  }

  @override
  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  @override
  Future<List<Product>> get getProducts => select(products).get();

  @override
  Future<void> insertMultipleProducts(
      List<ProductsCompanion> productsList) async {
    batch((batch) async {
      batch.insertAll(products, productsList);
    });
  }

  @override
  Future<InvoiceModel> createEmptyInvoice() async {
    final id = await into(invoices).insert(InvoicesCompanion.insert(
      accountId: -1,
      paymentType: PaymentType.cache,
      invoiceType: InvoiceType.sales,
      totalAmount: 0,
    ));
    final invoice = emptyInvoice.copyWith(
      id: id,
    );
    const account = emptyAccount;

    return InvoiceModel(
      invoice,
      const [],
      account,
    );
  }

  @override
  Stream<List<ProductModel>> get watchProducts {
    final productStream = select(products).watch();
    return productStream.switchMap((value) {
      /// mapping id to product
      final idToProduct = {for (var p in value) p.id: p};
      final ids = idToProduct.keys;
      // print("ids :$ids");
      // select all units and categories that are included in any product
      final entryQuery = select(products).join(
        [
          innerJoin(productCategories,
              productCategories.id.equalsExp(products.categoryId)),
          innerJoin(
              productUnits, productUnits.productId.equalsExp(products.id)),
        ],
      );
      // )..where(products.id.isIn(ids));

      return entryQuery.watch().map(
        (rows) {
          final idToUnits = <int, List<ProductUnit>>{};
          final idToCategories = <int, ProductCategory>{};

          for (final row in rows) {
            final unit = row.readTable(productUnits);
            final category = row.readTable(productCategories);
            final id = row.readTable(products).id;
            idToUnits.putIfAbsent(id, () => []).add(unit);
            idToCategories.putIfAbsent(id, () => category);
          }

          return [
            for (var id in ids)
              ProductModel(
                product: idToProduct[id]!,
                category: idToCategories[id] ??
                    const ProductCategory(id: -1, name: ""),
                unitsList: idToUnits[id] ?? [],
              )
          ];
        },
      );
    });
  }

  @override
  Future<void> writeProduct(ProductModel entry) {
    return transaction(() async {
      final product = entry.product.copyWith(
        categoryId: Value(entry.category.id),
      );
      // first we write the product
      await into(products).insert(product, mode: InsertMode.replace);

      // now we add the units
      for (final unit in entry.unitsList) {
        final unitCompanion = ProductUnitsCompanion.insert(
          id: (unit.id == -1) ? const Value.absent() : Value(unit.id),
          purchasePrice: unit.purchasePrice,
          salePrice: unit.salePrice,
          productId: product.id,
          box: Value(unit.box),
        );
        await into(productUnits).insert(
          unitCompanion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  @override
  Future<ProductModel> createEmptyProduct() async {
    final id = await into(products).insert(ProductsCompanion.insert(
      unit1: -1,
      name: "",
    ));
    const product = ProductModel.empty;

    return product.copyWith(
      product: product.product.copyWith(id: id),
    );
  }

  @override
  Future<InvoiceModel> get allInvoices => throw UnimplementedError();

  @override
  Future<void> writeInvoice(InvoiceModel entry,
      {InvoiceState action = InvoiceState.New}) {
    return transaction(() async {
      final invoice = entry.invoice.copyWith(
        accountId: entry.account.id,
      );
      // first we replace the invoice
      await into(invoices).insert(invoice, mode: InsertMode.replace);
      if (StorageKeys.settingsAddQuantity.storedValue ?? false) {
        if (invoice.invoiceType.isSales) {
          for (var sale in entry.sales) {
            await (update(products)
                  ..where((tbl) => tbl.id.equals(sale.productId)))
                .write(
              ProductsCompanion(
                minimumToOrderInStock:
                    Value(sale.product.unitInStock - sale.quantity),
              ),
            );
          }
        } else {
          for (var sale in entry.sales) {
            await (update(products)
                  ..where((tbl) => tbl.id.equals(sale.productId)))
                .write(
              ProductsCompanion(
                minimumToOrderInStock:
                    Value(sale.product.unitInStock + sale.quantity),
              ),
            );
          }
        }
      }
      // now we add the sales
      for (var s in entry.sales) {
        await into(sales).insert(
          SalesCompanion.insert(
            salesId: (s.saleId == -1) ? const Value.absent() : Value(s.saleId),
            invoiceId: invoice.id,
            productId: s.productId,
            unitId: s.unit.id,
            quantity: s.quantity,
            unitPrice: entry.invoiceType.isPurchaseOrPurchaseReturn
                ? s.purchasePrice
                : s.salePrice,
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
      if (entry.paymentType == PaymentType.credit) {
        if (action == InvoiceState.New) {
          await into(debts).insert(DebtsCompanion.insert(
            isCredit: true,
            accountId: Value(entry.accountId),
            invoiceId: Value(entry.invoiceId),
            description: Value("total Quantity ${entry.totalQuantity}"),
            amount: entry.total - entry.amountTendered,
            deptType: DeptType.invoice,
          ));
        }
      }
    });
  }

  @override
  Stream<List<ProductCategory>> get watchCategories =>
      select(productCategories).watch();

  @override
  Future<void> deleteProduct(int productId) {
    return transaction(() async {
      // first we delete all units
      await (delete(productUnits)
            ..where((row) => row.productId.equals(productId)))
          .go();

      await (delete(products)..where((row) => row.id.equals(productId))).go();
    });
  }

  @override
  Future<void> deleteInvoice(InvoiceModel invoice) {
    return transaction(() async {
      if (StorageKeys.settingsAddQuantity.storedValue ?? false) {
        if (invoice.invoiceType.isSales) {
          for (var sale in invoice.sales) {
            await (update(products)
                  ..where((tbl) => tbl.id.equals(sale.productId)))
                .write(
              ProductsCompanion(
                minimumToOrderInStock:
                    Value(sale.product.unitInStock + sale.quantity),
              ),
            );
          }
        } else {
          for (var sale in invoice.sales) {
            await (update(products)
                  ..where((tbl) => tbl.id.equals(sale.productId)))
                .write(
              ProductsCompanion(
                minimumToOrderInStock:
                    Value(sale.product.unitInStock - sale.quantity),
              ),
            );
          }
        }
      }
      await (delete(sales)
            ..where((tbl) => tbl.invoiceId.equals(invoice.invoiceId)))
          .go();

      await (delete(invoices)..where((tbl) => tbl.id.equals(invoice.invoiceId)))
          .go();
    });
  }

  @override
  Future<void> removeUnit(int unitId) {
    return transaction(() async {
      await (delete(productUnits)..where((tbl) => tbl.id.equals(unitId))).go();
    });
  }

  @override
  Stream<List<InvoiceModel>> get watchAllInvoices async* {
    final invoiceStream = select(invoices).watch();

    final idToProduct = {for (var p in await allProducts) p.productId: p};

    yield* invoiceStream.switchMap((value) {
      // mapping id to invoice
      final idToInvoice = {for (var i in value) i.id: i};
      final ids = idToInvoice.keys;
      print("invoice ids : $ids");

      final query = select(invoices).join([
        innerJoin(accounts, accounts.id.equalsExp(invoices.accountId)),
        innerJoin(sales, sales.invoiceId.equalsExp(invoices.id)),
      ])
        ..orderBy([OrderingTerm.asc(invoices.id)]);

      return query.watch().map((rows) {
        final idToSales = <int, List<SaleModel>>{};
        final idToAccount = <int, Account>{};

        for (var row in rows) {
          final sale = row.readTable(sales);
          final account = row.readTable(accounts);
          final id = row.readTable(invoices).id;
          idToAccount.putIfAbsent(id, () => account);
          idToSales.putIfAbsent(id, () => []).add(
                SaleModel(
                  sale,
                  idToProduct[sale.productId]!,
                ),
              );
        }
        return [
          for (var id in ids)
            InvoiceModel(
              idToInvoice[id]!,
              idToSales[id] ?? [],
              idToAccount[id] ??
                  const Account(
                    isFrozen: false,
                    id: -1,
                    name: "",
                    accountType: AccountType.none,
                  ),
            )
        ];
      });
    });
  }

  Future<List<ProductModel>> get allProducts async {
    final productList = await select(products).get();

    /// mapping id to product
    final idToProduct = {for (var p in productList) p.id: p};
    final ids = idToProduct.keys;

    final query = select(products).join([
      innerJoin(productCategories,
          productCategories.id.equalsExp(products.categoryId)),
      innerJoin(productUnits, productUnits.productId.equalsExp(products.id)),
    ]);

    final result = await query.get();
    final idToUnits = <int, List<ProductUnit>>{};
    final idToCategories = <int, ProductCategory>{};
    for (final row in result) {
      final unit = row.readTable(productUnits);
      final category = row.readTable(productCategories);
      final id = row.readTable(products).id;
      idToUnits.putIfAbsent(id, () => []).add(unit);
      idToCategories.putIfAbsent(id, () => category);
    }
    return [
      for (var id in ids)
        ProductModel(
          product: idToProduct[id]!,
          category:
              idToCategories[id] ?? const ProductCategory(id: -1, name: ""),
          unitsList: idToUnits[id] ?? [],
        )
    ];
  }

  @override
  Future<int> deleteMultipleInvoices(List<int> ids) async {
    await (delete(sales)..where((tbl) => tbl.invoiceId.isIn(ids))).go();
    return await (delete(invoices)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  @override
  Future<void> removeSale(int saleId) async {
    await (delete(sales)..where((tbl) => tbl.salesId.equals(saleId))).go();
  }

  @override
  Future<List<ProductModel>> loadProducts({int? accountId}) async {
    final productFuture = select(products).get();
    return productFuture.then((value) async {
      /// mapping id to product
      final idToProduct = {for (var p in value) p.id: p};
      final ids = idToProduct.keys;
      Map<int, int> idToSelectedUnit = {};
      // print("ids :$ids");
      // select all units and categories that are included in any product
      final entryQuery = select(products).join(
        [
          innerJoin(productCategories,
              productCategories.id.equalsExp(products.categoryId)),
          innerJoin(
              productUnits, productUnits.productId.equalsExp(products.id)),
        ],
      );

      switch (
          PricingPolicy.values[StorageKeys.pricingPolicy.storedValue ?? 1]) {
        case PricingPolicy.last:
          for (int id in ids) {
            try {
              final lastSale = (await (select(sales)
                        ..where((tbl) => tbl.productId.equals(id))
                        ..limit(10)
                        ..orderBy([(tbl) => OrderingTerm.desc(tbl.salesId)]))
                      .get())
                  .first;
              Map<int, int> temp = {id: lastSale.unitId};
              idToSelectedUnit.addAll(temp);
            } on Exception {
              //
            }
          }
          break;
        case PricingPolicy.fixed:
          break;
        case PricingPolicy.lastAccount:
          if (accountId != null) {
            for (int id in ids) {
              try {
                // we select the last time the account buy the product
                // and get that sale
                final lastAccountOperation = (await (select(invoices).join([
                  innerJoin(sales, sales.invoiceId.equalsExp(invoices.id))
                ])
                          ..where(sales.productId.equals(id))
                          ..where(invoices.accountId.equals(accountId))
                          ..limit(10)
                          ..orderBy([OrderingTerm.desc(invoices.id)]))
                        .get())
                    .first;

                final unitId = lastAccountOperation.read(sales.unitId) ?? 0;
                Map<int, int> temp = {id: unitId};
                idToSelectedUnit.addAll(temp);
              } catch (e) {
                //
              }
            }
          }
          break;
      }

      final rows = await entryQuery.get();
      final idToUnits = <int, List<ProductUnit>>{};
      final idToCategories = <int, ProductCategory>{};

      for (final row in rows) {
        final unit = row.readTable(productUnits);
        final category = row.readTable(productCategories);
        final id = row.readTable(products).id;
        idToUnits.putIfAbsent(id, () => []).add(unit);
        idToCategories.putIfAbsent(id, () => category);
      }

      return [
        for (var id in ids)
          ProductModel(
            product: idToProduct[id]!,
            category: idToCategories[id] ??
                const ProductCategory(
                  id: -1,
                  name: "",
                ),
            unitsList: idToUnits[id] ?? [],
          )
      ];
    });
  }
}
