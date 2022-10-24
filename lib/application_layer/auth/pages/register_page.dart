import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/manager/route/routes.dart';
import 'package:dzpos/product/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';
import '../utils.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(context.read()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<PhoneAuthBloc, PhoneAuthState>(
            listener: (context, state) {
              if (state is PhoneAuthCodeSentSuccess) {
                // navigate to otp page to verify the phone
                context.goNamed(AppRoutes.verifyOtp.name);
              }
            },
          ),
          BlocListener<RegisterCubit, RegisterState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              statusHandler(context, state.status, msg: state.msg);
            },
          )
        ],
        child: const Scaffold(
          appBar: KAppBar(),
          extendBodyBehindAppBar: true,
          body: _RegisterBody(),
        ),
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom,
        left: 24.w,
        right: 24.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: 250.h,
              fit: BoxFit.contain,
              image: const AssetImage(AppAssets.register),
            ),
            Text(
              LocaleKeys.register.tr().toUpperCase(),
              style: Theme.of(context).textTheme.headline3,
            ),
            24.h.heightBox,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.username != current.username,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: registerCubit.onUsernameChanged,
                      prefix: const Icon(Icons.person_outline),
                      hint: LocaleKeys.Username.tr(),
                      textInputAction: TextInputAction.done,
                      errorText: state.username.invalid
                          ? state.username.error.toString()
                          : null,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: registerCubit.onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                      prefix: const Icon(Icons.alternate_email_rounded),
                      hint: LocaleKeys.Email_Address.tr(),
                      textInputAction: TextInputAction.done,
                      errorText: state.email.invalid
                          ? state.email.error.toString()
                          : null,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.phone != current.phone,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: registerCubit.onPhoneChanged,
                      keyboardType: TextInputType.number,
                      prefix: const Icon(Icons.phone_outlined),
                      hint: LocaleKeys.Phone_Number.tr(),
                      errorText: state.phone.invalid
                          ? state.phone.error.toString()
                          : null,
                      textInputAction: TextInputAction.done,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.password != current.password,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: registerCubit.onPasswordChanged,
                      obscureText: true,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      suffix: const Icon(Icons.remove_red_eye_outlined),
                      hint: LocaleKeys.Password.tr(),
                      errorText: state.password.invalid
                          ? state.password.error.toString()
                          : null,
                      textInputAction: TextInputAction.done,
                    );
                  },
                ),
                20.h.heightBox,
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.confirmedPassword != current.confirmedPassword,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: registerCubit.onConfirmedPasswordChanged,
                      obscureText: true,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      suffix: const Icon(Icons.remove_red_eye_outlined),
                      hint: LocaleKeys.Confirme_Password.tr(),
                      errorText: state.confirmedPassword.invalid
                          ? state.confirmedPassword.error.toString()
                          : null,
                      textInputAction: TextInputAction.done,
                    );
                  },
                ),
              ],
            ),
            20.h.heightBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys
                            .register_By_signing_up_you_re_agree_to_our
                            .tr(),
                        style: Theme.of(context).textTheme.button,
                      ),
                      TextSpan(
                        text: LocaleKeys.register_TermsCondition.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: context.theme.primaryColor),
                      ),
                      TextSpan(
                        text: LocaleKeys.register_and.tr(),
                        style: Theme.of(context).textTheme.button,
                      ),
                      TextSpan(
                        text: LocaleKeys.register_privacy_Policy.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: context.theme.primaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: registerCubit.onRegisterTapped,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    child: Text(LocaleKeys.register.tr()),
                  ),
                ),
                24.h.heightBox,
              ],
            )
          ],
        ),
      ),
    );
  }
}
