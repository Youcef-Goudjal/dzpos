import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/manager/route/routes.dart';
import '../../../product/product.dart';
import '../../application_layer.dart';

class LoginPhonePage extends StatelessWidget {
  const LoginPhonePage({super.key});

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
                "Enter Ur Phone number",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              10.h.heightBox,
              Text(
                "a 6 Digit code will be sent to ur phone number",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
              ),
              10.h.heightBox,
              const AppTextField(
                prefix: Icon(Icons.phone),
                keyboardType: TextInputType.number,
                hint: "Phone Number",
                textInputAction: TextInputAction.done,
              ),
              24.h.heightBox,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.verifyOtp.routeName);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  child: const Text("Sent"),
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
