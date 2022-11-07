import 'package:dzpos/application_layer/accounts/cubit/debt_cubit.dart';
import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';

class DebtPage extends StatelessWidget {
  final IsCreditor type;
  const DebtPage({super.key, IsCreditor? type}) : type = type ?? IsCreditor.all;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DebtCubit(accountsRepository, type.isPaying),
      child: BlocListener<DebtCubit, DebtState>(
        listener: (context, state) {
          statusHandler(context, state.status, msg: state.msg);
        },
        child: Builder(builder: (context) {
          final debtCubit = context.read<DebtCubit>();
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverList(
                    delegate: SliverChildListDelegate.fixed([
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                    ),
                    child: Center(child: Text(type.name)),
                  ),
                  BlocBuilder<DebtCubit, DebtState>(
                    builder: (context, state) {
                      return AccountCard(
                        initialValue: state.account?.name,
                        isCreditor: state.type,
                        onSelected: debtCubit.accountSelected,
                        onChangeNote: debtCubit.onDescChanged,
                        onChangedAmount: debtCubit.onAmountChanged,
                        onTypeChanged: debtCubit.onTypeChanged,
                        onSave: debtCubit.onSave,
                      );
                    },
                  ),
                ]))
              ],
              body: BlocBuilder<DebtCubit, DebtState>(
                buildWhen: (previous, current) =>
                    previous.debts != current.debts,
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const LoadingWidget();
                  }

                  if (state.debts.isEmpty) {
                    return const EmptyBoxWidget();
                  }
                  return ListView.separated(
                    itemCount: state.debts.length,
                    itemBuilder: (context, index) {
                      final debt = state.debts[index];
                      return ListTile(
                        onLongPress: () async {
                          final result = await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(LocaleKeys.delete_a_debt.tr()),
                                content: Text(LocaleKeys.delete_a_debt.tr()),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "yes");
                                    },
                                    child: Text(LocaleKeys.Yes.tr()),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "No");
                                    },
                                    child: Text(LocaleKeys.No.tr()),
                                  ),
                                ],
                              );
                            },
                          );
                          if (result == "Yes") {
                            debtCubit.onLongPressedTile(debt.id);
                          }
                        },
                        title: Text(
                          "${debt.amount}",
                          style: context.textTheme.titleLarge,
                        ),
                        leading: debt.isCredit
                            ? const Icon(
                                Icons.arrow_circle_up_outlined,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.arrow_circle_down_outlined,
                                color: Colors.red,
                              ),
                      );
                    },
                    separatorBuilder: (context, index) => 10.heightBox,
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
