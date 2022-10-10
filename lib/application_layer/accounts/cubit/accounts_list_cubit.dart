import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'accounts_list_state.dart';

class AccountsListCubit extends Cubit<AccountsListState> {
  AccountsRepository repository = AccountsRepositoryImpl();
  AccountsListCubit() : super(const AccountsListState()) {
    repository.allCustomers.then((value) {
      emit(state.copyWith(
        customers: value,
      ));
    });
    repository.allSuppliers.then((value) {
      emit(state.copyWith(
        suppliers: value,
      ));
    });
  }

  void importFromContacts() {}

  void refresh() async {
    final customers = await repository.allCustomers;
    final suppliers = await repository.allSuppliers;
    emit(state.copyWith(
      customers: customers,
      suppliers: suppliers,
    ));
  }
}
