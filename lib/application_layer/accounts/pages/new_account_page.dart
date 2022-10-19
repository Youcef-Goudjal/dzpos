import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/services/database.dart';

class NewAccountPage extends StatelessWidget {
  final Account? account;

  const NewAccountPage({super.key, this.account});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewAccountCubit(
        account: account,
      ),
      child: BlocListener<NewAccountCubit, NewAccountState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          statusHandler(context, state.status, msg: state.msg);
        },
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(((account != null)
                      ? LocaleKeys.Updating.tr()
                      : LocaleKeys.New.tr()) +
                  LocaleKeys.Account.tr()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: context.read<NewAccountCubit>().save,
              child: const Icon(Icons.save),
            ),
            body: const _NewAccountBody(),
          );
        }),
      ),
    );
  }
}

class _NewAccountBody extends StatelessWidget {
  const _NewAccountBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newAccountCubit = context.read<NewAccountCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              child: BlocBuilder<NewAccountCubit, NewAccountState>(
                buildWhen: (previous, current) =>
                    previous.accountType != current.accountType,
                builder: (context, state) {
                  return Center(
                    child: Row(
                      children: List.generate(
                        AccountType.values.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () =>
                                newAccountCubit.onChangeIsAccountType(
                              AccountType.values[index],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AccountType.values[index] == state.accountType
                                      ? context.secondaryColor
                                      : null,
                            ),
                            child: Center(
                              child: Text(
                                AccountType.values[index]
                                    .toString()
                                    .split(".")
                                    .last,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            15.h.heightBox,
            BlocBuilder<NewAccountCubit, NewAccountState>(
              buildWhen: (previous, current) => previous.id != current.id,
              builder: (context, state) {
                return AppTextField(
                  initialValue: newAccountCubit.state.id,
                  hint: "Id",
                  enabled: false,
                );
              },
            ),
            15.h.heightBox,
            BlocBuilder<NewAccountCubit, NewAccountState>(
              buildWhen: (previous, current) => previous.code != current.code,
              builder: (context, state) {
                return AppTextField(
                  initialValue: newAccountCubit.state.code,
                  onChanged: newAccountCubit.onChangeCode,
                  hint: "Barcode",
                );
              },
            ),
            15.h.heightBox,
            BlocBuilder<NewAccountCubit, NewAccountState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, state) {
                return AppTextField(
                  initialValue: newAccountCubit.state.name,
                  onChanged: newAccountCubit.onChangeName,
                  hint: LocaleKeys.Name.tr(),
                );
              },
            ),
            15.h.heightBox,
            BlocBuilder<NewAccountCubit, NewAccountState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return AppTextField(
                  initialValue: newAccountCubit.state.email,
                  onChanged: newAccountCubit.onChangeEmail,
                  hint: LocaleKeys.Email_Address.tr(),
                );
              },
            ),
            15.h.heightBox,
            BlocBuilder<NewAccountCubit, NewAccountState>(
              buildWhen: (previous, current) =>
                  previous.contact != current.contact,
              builder: (context, state) {
                return AppTextField(
                  initialValue: newAccountCubit.state.contact,
                  keyboardType: TextInputType.number,
                  onChanged: newAccountCubit.onChangeContact,
                  hint: LocaleKeys.Contact.tr(),
                );
              },
            ),
            15.h.heightBox,
            BlocBuilder<NewAccountCubit, NewAccountState>(
              buildWhen: (previous, current) =>
                  previous.address != current.address,
              builder: (context, state) {
                return AppTextField(
                  initialValue: newAccountCubit.state.address,
                  onChanged: newAccountCubit.onChangeAddress,
                  maxLine: 3,
                  hint: "@",
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
