import 'package:dzpos/application_layer/auth/utils.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../application_layer.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(context.read()),
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          statusHandler(context, state.status, msg: state.msg);
        },
        child: const Scaffold(
          appBar: KAppBar(),
          extendBodyBehindAppBar: true,
          body: _ResetPasswordBody(),
        ),
      ),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  const _ResetPasswordBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = context.read<ResetPasswordCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
          left: 24.w,
          right: 24.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: 300.h,
              fit: BoxFit.contain,
              image: const AssetImage(AppAssets.resetPassword),
            ),
            Text(
              LocaleKeys.reset_password.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            15.h.heightBox,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.code != current.code,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: resetPasswordCubit.codeChanged,
                      errorText:
                          state.code.invalid ? state.code.error!.name : null,
                      prefix: const Icon(Icons.lock),
                      hint: LocaleKeys.reset_password_Code.tr(),
                      textInputAction: TextInputAction.next,
                    );
                  },
                ),
                SizedBox(height: 15.h),
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.newPassword != current.newPassword,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: resetPasswordCubit.passwordChanged,
                      obscureText: true,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      hint: LocaleKeys.reset_password_New_Password.tr(),
                      suffix: const Icon(Icons.remove_red_eye_outlined),
                      textInputAction: TextInputAction.next,
                      errorText: state.newPassword.invalid
                          ? state.newPassword.error.toString()
                          : null,
                    );
                  },
                ),
                SizedBox(height: 15.h),
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.confirmedPassword != current.confirmedPassword,
                  builder: (context, state) {
                    return AppTextField(
                      onChanged: resetPasswordCubit.confirmPasswordChanged,
                      obscureText: true,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      hint: LocaleKeys.Confirme_Password.tr(),
                      suffix: const Icon(Icons.remove_red_eye_outlined),
                      textInputAction: TextInputAction.done,
                      errorText: state.newPassword.invalid
                          ? state.confirmedPassword.error.toString()
                          : null,
                    );
                  },
                ),
              ],
            ),
            15.h.heightBox,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: ElevatedButton(
                onPressed: resetPasswordCubit.resetTapped,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child: Text(LocaleKeys.Submit.tr()),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
