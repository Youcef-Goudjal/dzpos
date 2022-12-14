import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/core.dart';
import '../../../product/product.dart';
import '../../application_layer.dart';

class VerifyOTPPage extends StatelessWidget {
  const VerifyOTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpCubit(context.read()),
      child: BlocListener<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneAuthError) {
            statusHandler(context, Status.failure, msg: state.error);
          }
          if (state is PhoneAuthVerified) {
            context.goNamed(AppRoutes.home.name);
          }
        },
        child: const Scaffold(
          appBar: KAppBar(),
          extendBodyBehindAppBar: true,
          body: _VerifyOTPBody(),
        ),
      ),
    );
  }
}

class _VerifyOTPBody extends StatelessWidget {
  const _VerifyOTPBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              LocaleKeys.verify_otp_Enter_OTP.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            10.h.heightBox,
            Text(
              LocaleKeys.register_TermsCondition.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            10.h.heightBox,
            const _OtpField(),
            10.h.heightBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.verify_otp_Dont_receive_code.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  TextSpan(
                    text: LocaleKeys.verify_otp_Send_again.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: context.theme.primaryColor),
                  ),
                ],
              ),
            ),
            24.h.heightBox,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: ElevatedButton(
                onPressed: context.read<VerifyOtpCubit>().onVerifyTapped,
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
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _OtpField extends StatelessWidget {
  const _OtpField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const errorColor = Color(0xFFB00020);
    final fillColor = context.theme.inputDecorationTheme.fillColor;
    final defaultPinTheme = PinTheme(
        width: 45.w,
        height: 59.h,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.transparent),
        ));
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: 60.h,
        child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
          buildWhen: (previous, current) => previous.otpCode != current.otpCode,
          builder: (context, state) {
            return Pinput(
              length: length,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyDecorationWith(
                border: Border.all(color: context.theme.primaryColor),
              ),
              errorPinTheme: defaultPinTheme.copyDecorationWith(
                color: errorColor,
              ),
              onChanged: context.read<VerifyOtpCubit>().onOTPCodeChanged,
              errorText: state.otpCode.invalid ? "otp invalid" : null,
            );
          },
        ),
      ),
    );
  }
}
