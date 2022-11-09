import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final InvoicesRepository repository = InvoicesRepositoryImpl();

  ProductCubit({ProductModel? product}) : super(const ProductState()) {
    if (product == null) {
      // if the product is null we create empty product
      repository.createEmptyProduct().then(
        (value) {
          emit(state.copyWith(
            product: value,
            state: ProductStatus.newProduct,
          ));
        },
      );
    } else {
      emit(state.copyWith(
        product: product,
        state: ProductStatus.updateProduct,
      ));
    }
  }

  void onNameChanged(String value) {
    final fullProduct = state.product;
    emit(
      state.copyWith(
        product: fullProduct.copyWith(
            product: fullProduct.product.copyWith(
          name: value,
        )),
      ),
    );
  }

  void onCodeChanged(String value) {
    final fullProduct = state.product;
    emit(
      state.copyWith(
        product: fullProduct.copyWith(
            product: fullProduct.product.copyWith(
                // code: Value(value),
                )),
      ),
    );
  }

  void onUnitInStockChanged(String value) {
    final fullProduct = state.product;
    final unitInStock = double.tryParse(value);
    if (unitInStock != null) {
      emit(
        state.copyWith(
          product: fullProduct.copyWith(
              product: fullProduct.product.copyWith(
            minimumToOrderInStock: unitInStock,
          )),
        ),
      );
    }
  }

  void onCategoryChanged(String category) {
    emit(state.copyWith(
      categoryName: category,
    ));
  }

  void onCategorySelected(ProductCategory? category) {
    final fullProduct = state.product;
    emit(
      state.copyWith(
        product: fullProduct.copyWith(
          category: category,
        ),
      ),
    );
  }

  void saveCategory() async {
    if (state.categoryName.isNotEmpty) {
      final id = await repository.insertCategory(ProductCategoriesCompanion(
        name: Value(state.categoryName),
      ));
      final category = ProductCategory(id: id, name: state.categoryName);
      final fullProduct = state.product;
      emit(
        state.copyWith(
          product: fullProduct.copyWith(
            category: category,
          ),
        ),
      );
    }
  }

  void removeUnit(int index) async {
    final fullProduct = state.product;
    List<ProductUnit> unitsList = [];
    unitsList.addAll(fullProduct.unitsList);
    unitsList.removeAt(index);
    await repository.removeUnit(fullProduct.unitsList[index].id);
    emit(
      state.copyWith(
        product: fullProduct.copyWith(
          unitsList: unitsList,
        ),
      ),
    );
  }

  void addEmptyUnit() {
    final fullProduct = state.product;
    List<ProductUnit> unitsList = [];
    unitsList.addAll([
      ...fullProduct.unitsList,
      emptyProductUnit,
    ]);

    emit(
      state.copyWith(
        product: fullProduct.copyWith(
          unitsList: unitsList,
        ),
      ),
    );
  }

  void onCodeUnitUpdated(int index, String input) {
    final fullProduct = state.product;
    List<ProductUnit> unitsList = [];
    unitsList.addAll(fullProduct.unitsList);
    unitsList.removeAt(index);
    unitsList.insert(index, fullProduct.unitsList[index].copyWith());

    emit(
      state.copyWith(
        product: fullProduct.copyWith(
          unitsList: unitsList,
        ),
      ),
    );
  }

  void onPriceUnitUpdated(int index, String input) {
    final fullProduct = state.product;
    final price = double.tryParse(input);

    if (price != null) {
      List<ProductUnit> unitsList = [];
      unitsList.addAll(fullProduct.unitsList);
      unitsList.removeAt(index);
      unitsList.insert(
          index,
          fullProduct.unitsList[index].copyWith(
              // price: price,
              ));

      emit(
        state.copyWith(
          product: fullProduct.copyWith(
            unitsList: unitsList,
          ),
        ),
      );
    }
  }

  void onBoxUnitUpdated(int index, String input) {
    final fullProduct = state.product;
    final box = double.tryParse(input);
    if (box != null) {
      List<ProductUnit> unitsList = [];
      unitsList.addAll(fullProduct.unitsList);
      unitsList.removeAt(index);
      unitsList.insert(
          index,
          fullProduct.unitsList[index].copyWith(
            box: box,
          ));

      emit(
        state.copyWith(
          product: fullProduct.copyWith(
            unitsList: unitsList,
          ),
        ),
      );
    }
  }

  void saveProduct() async {
    try {
      final product = state.product;
      if (product.isNotEmpty) {
        if (product.unitsList.isNotEmpty) {
          await repository.writeProduct(product);
          emit(state.copyWith(
            save: true,
            status: Status.success,
            msg: "product added successfully",
          ));
        } else {
          emit(state.copyWith(
            status: Status.failure,
            msg: "please add at least on unit",
          ));
        }
      } else {
        emit(state.copyWith(
          status: Status.failure,
          msg: "The product is empty",
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: Status.failure,
        msg: "Oops",
      ));
    }
  }

  @override
  Future<void> close() {
    if (!state.save) {
      if (state.productStatus.isNew) {
        repository.deleteProduct(state.product.productId);
      }
    }
    return super.close();
  }

  onUnitTypeChanged(int index, UnitType? value) {
    final fullProduct = state.product;

    List<ProductUnit> unitsList = [];
    unitsList.addAll(fullProduct.unitsList);
    unitsList.removeAt(index);
    unitsList.insert(
        index,
        fullProduct.unitsList[index].copyWith(
            // type: value,
            ));

    emit(
      state.copyWith(
        product: fullProduct.copyWith(
          unitsList: unitsList,
        ),
      ),
    );
  }

  void onBarCodeChanged(String input) {
    final fullProduct = state.product;
    emit(
      state.copyWith(
        product: fullProduct.copyWith(
          product: fullProduct.product.copyWith(
              // code: Value(input),
              ),
        ),
      ),
    );
  }
}
