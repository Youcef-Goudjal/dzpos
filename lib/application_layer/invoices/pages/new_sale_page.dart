import 'package:drift/drift.dart' hide Column;
import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/application_layer/invoices/cubit/invoice_cubit.dart';
import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NewSalePage extends StatefulWidget {
  const NewSalePage({super.key});

  @override
  State<NewSalePage> createState() => _NewSalePageState();
}

class _NewSalePageState extends State<NewSalePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _showDialog());
  }

  late int invoiceId;
  Future _showDialog() async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StartDialog();
      },
    );
    if (result != null) {
      invoiceId = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceCubit(invoiceId),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                title: Text("New Sale"),
                bottom: _BottomAppBar(),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                15.h.heightBox,
                const _header(),
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
    paymentType = widget.paymentType;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                    initialValue: "${widget.date.hour}-${widget.date.minute}",
                  )),
                  5.w.widthBox,
                  Expanded(
                      child: AppTextField(
                    initialValue: "${widget.date.day}-${widget.date.month}",
                  )),
                  5.w.widthBox,
                  Expanded(
                    child: AppTextField(
                      initialValue: "${widget.invoiceId}",
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
                        color: context.theme.colorScheme.secondary,
                      ),
                      child: Icon(
                        Icons.list_alt_outlined,
                        color: context.theme.colorScheme.onSecondary,
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
                                  child: Text(e.name),
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
            value: false,
            groupValue: widget.paymentType == PaymentType.cache,
            onChanged: (value) {
              paymentType = PaymentType.cache;
              setState(() {});
            },
            title: const Text("Cash"),
          ),
          RadioListTile(
            value: false,
            groupValue: widget.paymentType == PaymentType.cache,
            onChanged: (value) {
              paymentType = PaymentType.credit;
              setState(() {});
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
                  if (widget.currentAccount != null ||
                      widget.paymentType != null) {
                    final id = await invoicesRepository.startInvoice(
                      InvoicesCompanion(
                        userId: const Value(0),
                        customerId: Value(widget.currentAccount!.id),
                        amountTendered: const Value(0),
                        paymentType: Value(widget.paymentType!),
                        totalAmount: const Value(0),
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, id);
                  }
                },
              ),
            ),
          )
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
              onPressed: () {},
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
      child: const Center(
        child: Text("Total : 10"),
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

class _header extends StatelessWidget {
  const _header({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        10.w.widthBox,
        Center(child: SvgPicture.asset(AppAssets.barcode)),
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
            onPressed: () {},
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
