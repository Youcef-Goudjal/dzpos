import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                  "Login".toUpperCase(),
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
                          errorText:
                              state.email.invalid ? "invalid email" : null,
                          onChanged: loginCubit.emailChanged,
                          keyboardType: TextInputType.emailAddress,
                          prefix: const Icon(Icons.alternate_email_rounded),
                          hint: "Email Address",
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
                          hint: "Password",
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
                      context.goNamed(AppRoutes.forgotPasswort.routeName);
                    },
                    child: const Text("Forgot Password ?"),
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
                    child: const Text("Login"),
                  ),
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an Account ? ",
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "Register here!",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: context.theme.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.goNamed(AppRoutes.register.routeName);
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
