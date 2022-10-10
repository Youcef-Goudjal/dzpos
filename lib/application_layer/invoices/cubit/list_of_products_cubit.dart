import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/database.dart';

part 'list_of_products_state.dart';

class ListOfProductsCubit extends Cubit<ListOfProductsState> {
  ListOfProductsCubit() : super(const ListOfProductsState());
  final invoicesDao = CommonBloc.invoicesDao;

  
}
