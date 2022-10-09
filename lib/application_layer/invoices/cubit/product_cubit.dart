import 'package:dzpos/core/enums.dart';
import 'package:dzpos/data/repositories/repositories.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final InvoicesRepository repository = InvoicesRepositoryImpl();
  ProductCubit() : super(const ProductState());

  void onNameChanged(String value) {}
  void onCategoryChanged(int categoryId) {}
}
