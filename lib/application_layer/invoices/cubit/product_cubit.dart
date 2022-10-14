import 'package:drift/drift.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/repositories/repositories.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final InvoicesRepository repository = InvoicesRepositoryImpl();
  final Product? product;
  ProductCubit({this.product}) : super(const ProductState()) {
    if (product != null) {
      emit(state.copyWith(
        id: product!.id,
        productName: product!.name,
        productCode: product!.code,
        unitInStock: product!.unitInStock,
      ));
    }
  }

  void onNameChanged(String value) {
    emit(state.copyWith(
      productName: value,
    ));
  }

  void onCodeChanged(String value) {
    emit(state.copyWith(
      productCode: value,
    ));
  }

  void onUnitInStockChanged(String value) {
    emit(state.copyWith(
      unitInStock: double.tryParse(value),
    ));
  }

  void onPriceChanged(String value) {
    emit(state.copyWith(
      price: double.tryParse(value),
    ));
  }

  void onBoxChanged(String value) {
    emit(state.copyWith(
      box: double.tryParse(value),
    ));
  }

  void onCategoryChanged(String category) {
    emit(state.copyWith(
      categoryName: category,
    ));
  }

  void onCategorySelected(ProductCategory category) {
    emit(state.copyWith(category: category));
  }

  void saveCategory() async {
    final id = await repository.insertCategory(ProductCategoriesCompanion(
      name: Value(state.categoryName),
    ));

    emit(state.copyWith(
      category: ProductCategory(id: id, name: state.categoryName),
    ));
  }

  void saveProduct() {
    if (state.category != null && state.productName.isNotEmpty) {
      repository.insertProduct(
        ProductsCompanion(
          categoryId: Value(state.category!.id),
          code: Value(state.productCode),
          name: Value(state.productName),
          discountPercentage: const Value(1),
          reorderLevel: const Value(0),
          unitInStock: Value(state.unitInStock),
        ),
      );
    } else {
      emit(state.copyWith(
        status: Status.failure,
      ));
    }
  }
}
