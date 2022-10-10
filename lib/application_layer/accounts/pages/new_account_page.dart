import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/services/database.dart';

class NewAccountPage extends StatelessWidget {
  final Customer? customer;
  final Supplier? supplier;
  const NewAccountPage({super.key, this.customer, this.supplier});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewAccountCubit(
        customer: customer,
        supplier: supplier,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New Account"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: context.read<NewAccountCubit>().save,
          child: const Icon(Icons.save),
        ),
        body: const _NewAccountBody(),
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
                    previous.isCustomer != current.isCustomer,
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.isCustomer
                                ? context.theme.primaryColor
                                : null,
                          ),
                          onPressed: newAccountCubit.onChangeIsCustomer,
                          child: const Text("Customer"),
                        ),
                      ),
                      15.w.widthBox,
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !state.isCustomer
                                ? context.theme.primaryColor
                                : null,
                          ),
                          onPressed: newAccountCubit.onChangeIsSupplier,
                          child: const Text("Supplier"),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            15.h.heightBox,
            AppTextField(
              hint: "Id",
              enabled: false,
            ),
            15.h.heightBox,
            AppTextField(
              onChanged: newAccountCubit.onChangeCode,
              hint: "Barcode",
            ),
            15.h.heightBox,
            AppTextField(
              onChanged: newAccountCubit.onChangeName,
              hint: "Name",
            ),
            15.h.heightBox,
            AppTextField(
              onChanged: newAccountCubit.onChangeContact,
              hint: "Contact",
            ),
            15.h.heightBox,
            AppTextField(
              onChanged: newAccountCubit.onChangeAddress,
              hint: "@",
            )
          ],
        ),
      ),
    );
  }
}
