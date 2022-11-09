import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:drift/drift.dart';
import '../../application_layer.dart';
import '../../../core/enums.dart';
import '../../../core/services/database.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'accounts_list_state.dart';

class AccountsListCubit extends Cubit<AccountsListState> {
  AccountsRepository repository = AccountsRepositoryImpl();
  late StreamSubscription _subscriptionAccounts;
  AccountsListCubit() : super(const AccountsListState()) {
    _subscriptionAccounts = repository.watchAllAccounts.listen((value) {
      emit(state.copyWith(
        accounts: value,
      ));
    });
  }

  void importFromContactsAccounts(
      BuildContext context, AccountType type) async {
    List<Contact>? customers = await showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          child: ContactSelector(),
        );
      },
    );
    if (customers != null && customers.isNotEmpty) {
      repository.addMultipleAccounts(customers.map(
        (customerContact) {
          final String name = customerContact.displayName ?? "Default";
          final String? address =
              getListFirstElement(customerContact.postalAddresses)?.street;
          final String? contact =
              getListFirstElement(customerContact.phones)?.value;
          final String? email =
              getListFirstElement(customerContact.emails)?.value;

          ///
          return AccountsCompanion(
            name: Value(name),
            address: Value(address),
            contact: Value(contact),
            email: Value(email),
            accountType: Value(type),
          );
        },
      ).toList());
    }
  }

  void refresh() async {
    final customers = await repository.allAccounts;

    emit(state.copyWith(
      accounts: customers,
    ));
  }

  @override
  Future<void> close() {
    _subscriptionAccounts.cancel();

    return super.close();
  }
}

E? getListFirstElement<E>(List<E>? list) {
  if (list != null) {
    if (list.isNotEmpty) {
      return list.first;
    }
  }
  return null;
}
