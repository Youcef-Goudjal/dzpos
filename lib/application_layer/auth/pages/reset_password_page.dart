import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application_layer.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

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
            color: Colors.black,
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
                "Reset\nPassword",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              15.h.heightBox,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppTextField(
                    obscureText: true,
                    prefix: Icon(Icons.lock_outline_rounded),
                    hint: "New Password",
                    suffix: Icon(Icons.remove_red_eye_outlined),
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 15.h),
                  const AppTextField(
                    obscureText: true,
                    prefix: Icon(Icons.lock_outline_rounded),
                    hint: "Confirm new Password",
                    suffix: Icon(Icons.remove_red_eye_outlined),
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
              15.h.heightBox,
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
