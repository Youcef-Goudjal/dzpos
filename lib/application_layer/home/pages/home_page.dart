import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  CommonBloc.authBloc.add(const SignOutRequested());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
