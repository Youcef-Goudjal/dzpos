import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/repositories/repositories.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final InvoicesRepository repository = InvoicesRepositoryImpl();
  ProductCubit() : super(const ProductState());

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

  void onMinimChanged(String value) {
    emit(state.copyWith(
      minimum: double.tryParse(value),
    ));
  }

  void onPurchasePriceChanged(String value) {
    emit(state.copyWith(
      purchasePrice: double.tryParse(value),
    ));
  }

  void onSalePriceChanged(String value) {
    emit(state.copyWith(
      salePrice: double.tryParse(value),
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
    if (state.categoryName.isNotEmpty) {
      await repository.insertCategory(state.categoryName);
      emit(state.copyWith(
        categoryName: "",
        status: Status.success,
      ));
    }
  }

  void saveProduct() {
    if (state.productName.isEmpty ||
        state.category == null ||
        state.productCode.isEmpty) {
      emit(state.copyWith(
        status: Status.failure,
      ));
    } else {
      repository.insertProduct(
        barcode: state.productCode,
        categoryId: state.category!.categoryId,
        minInStock: state.minimum,
        name: state.productName,
        purchasePrice: state.purchasePrice,
        salePrice: state.salePrice,
      );
    }
  }

  Stream<List<ProductCategory>> allCategories() {
    return repository.watchAllCategories();
  }
}
