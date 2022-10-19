import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/manager/route/routes.dart';
import '../utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthBloc>()),
      child: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          statusHandler(context, state.status, msg: state.msg);
        },
        child: const _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
          left: 24.w,
          right: 24.w,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  width: context.width,
                  height: 250.h,
                  fit: BoxFit.contain,
                  image: const AssetImage(AppAssets.login),
                ),
                Text(
                  LocaleKeys.Login.tr().toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                ),
                10.h.heightBox,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.email != current.email,
                      builder: (context, state) {
                        return AppTextField(
                          errorText: state.email.invalid
                              ? "invalid email"
                              : null, //TODO: add tr()
                          onChanged: loginCubit.emailChanged,
                          keyboardType: TextInputType.emailAddress,
                          prefix: const Icon(Icons.alternate_email_rounded),
                          hint: LocaleKeys.Email_Address.tr(),
                          textInputAction: TextInputAction.next,
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.password != current.password,
                      builder: (context, state) {
                        return AppTextField(
                          onChanged: loginCubit.passwordChanged,
                          errorText: state.password.invalid
                              ? "${state.password.error}"
                              : null,
                          obscureText: true,
                          prefix: const Icon(Icons.lock_outline_rounded),
                          suffix: const Icon(Icons.remove_red_eye_outlined),
                          hint: LocaleKeys.Password.tr(),
                          textInputAction: TextInputAction.done,
                        );
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.goNamed(AppRoutes.forgotPassword.name);
                    },
                    child: Text(LocaleKeys.login_Forgot_Password.tr()),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      loginCubit.loggingTaped();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    child: Text(LocaleKeys.Login.tr()),
                  ),
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: LocaleKeys
                              .verify_otp_An_6_Digit_code_has_been_sent_to
                              .tr(args: ["0663519649"]),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: LocaleKeys.register.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: context.theme.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.goNamed(AppRoutes.register.name);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
