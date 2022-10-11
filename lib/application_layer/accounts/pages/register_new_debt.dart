import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class RegisterNewDebtPage extends StatefulWidget {
  const RegisterNewDebtPage({super.key});

  @override
  State<RegisterNewDebtPage> createState() => _RegisterNewDebtPageState();
}

class _RegisterNewDebtPageState extends State<RegisterNewDebtPage> {
  bool isCreditor = false;
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RadioListTile<bool>(
                    value: true,
                    groupValue: isCreditor,
                    onChanged: (value) => setState(() {
                      isCreditor = value!;
                    }),
                    title: const Text("Creditor"),
                  ),
                  RadioListTile<bool>(
                    value: false,
                    groupValue: isCreditor,
                    onChanged: (value) => setState(() {
                      isCreditor = value!;
                    }),
                    title: const Text("Debtor"),
                  ),
                ],
              ),
            ),
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
