import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dept_list_state.dart';

class DeptListCubit extends Cubit<DeptListState> {
  DeptListCubit() : super(DeptListInitial());
}
