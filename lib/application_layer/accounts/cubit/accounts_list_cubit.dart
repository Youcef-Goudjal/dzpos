import 'package:contacts_service/contacts_service.dart';
import 'package:drift/drift.dart';
import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/data/data.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

  void importFromContactsCustomers(BuildContext context) async {
    List<Contact>? customers = await showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          child: ContactSelector(),
        );
      },
    );
    //TODO insert into customers
    print("customers selected ${customers?.length}");
  }

  void importFromContactsSuppliers(BuildContext context) async {
    List<Contact>? suppliers = await showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          child: ContactSelector(),
        );
      },
    );
    //TODO insert into suppliers
    print("suppliers selected ${suppliers?.length}");
  }

  void refresh() async {
    final customers = await repository.allCustomers;
    final suppliers = await repository.allSuppliers;
    emit(state.copyWith(
      customers: customers,
      suppliers: suppliers,
    ));
  }
}

extension ContactExt on Contact {
  CustomersCompanion get toCustomer {
    return CustomersCompanion(
      name: Value(displayName ?? "Default"),
      contact: Value(phones!.first.value!),
      email: Value(emails?.first.value ?? "Default"),
      address: Value("${postalAddresses?.first.toString()}"),
    );
  }

  SuppliersCompanion get toSupplier {
    return SuppliersCompanion(
      name: Value(displayName ?? "Default"),
      contact: Value(phones!.first.value!),
      email: Value(emails?.first.value ?? "Default"),
      address: Value("${postalAddresses?.first.toString()}"),
    );
  }
}
