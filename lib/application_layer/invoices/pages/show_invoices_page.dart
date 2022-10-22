import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/manager/route/routes.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common_blocs/printer/printer_bloc.dart';
import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';

class ShowInvoicesPage extends StatelessWidget {
  const ShowInvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowInvoicesCubit(invoicesRepository),
      child: const _ShowInvoicesBody(),
    );
  }
}

class _ShowInvoicesBody extends StatelessWidget {
  const _ShowInvoicesBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShowInvoicesCubit>();
    return BlocListener<ShowInvoicesCubit, ShowInvoicesState>(
      listener: (context, state) {
        statusHandler(context, state.status, msg: state.msg);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.invoices_List.tr()),
        ),
        floatingActionButton: BlocBuilder<ShowInvoicesCubit, ShowInvoicesState>(
          builder: (context, state) {
            if (state.checkedInvoices.isEmpty) {
              return const SizedBox.shrink();
            }
            return FloatingActionButton(
              onPressed: () {
                cubit.removeAllSelected();
              },
              backgroundColor: context.error,
              child: Icon(
                Icons.delete,
                color: context.onError,
              ),
            );
          },
        ),
        body: BlocBuilder<ShowInvoicesCubit, ShowInvoicesState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.invoices.isEmpty) {
              return Center(
                child: Text(LocaleKeys.No_Invoice.tr()),
              );
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return _InvoiceCard(index: index);
                },
                separatorBuilder: (context, index) => 10.heightBox,
                itemCount: state.invoices.length,
              );
            }
          },
        ),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShowInvoicesCubit>();
    final invoice = cubit.state.invoices[index];
    return SizedBox(
      height: 200,
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            _TopCard(invoice: invoice, cubit: cubit),
            _BodyCard(invoice: invoice),
            _ActionsCard(index: index, invoice: invoice)
          ],
        ),
      ),
    );
  }
}

class _ActionsCard extends StatelessWidget {
  const _ActionsCard({
    Key? key,
    required this.invoice,
    required this.index,
  }) : super(key: key);
  final int index;
  final FullInvoice invoice;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShowInvoicesCubit>();
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {
            context.pushNamed(
              AppRoutes.newInvoice.name,
              params: <String, String>{'type': InvoiceType.sell.name},
              extra: invoice,
            );
          },
          icon: const Icon(Icons.edit),
          label: Text(LocaleKeys.Update.tr()),
        ),
        TextButton.icon(
          onPressed: () {
            CommonBloc.printerBloc.add(PrintRequested(invoice));
            context.pushNamed(AppRoutes.printingPreview.name);
          },
          icon: const Icon(Icons.print),
          label: Text(LocaleKeys.Print.tr()),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(),
          onPressed: () {
            cubit.deleteInvoice(index);
          },
          icon: Icon(
            Icons.delete_forever,
            color: context.error,
          ),
          label: Text(
            LocaleKeys.Delete.tr(),
            style: context.textTheme.titleSmall!.copyWith(
              color: context.error,
            ),
          ),
        ),
      ],
    );
  }
}

class _BodyCard extends StatelessWidget {
  const _BodyCard({
    Key? key,
    required this.invoice,
  }) : super(key: key);
  final FullInvoice invoice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Sale in ${invoice.paymentType.name} n°.${invoice.invoiceId}",
                style: context.textTheme.titleMedium,
              ),
              Text(invoice.date2)
            ],
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Total",
                style: context.textTheme.titleSmall,
              ),
              (invoice.paymentType == PaymentType.credit)
                  ? Text(
                      "Treated",
                      style: context.textTheme.titleSmall,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${invoice.total}",
                style: context.textTheme.titleLarge,
              ),
              (invoice.paymentType == PaymentType.credit)
                  ? Text(
                      "${invoice.amountTendered}",
                      style: context.textTheme.titleLarge,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ],
      ),
    );
  }
}

class _TopCard extends StatelessWidget {
  const _TopCard({
    Key? key,
    required this.invoice,
    required this.cubit,
  }) : super(key: key);

  final FullInvoice invoice;
  final ShowInvoicesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: context.colorScheme.primaryContainer,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  invoice.name,
                  style: context.textTheme.titleLarge,
                ),
              ),
            ),
            BlocBuilder<ShowInvoicesCubit, ShowInvoicesState>(
              builder: (context, state) {
                return SizedBox(
                  height: 40,
                  width: 40,
                  child: Checkbox(
                    value: state.checkedInvoices[invoice.invoiceId] ?? false,
                    activeColor: context.primaryColor,
                    onChanged: (value) {
                      cubit.checkInvoice(invoice.invoiceId, value!);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
