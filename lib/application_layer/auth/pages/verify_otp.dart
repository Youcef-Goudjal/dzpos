import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class VerifyOTPPage extends StatelessWidget {
  const VerifyOTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            // color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
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
                "Enter OTP",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              10.h.heightBox,
              Text(
                "An 6 Digit code has been sent to \n +2130663519649",
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
                      text: "Don't receive code ? ",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    TextSpan(
                      text: "Send again!",
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
                  onPressed: () {},
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
        child: Pinput(
          length: length,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyDecorationWith(
            border: Border.all(color: context.theme.primaryColor),
          ),
          errorPinTheme: defaultPinTheme.copyDecorationWith(
            color: errorColor,
          ),
          onChanged: (otp) {
            // context.read<OtpCubit>().otpChanged(otp);
          },
        ),
      ),
    );
  }
}
