import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../../product/product.dart';
import '../../application_layer.dart';

class NewInvoicePage extends StatefulWidget {
  final InvoiceType type;
  const NewInvoicePage({
    super.key,
    this.type = InvoiceType.sales,
  });

  @override
  State<NewInvoicePage> createState() => _NewInvoicePageState();
}

class _NewInvoicePageState extends State<NewInvoicePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _showDialog());
  }

  Future _showDialog() async {
    final cubit = context.read<NewInvoiceCubit>();
    if (cubit.state.state.isNew) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return BlocProvider.value(
            value: cubit,
            child: const StartDialog(),
          );
        },
      ).then((value) {
        if (value != "Start") {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final newInvoiceCubit = context.read<NewInvoiceCubit>();
    return BlocListener<NewInvoiceCubit, NewInvoiceState>(
      listener: (context, state) {
        statusHandler(context, state.status, msg: state.msg);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => newInvoiceCubit.saveInvoice(context),
          child: const Icon(Icons.save),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
                  buildWhen: (previous, current) =>
                      previous.invoice.account != current.invoice.account,
                  builder: (context, state) {
                    return Text(
                        "${widget.type.name} ${LocaleKeys.To.tr()} ${state.invoice.account.name}");
                  },
                ),
                bottom: const _BottomAppBar(),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                15.h.heightBox,
                const _Header(),
                const _BodyInvoice(),
                const _TotalInvoice(),
                10.h.heightBox,
                const _ActionsInvoice(),
                5.h.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StartDialog extends StatelessWidget {
  const StartDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final newInvoiceCubit = context.read<NewInvoiceCubit>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: context.theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(LocaleKeys.Time.tr()),
                  Text(LocaleKeys.Date.tr()),
                  Text(LocaleKeys.Invoice.tr()),
                ],
              ),
            ),
            5.h.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        initialValue: newInvoiceCubit.state.state.isUpdating
                            ? formatDate(
                                newInvoiceCubit.state.invoice.dateRecorded)
                            : getTime(),
                      ),
                    ),
                    5.w.widthBox,
                    Expanded(
                        child: AppTextField(
                      initialValue: newInvoiceCubit.state.state.isUpdating
                          ? formatDate(
                              newInvoiceCubit.state.invoice.dateRecorded)
                          : getTime(),
                    )),
                    5.w.widthBox,
                    Expanded(
                        child: BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
                      builder: (context, state) {
                        return AppTextField(
                          initialValue:
                              "${newInvoiceCubit.state.invoice.invoiceId}",
                        );
                      },
                    )),
                  ],
                ),
              ),
            ),
            10.h.heightBox,
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: Ink(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.theme.colorScheme.primaryContainer,
                        ),
                        child: Icon(
                          Icons.list_alt_outlined,
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                    10.w.widthBox,
                    Expanded(
                      child: FutureBuilder<List<Account>>(
                        future: accountsRepository.allAccounts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState.isLoading) {
                            return const LoadingWidget();
                          }
                          final accounts = snapshot.data!;
                          if (accounts.isEmpty) {
                            return Text(LocaleKeys.No_account_fount.tr());
                          }
                          newInvoiceCubit.onAccountChanged(accounts.first);
                          return BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
                            buildWhen: (previous, current) =>
                                previous.invoice.account !=
                                current.invoice.account,
                            builder: (context, state) {
                              return DropdownButton<Account>(
                                value: state.invoice.account,
                                items: accounts
                                    .map(
                                      (e) => DropdownMenuItem<Account>(
                                        value: e,
                                        child: Center(child: Text(e.name)),
                                      ),
                                    )
                                    .toList(),
                                onChanged: newInvoiceCubit.onAccountChanged,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
              buildWhen: (previous, current) =>
                  previous.invoice.paymentType != current.invoice.paymentType,
              builder: (context, state) {
                return Column(
                  children: [
                    RadioListTile(
                      value: true,
                      groupValue:
                          state.invoice.paymentType == PaymentType.cache,
                      onChanged: newInvoiceCubit.onPaymentTypeChanged,
                      title: Text(LocaleKeys.Cash.tr()),
                    ),
                    RadioListTile(
                      value: false,
                      groupValue:
                          state.invoice.paymentType == PaymentType.cache,
                      onChanged: newInvoiceCubit.onPaymentTypeChanged,
                      title: Text(LocaleKeys.On_credit.tr()),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  child: Center(
                    child: Text(LocaleKeys.Start.tr()),
                  ),
                  onPressed: () {
                    newInvoiceCubit.onStart(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ActionsInvoice extends StatelessWidget {
  const _ActionsInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newInvoiceCubit = context.read<NewInvoiceCubit>();
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                newInvoiceCubit.printBluetooth(context);
              },
              icon: const Icon(Icons.bluetooth_audio),
              label: Text(
                LocaleKeys.Print_Bluetooth.tr(),
              ),
            ),
          ),
          10.w.widthBox,
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                newInvoiceCubit.printWifi(context);
              },
              icon: const Icon(Icons.print_outlined),
              label: Text(LocaleKeys.Print_wifi.tr()),
            ),
          ),
          10.w.widthBox,
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                context.replaceNamed(
                  AppRoutes.newInvoice.name,
                  params: <String, String>{
                    'type': InvoiceType.purchase.name,
                    'action': InvoiceActions.insert.index.toString(),
                  },
                );
              },
              icon: const Icon(Icons.new_label_outlined),
              label: Text(LocaleKeys.New_Invoice.tr()),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalInvoice extends StatelessWidget {
  const _TotalInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: context.theme.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
        builder: (context, state) {
          return Row(
            children: [
              Text(
                "Total : ${formatCurrency(state.invoice.total)}DZ",
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
              Text(
                "${LocaleKeys.Quantity.tr()} : ${state.invoice.totalQuantity}",
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BodyInvoice extends StatelessWidget {
  const _BodyInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewInvoiceCubit>();

    return BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
      buildWhen: (previous, current) =>
          previous.invoice.sales != current.invoice.sales,
      builder: (context, state) {
        final sales = state.invoice.sales;
        if (sales.isEmpty) {
          return const Expanded(child: EmptyBoxWidget());
        }

        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              try {
                return Dismissible(
                    background: Container(color: context.error),
                    onDismissed: ((direction) async {
                      final result = await confirmDeleteDialog(context,
                          msg:
                              "deleting ${state.invoice.sales[index].productName}");
                      if (result == "Yes") {
                        cubit.removeSale(index);
                      }
                    }),
                    key: UniqueKey(),
                    child: BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
                      buildWhen: (p, c) {
                        if (p.type.isPurchaseOrPurchaseReturn) {
                          return p.invoice.sales[index].purchaseSubTotal !=
                              c.invoice.sales[index].purchaseSubTotal;
                        } else {
                          return p.invoice.sales[index].saleSubTotal !=
                              c.invoice.sales[index].saleSubTotal;
                        }
                      },
                      builder: (context, local) {
                        final sale = local.invoice.sales[index];

                        return SizedBox(
                          height: 150,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(sale.productName),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              backgroundColor:
                                                  context.secondaryColor,
                                              alignment: Alignment.center,
                                            ),
                                            onPressed: () {
                                              cubit.onIncreaseQuantityOnSale(
                                                  index);
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: context.onSecondaryColor,
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              backgroundColor: context.error,
                                              alignment: Alignment.center,
                                            ),
                                            onPressed: () {
                                              cubit.onDecreaseQuantityOnSale(
                                                  index);
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: context.onError,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AppTextField(
                                          isDense: true,
                                          initialValue:
                                              "${local.type.isPurchaseOrPurchaseReturn ? sale.purchaseSubTotal : sale.saleSubTotal}",
                                          enabled: false,
                                          hint: "SubTotal",
                                          // onChanged: (input,
                                        ),
                                      ),
                                      5.widthBox,
                                      Expanded(
                                          child: AppTextField(
                                        isDense: true,
                                        initialValue:
                                            "${local.type.isPurchaseOrPurchaseReturn ? sale.purchasePrice : sale.salePrice}",
                                        hint: "Price",
                                        onChanged: (value) => cubit
                                            .onPriceChangedOnSale(index, value),
                                      )),
                                      5.widthBox,
                                      Expanded(
                                        child: DropdownButton<int>(
                                          value: sale.unit.id,
                                          isExpanded: true,
                                          items:
                                              sale.product.unitsList.map((e) {
                                            return DropdownMenuItem<int>(
                                              value: e.id,
                                              child: FittedBox(
                                                child: Text(
                                                  formatCurrency(
                                                    local.type
                                                            .isPurchaseOrPurchaseReturn
                                                        ? e.purchasePrice
                                                        : e.salePrice,
                                                  ),
                                                  style: const TextStyle(
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            cubit.onUnitChangedOnSale(
                                              index,
                                              value ?? 0,
                                            );
                                          },
                                        ),
                                      ),
                                      5.widthBox,
                                      Expanded(
                                          child: AppTextField(
                                        isDense: true,
                                        initialValue: "${sale.quantity}",
                                        hint: "Quantity",
                                        onChanged: (value) =>
                                            cubit.onQuantityChangedOnSale(
                                                index, value),
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ));
              } on Exception {
                return const Text("...");
              }
            },
            separatorBuilder: (context, index) => 10.heightBox,
            itemCount: sales.length,
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: context.theme.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Amount"),
            Text("Unit"),
            Text("Retail"),
            Text("Total"),
          ],
        ),
      ),
    );
  }
}

class _BottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _BottomAppBar();

  @override
  Widget build(BuildContext context) {
    final newInvoiceCubit = context.read<NewInvoiceCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        10.w.widthBox,
        InkWell(
            onTap: () {}, //TODO: scan barcode
            child: Center(child: SvgPicture.asset(AppAssets.barcode))),
        10.w.widthBox,
        Expanded(
          child: SizedBox(
            height: 50,
            child: AppTextField(
              isDense: true,
              hint: "Enter the product name",
            ),
          ),
        ),
        10.w.widthBox,
        Center(
          child: IconButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, animation, secondaryAnimation) {
                      return BlocProvider.value(
                        value: newInvoiceCubit,
                        child: const ProductsPage(),
                      );
                    },
                    transitionsBuilder:
                        (_, animation, secondaryAnimation, child) {
                      const begin = Offset(1, 0);
                      const end = Offset.zero;
                      const curve = Curves.bounceInOut;
                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ));
            },
            icon: const Icon(Icons.image_outlined),
          ),
        ),
        10.w.widthBox,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
