import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common_blocs/printer/printer_bloc.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../application_layer.dart';

part 'new_invoice_state.dart';

class NewInvoiceCubit extends Cubit<NewInvoiceState> {
  final InvoicesRepository invoicesRepository;
  final InvoiceActions action;

  NewInvoiceCubit(
    this.invoicesRepository, {
    InvoiceModel? invoice,
    InvoiceType? type,
    this.action = InvoiceActions.insert,
  }) : super(NewInvoiceState(type: type)) {
    // if the invoice is empty we create new invoice
    if (invoice == null) {
      invoicesRepository.createEmptyInvoice().then((value) {
        emit(state.copyWith(
          invoice: value,
        ));
      });
    } else {
      emit(state.copyWith(
        invoice: invoice,
        state: InvoiceState.Update,
      ));
    }
  }

  /// [value] is payment type => true <=> PaymentType.cache | false <=> PaymentType.credit
  void onPaymentTypeChanged(bool? value) {
    if (value != null) {
      final fullInvoice = state.invoice;

      emit(
        state.copyWith(
          invoice: fullInvoice.copyWith(
            invoice: fullInvoice.invoice.copyWith(
              paymentType: value ? PaymentType.cache : PaymentType.credit,
            ),
          ),
        ),
      );
    }
  }

  void onAccountChanged(Account? account) {
    if (account != null) {
      final fullInvoice = state.invoice;
      emit(
        state.copyWith(
          invoice: fullInvoice.copyWith(account: account),
        ),
      );
    }
  }

  void onStart(BuildContext context) {
    final invoice = state.invoice;
    if (invoice.isAccountEmpty) {
      // print("account not set");
    } else if (invoice.isInvoiceEmpty) {
      // print("invoice not created");
    } else {
      Navigator.pop(context, "Start");
    }
  }

  void toggleSaleWithProduct(ProductModel product) {
    final fullInvoice = state.invoice;
    List<SaleModel> sales = [];

    sales.addAll(fullInvoice.sales);
    int indexIfExist = checkIfExist(product);
    if (indexIfExist == -1) {
      sales.add(
        SaleModel(
          Sale(
            salesId: -1,
            invoiceId: fullInvoice.invoiceId,
            productId: product.productId,
            unitId: product.unit.id,
            quantity: 1,
            unitPrice: state.type.isPurchaseOrPurchaseReturn
                ? product.purchasePriceUnit
                : product.salePriceUnit,
            subTotal: 0,
          ),
          product,
        ),
      );
      emit(state.copyWith(
        invoice: fullInvoice.copyWith(sales: sales),
      ));
    } else {
      onIncreaseQuantityOnSale(indexIfExist);
    }
  }

  /// if the [product] in the sales will return the colored products
  Color? colorSelectedProducts(ProductModel product, Color primaryColor) {
    if (checkIfExist(product) == -1) {
      return primaryColor;
    }
    return null;
  }

  /// if the [product] does exist in the sale return the index
  /// otherwise return -1
  int checkIfExist(ProductModel product) {
    // we check if the product exist in the sales list
    final sales = state.invoice.sales;
    bool exist = false;
    int i = 0;
    for (var element in sales) {
      if (element.product == product) {
        return i;
      }
      i++;
    }
    return -1;
  }

  void onUnitChangedOnSale(int index, int unitId) {
    //TODO: bad implementation

    // final fullInvoice = state.invoice;
    // final currentSale = fullInvoice.sales[index].sale;
    // List<FullSale> sales = [];
    // if (StorageKeys.settingsUpdateAllUnitsInInvoice.storedValue ?? false) {
    //   late final int unitIndex =
    //       fullInvoice.sales[index].product.getUnitById(unitId).id;

    //   for (var sale in fullInvoice.sales) {
    //     late final ProductUnit unit;
    //     try {
    //       if (state.type == InvoiceType.sales) {
    //         unit = sale.product.salesUnits[unitIndex];
    //       } else {
    //         unit = sale.product.purchaseUnits[unitIndex];
    //       }
    //     } on Exception {
    //       unit = sale.product.salesUnits.first;
    //     }

    //     sales.add(
    //       sale.copyWith(
    //         sale: sale.sale.copyWith(
    //           unitId: unit.id,
    //           unitPrice: unit.price,
    //         ),
    //       ),
    //     );
    //   }
    //   emit(state.copyWith(invoice: fullInvoice.copyWith(sales: sales)));
    // } else {
    //   sales.addAll(fullInvoice.sales);
    //   sales.removeAt(index);
    //   sales.insert(
    //     index,
    //     fullInvoice.sales[index].copyWith(
    //       sale: currentSale.copyWith(
    //         unitId: unitId,
    //         unitPrice: fullInvoice.sales[index].product.unitById(unitId)!.price,
    //       ),
    //     ),
    //   );
    // }
    // emit(state.copyWith(invoice: fullInvoice.copyWith(sales: sales)));
  }

  void onQuantityChangedOnSale(int index, String? value) {
    final fullInvoice = state.invoice;
    final quantity = double.tryParse(value ?? "");
    if (quantity != null) {
      if (quantity >= 0) {
        final currentSale = fullInvoice.sales[index].sale;
        List<SaleModel> sales = [];
        sales.addAll(fullInvoice.sales);
        sales.removeAt(index);
        sales.insert(
          index,
          fullInvoice.sales[index].copyWith(
            sale: currentSale.copyWith(
              quantity: quantity,
            ),
          ),
        );
        emit(state.copyWith(invoice: fullInvoice.copyWith(sales: sales)));
      }
    }
  }

