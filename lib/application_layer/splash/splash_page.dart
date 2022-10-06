import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.splashColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "DZPos",
            style: TextStyle(
              color: context.theme.colorScheme.onPrimary,
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }
}
