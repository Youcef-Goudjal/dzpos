import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/route/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const AppTextField(
                      prefix: Icon(Icons.alternate_email_rounded),
                      hint: "Email Address",
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 24.h),
                    const AppTextField(
                      obscureText: true,
                      prefix: Icon(Icons.lock_outline_rounded),
                      suffix: Icon(Icons.remove_red_eye_outlined),
                      hint: "Password",
                      textInputAction: TextInputAction.done,
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
                  height: 64.h,
                  child: ElevatedButton(
                    onPressed: () {
                      print("LOGIN");
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