  void onIncreaseQuantityOnSale(int index) {
    final fullInvoice = state.invoice;

    final currentSale = fullInvoice.sales[index].sale;
    final quantity = currentSale.quantity + 1;
    List<SaleModel> sales = [];
    sales.addAll(fullInvoice.sales);
    sales.removeAt(index);
    sales.insert(
      index,
      fullInvoice.sales[index].copyWith(
        sale: currentSale.copyWith(
          quantity: quantity,
        ),
      ),
    );
    emit(state.copyWith(
      invoice: fullInvoice.copyWith(sales: sales),
      status: Status.info,
      msg: "quantity $quantity",
    ));
  }

  void onDecreaseQuantityOnSale(int index) {
    final fullInvoice = state.invoice;

    final currentSale = fullInvoice.sales[index].sale;
    final quantity = currentSale.quantity - 1;
    if (quantity >= 0) {
      List<SaleModel> sales = [];
      sales.addAll(fullInvoice.sales);
      sales.removeAt(index);
      sales.insert(
        index,
        fullInvoice.sales[index].copyWith(
          sale: currentSale.copyWith(
            quantity: quantity,
          ),
        ),
      );
      emit(state.copyWith(
        invoice: fullInvoice.copyWith(sales: sales),
        status: Status.info,
        msg: "quantity $quantity",
      ));
    }
  }

  void onPriceChangedOnSale(int index, String? value) {
    final fullInvoice = state.invoice;
    final price = double.tryParse(value ?? "");
    if (price != null) {
      final currentSale = fullInvoice.sales[index].sale;
      List<SaleModel> sales = [];
      sales.addAll(fullInvoice.sales);
      sales.removeAt(index);
      sales.insert(
        index,
        fullInvoice.sales[index].copyWith(
          sale: currentSale.copyWith(
            unitPrice: price,
          ),
        ),
      );
      emit(state.copyWith(invoice: fullInvoice.copyWith(sales: sales)));
    }
  }

  void removeSale(int index) async {
    final fullInvoice = state.invoice;
    List<SaleModel> sales = [];
    sales.addAll(fullInvoice.sales);
    sales.removeAt(index);
    if (state.state.isUpdating) {
      // remove also from the local database
      await invoicesRepository.removeSale(fullInvoice.sales[index].saleId);
    }
    emit(state.copyWith(invoice: fullInvoice.copyWith(sales: sales)));
  }

  saveInvoice(BuildContext context) async {
    // save invoice
    try {
      final invoice = state.invoice;
      if (invoice.isEmpty) {
        emit(state.copyWith(
          status: Status.failure,
          msg: "the Invoice is empty",
        ));
      } else if (invoice.sales.isEmpty) {
        emit(state.copyWith(
          status: Status.failure,
          msg: "please add at least on product",
        ));
      } else {
        final result = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("${state.state.name} invoice"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text("Total :")),
                        Expanded(
                          child: AppTextField(
                            enabled: false,
                            initialValue: "${state.invoice.total}",
                          ),
                        ),
                      ],
                    ),
                    10.heightBox,
                    state.invoice.paymentType == PaymentType.credit
                        ? Row(
                            children: [
                              const Expanded(child: Text("Amount Treated :")),
                              Expanded(
                                child: AppTextField(
                                  enabled: (action == InvoiceActions.insert),
                                  initialValue:
                                      "${state.invoice.amountTendered}",
                                  onChanged: onAmountTreatedChanged,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, "No");
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.error,
                  ),
                  onPressed: () {
                    Navigator.pop(context, "Yes");
                  },
                  child: Text(
                    "Save",
                    style: context.textTheme.titleLarge!.copyWith(
                      color: context.onError,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        if (result == "Yes") {
          await invoicesRepository.writeInvoice(
            state.invoice.copyWith(
              invoice: state.invoice.invoice.copyWith(
                invoiceType: state.type,
              ),
            ),
          );
          emit(state.copyWith(
            save: true,
            status: Status.success,
            msg: "product added successfully",
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        msg: "exception :${e.toString()}",
      ));
    }
  }

  void onAmountTreatedChanged(String value) {
    final fullInvoice = state.invoice;
    final amount = double.tryParse(value);
    if (amount != null) {
      emit(
        state.copyWith(
          invoice: fullInvoice.copyWith(
            invoice: fullInvoice.invoice.copyWith(
              amountTendered: amount,
            ),
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    if (!state.save && state.state.isNew) {
      invoicesRepository.deleteInvoice(state.invoice);
    }
    return super.close();
  }

  void printBluetooth(BuildContext context) {
    if (state.save || state.state.isUpdating) {
      CommonBloc.printerBloc.add(PrintRequested(state.invoice));
      context.pushNamed(AppRoutes.printingPreview.name);
    }
  }

  void printWifi(BuildContext context) {
    if (state.save || state.state.isUpdating) {
      context.pushNamed(AppRoutes.printingPreview.name);
    }
  }

  void loadProducts() async {
    emit(state.copyWith(status: Status.loading));
    final products = await invoicesRepository.loadProducts(
        accountId: state.invoice.invoiceId);
    emit(state.copyWith(
      products: products,
    ));
  }
}
