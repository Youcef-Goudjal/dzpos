import 'package:drift/drift.dart' hide Column;
import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/route/routes.dart';

enum InvoiceType {
  sell,
  buy;

  String get name {
    switch (this) {
      case InvoiceType.buy:
        return "Purchase";
      case InvoiceType.sell:
        return "Sell";
    }
  }
}

class NewInvoicePage extends StatefulWidget {
  final InvoiceType type;
  const NewInvoicePage({super.key, this.type = InvoiceType.sell});

  @override
  State<NewInvoicePage> createState() => _NewInvoicePageState();
}

class _NewInvoicePageState extends State<NewInvoicePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _showDialog());
  }

  int? invoiceId;
  Account? account;
  Future _showDialog() async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StartDialog();
      },
    );
    if (result != null) {
      invoiceId = result[0];
      account = result[1];
      setState(() {});
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (invoiceId != null) {
      return BlocProvider(
        create: (context) => NewInvoiceCubit(
          invoicesRepository: invoicesRepository,
          account: account!,
          invoiceId: invoiceId!,
          type: widget.type,
        ),
        child: Builder(builder: (context) {
          final newInvoiceCubit = context.read<NewInvoiceCubit>();
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                        "${widget.type.name} to ${newInvoiceCubit.state.account.name}"),
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
          );
        }),
      );
    }
    return Container(
      color: context.colorScheme.primaryContainer,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class StartDialog extends StatefulWidget {
  final int? invoiceId;
  final Account? currentAccount;
  final PaymentType? paymentType;
  StartDialog({
    Key? key,
    this.currentAccount,
    this.paymentType,
    this.invoiceId,
    DateTime? date,
  })  : date = date ?? DateTime.now(),
        super(key: key);

  final DateTime date;

  @override
  State<StartDialog> createState() => _StartDialogState();
}

class _StartDialogState extends State<StartDialog> {
  Account? currentAccount;
  PaymentType? paymentType;
  @override
  void initState() {
    super.initState();
    currentAccount = widget.currentAccount;
    paymentType = widget.paymentType ?? PaymentType.cache;
    payment = paymentType == PaymentType.cache;
  }

  bool isLoading = false;

  /// true => payment.cache /else false => payment.credit
  late bool payment;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          ListView(
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
                  children: const [
                    Text("Time"),
                    Text("Date"),
                    Text("Invoice"),
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
                        initialValue:
                            "${widget.date.hour}-${widget.date.minute}",
                      )),
                      5.w.widthBox,
                      Expanded(
                          child: AppTextField(
                        initialValue: "${widget.date.day}-${widget.date.month}",
                      )),
                      5.w.widthBox,
                      Expanded(
                        child: AppTextField(
                          initialValue: "${widget.invoiceId ?? ""}",
                        ),
                      ),
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
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final accounts = snapshot.data!;
                            return DropdownButton<Account>(
                              value: currentAccount,
                              items: accounts
                                  .map(
                                    (e) => DropdownMenuItem<Account>(
                                      value: e,
                                      child: Center(child: Text(e.name)),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                currentAccount = value;
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: payment,
                onChanged: (value) {
                  setState(() {
                    paymentType = PaymentType.cache;
                    payment = true;
                  });
                  print("payment $paymentType");
                },
                title: const Text("Cash"),
              ),
              RadioListTile(
                value: false,
                groupValue: payment,
                onChanged: (value) {
                  setState(() {
                    paymentType = PaymentType.credit;
                    payment = false;
                  });
                  print("payment $paymentType");
                },
                title: const Text("On credit"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    child: const Center(
                      child: Text("Start"),
                    ),
                    onPressed: () async {
                      if (currentAccount != null || paymentType != null) {
                        setState(() {
                          isLoading = true;
                        });
                        final id = await invoicesRepository.createEmptyInvoice(
                          
                        );
                        setState(() {
                          isLoading = false;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, [id, currentAccount]);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink()
        ],
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
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bluetooth_audio),
              label: const Text(
                "Print Bluetooth",
              ),
            ),
          ),
          10.w.widthBox,
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.print_outlined),
              label: const Text("Print wifi"),
            ),
          ),
          10.w.widthBox,
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                context.replaceNamed(
                  AppRoutes.newInvoice.name,
                  extra: InvoiceType.sell,
                );
              },
              icon: const Icon(Icons.new_label_outlined),
              label: const Text("New Invoice"),
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
      height: 20,
      decoration: BoxDecoration(
        color: context.theme.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: BlocBuilder<NewInvoiceCubit, NewInvoiceState>(
        builder: (context, state) {
          return Center(
            child: Text("Total : ${state.sales.length}"),
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
    return Expanded(child: ListView());
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
        children: const [
          Text("Amount"),
          Text("Unit"),
          Text("Retail"),
          Text("Total"),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final String title;
  const _Button({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(icon),
            Text(title),
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
            onTap: () {},
            child: Center(child: SvgPicture.asset(AppAssets.barcode))),
        10.w.widthBox,
        Expanded(
          child: SizedBox(
            height: 50,
            child: AppTextField(
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
