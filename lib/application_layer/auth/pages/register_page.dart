import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/route/routes.dart';
import '../../application_layer.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
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
                height: 250,
                fit: BoxFit.contain,
                image: const AssetImage(AppAssets.register),
              ),
              Text(
                "Register".toUpperCase(),
                style: Theme.of(context).textTheme.headline3,
              ),
              24.h.heightBox,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppTextField(
                    prefix: Icon(Icons.person_outline),
                    hint: "Username",
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 20.h),
                  const AppTextField(
                    keyboardType: TextInputType.emailAddress,
                    prefix: Icon(Icons.alternate_email_rounded),
                    hint: "Email Address",
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 20.h),
                  const AppTextField(
                    keyboardType: TextInputType.number,
                    prefix: Icon(Icons.phone_outlined),
                    hint: "Phone Number",
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 20.h),
                  const AppTextField(
                    obscureText: true,
                    prefix: Icon(Icons.lock_outline_rounded),
                    suffix: Icon(Icons.remove_red_eye_outlined),
                    hint: "Password",
                    textInputAction: TextInputAction.done,
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
                          text: "By signing up, you're agree to our ",
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "Term & Condition",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: context.theme.primaryColor),
                        ),
                        TextSpan(
                          text: " and ",
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "privacy Policy",
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
                      onPressed: () {
                        context.goNamed(AppRoutes.verifyOtp.routeName);
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: const Text("Register"),
                    ),
                  ),
                  24.h.heightBox,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
