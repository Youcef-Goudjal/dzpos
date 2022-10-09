
import 'package:dzpos/core/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_of_products_state.dart';

class ListOfProductsCubit extends Cubit<ListOfProductsState> {
  ListOfProductsCubit() : super(ListOfProductsState());
}
