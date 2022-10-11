import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../application_layer.dart';

class CatchFromAccountPage extends StatelessWidget {
  const CatchFromAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
            ),
            child: const Center(child: Text("Catch From Account")),
          ),
          AccountCard(
            onSelected: (account) {
              print(account);
            },
            onChangeNote: (input) {},
            onChangedAmount: (input) {},
            onSave: () {},
          ),
          Expanded(child: ListView())
        ],
      ),
    );
  }
}
