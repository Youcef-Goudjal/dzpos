import 'package:dzpos/core/extensions/extensions.dart';
import 'package:dzpos/core/manager/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../product/product.dart';
import '../../application_layer.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
            left: 24.w,
            right: 24.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Image(
                width: context.width,
                height: 250.h,
                fit: BoxFit.contain,
                image: const AssetImage(AppAssets.login),
              ),
              const Spacer(flex: 2),
              Text(
                "Pick Login Option".toUpperCase(),
                style: Theme.of(context).textTheme.headline3,
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.goNamed(AppRoutes.login.routeName);
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: const Text("Login with email And Password"),
                    ),
                  ),
                  10.heightBox,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.goNamed(AppRoutes.loginPhone.routeName);
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: const Text("Login With Phone number"),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
