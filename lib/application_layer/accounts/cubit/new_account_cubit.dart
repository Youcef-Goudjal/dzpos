import 'package:drift/drift.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_account_state.dart';

class NewAccountCubit extends Cubit<NewAccountState> {
  final AccountsRepository repository = AccountsRepositoryImpl();
  final Customer? customer;
  final Supplier? supplier;
  NewAccountCubit({this.customer, this.supplier})
      : super(const NewAccountState()) {
    emit(state.copyWith(
      name: customer?.name ?? supplier?.name,
      code: customer?.code ?? supplier?.code,
      address: customer?.address ?? supplier?.address,
      contact: customer?.contact ?? supplier?.contact,
      isCustomer: customer == null
          ? supplier == null
              ? false
              : true
          : true,
    ));
  }

  onChangeIsCustomer() {
    emit(state.copyWith(
      isCustomer: true,
    ));
  }

  onChangeIsSupplier() {
    emit(state.copyWith(
      isCustomer: false,
    ));
  }

  onChangeCode(String code) {
    emit(state.copyWith(
      code: code,
    ));
  }

  onChangeName(String name) {
    emit(state.copyWith(
      name: name,
    ));
  }

  onChangeContact(String contact) {
    emit(state.copyWith(
      contact: contact,
    ));
  }

  onChangeAddress(String address) {
    emit(state.copyWith(
      address: address,
    ));
  }

  void save() {
    // if(name is not empty)
    if (state.name.isEmpty) {
      emit(state.copyWith(
        status: Status.failure,
      ));
    } else {
      if (state.isCustomer) {
        repository.addCustomer(
          CustomersCompanion(
            name: Value(state.name),
            address: Value(state.address),
            contact: Value(state.contact),
            code: Value(state.code),
          ),
        );
      } else {
        // else means its a supplier
        repository.addSupplier(
          SuppliersCompanion(
            name: Value(state.name),
            address: Value(state.address),
            contact: Value(state.contact),
            code: Value(state.code),
          ),
        );
      }
    }
  }
}
