import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application_layer.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(context.read()),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          statusHandler(context, state.status, msg: state.msg);
        },
        child: const Scaffold(
          appBar: KAppBar(),
          extendBodyBehindAppBar: true,
          body: _ForgotPasswordBody(),
        ),
      ),
    );
  }
}

class _ForgotPasswordBody extends StatelessWidget {
  const _ForgotPasswordBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forgotPasswordCubit = context.read<ForgotPasswordCubit>();
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom,
        left: 24,
        right: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: 300.h,
              fit: BoxFit.contain,
              image: const AssetImage(AppAssets.forgotPassword),
            ),
            Text(
              "Forgot\nPassword",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Don't worry! It happens. Please enter the email that associated with yout Account.",
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: Colors.grey),
            ),
            10.h.heightBox,
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return AppTextField(
                  onChanged: forgotPasswordCubit.emailChanged,
                  errorText:
                      state.email.invalid ? "${state.email.error}" : null,
                  prefix: const Icon(Icons.alternate_email_rounded),
                  hint: "Email Address",
                  textInputAction: TextInputAction.done,
                );
              },
            ),
            20.h.heightBox,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: ElevatedButton(
                onPressed: forgotPasswordCubit.sendTapped,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child: const Text("Submit"),
              ),
            ),
            20.h.heightBox,
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
