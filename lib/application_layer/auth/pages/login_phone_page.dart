import '../../../core/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/language/locale_keys.g.dart';
import '../../../core/manager/route/routes.dart';
import '../../../product/product.dart';
import '../../application_layer.dart';

class LoginPhonePage extends StatelessWidget {
  const LoginPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPhoneCubit(context.read()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<PhoneAuthBloc, PhoneAuthState>(
            listener: (context, state) {
              if (state is PhoneAuthCodeSentSuccess) {
                context.goNamed(AppRoutes.verifyOtp.name);
              }
              if (state is PhoneAuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(
                        color: context.theme.colorScheme.onError,
                      ),
                    ),
                    backgroundColor: context.theme.errorColor,
                  ),
                );
              }
            },
          ),
        ],
        child: const Scaffold(
          appBar: KAppBar(),
          extendBodyBehindAppBar: true,
          body: _LoginPhoneBody(),
        ),
      ),
    );
  }
}

class _LoginPhoneBody extends StatelessWidget {
  const _LoginPhoneBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginPhoneCubit = context.read<LoginPhoneCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
          left: 24.w,
          right: 24.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: 250.h,
              fit: BoxFit.contain,
              image: const AssetImage(AppAssets.otp),
            ),
            24.h.heightBox,
            Text(
              LocaleKeys.login_phone_Enter_Ur_Phone_number.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            10.h.heightBox,
            Text(
              LocaleKeys.login_phone_a_6_Digit_code_will_be_sent_to_ur_phone_number.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            10.h.heightBox,
            BlocBuilder<LoginPhoneCubit, LoginPhoneState>(
              buildWhen: (previous, current) => previous.phone != current.phone,
              builder: (context, state) {
                return AppTextField(
                  onChanged: loginPhoneCubit.onPhoneChanged,
                  prefix: const Icon(Icons.phone),
                  keyboardType: TextInputType.number,
                  hint: LocaleKeys.Phone_Number.tr(),
                  textInputAction: TextInputAction.done,
                  errorText:
                      state.phone.invalid ? state.phone.error.toString() : null,
                );
              },
            ),
            24.h.heightBox,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: ElevatedButton(
                onPressed: loginPhoneCubit.onSendTapped,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child:  Text(LocaleKeys.login_phone_Send.tr()),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
