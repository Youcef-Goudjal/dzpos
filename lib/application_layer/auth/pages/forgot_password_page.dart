import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/manager/route/routes.dart';
import 'package:dzpos/product/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../application_layer.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
          left: 24,
          right: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                width: MediaQuery.of(context).size.width,
                height: 350.h,
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
              const AppTextField(
                prefix: Icon(Icons.alternate_email_rounded),
                hint: "Email Address",
                textInputAction: TextInputAction.done,
              ),
              20.h.heightBox,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.resetPasswort.routeName);
                  },
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
