import 'package:dzpos/core/common_blocs/application/application_bloc.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/manager/route/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
        if (state is ApplicationCompleted) {
          context.pushNamed(AppRoutes.home.name);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
