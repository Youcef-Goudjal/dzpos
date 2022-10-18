import 'package:dzpos/application_layer/widgets/app_text_field.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

Future showPrinterSettings(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return const _SettingDialog();
    },
  );
}

class _SettingDialog extends StatefulWidget {
  const _SettingDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<_SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<_SettingDialog> {
  PaperType paperType = PaperType.p58;
  double fontSize = 10;
  double spacing = 7;
  bool duplicate = false;
  bool fontType = true;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          const Text("Paper Scale"),
          10.heightBox,
          Row(
            children: [
              RadioListTile<PaperType>(
                value: PaperType.p58,
                groupValue: paperType,
                onChanged: (value) {
                  setState(() {
                    paperType = value!;
                  });
                },
              ),
              5.widthBox,
              RadioListTile<PaperType>(
                value: PaperType.p80,
                groupValue: paperType,
                onChanged: (value) {
                  setState(() {
                    paperType = value!;
                  });
                },
              ),
            ],
          ),
          10.heightBox,
          Row(
            children: [
              const Expanded(
                child: Text("Font Size :"),
              ),
              Expanded(
                child: AppTextField(
                  initialValue: "$fontSize",
                  textInputAction: TextInputAction.next,
                  onChanged: (input) {
                    setState(() {
                      fontSize = double.tryParse(input) ?? 10;
                    });
                  },
                ),
              )
            ],
          ),
          10.heightBox,
          Row(
            children: [
              const Expanded(
                child: Text("Last Space lines :"),
              ),
              Expanded(
                child: AppTextField(
                  initialValue: "$spacing",
                  textInputAction: TextInputAction.next,
                  onChanged: (input) {
                    setState(() {
                      fontSize = double.tryParse(input) ?? 7;
                    });
                  },
                ),
              )
            ],
          ),
          10.heightBox,
          Checkbox(
            value: duplicate,
            onChanged: (value) {
              setState(() {
                duplicate = value!;
              });
            },
          ),
          10.heightBox,
          const Text("Font Type"),
          RadioListTile<bool>(
            value: true,
            title: const Text("Font Type 2c"),
            groupValue: fontType,
            onChanged: (value) {
              setState(() {
                fontType = value!;
              });
            },
          ),
          5.heightBox,
          RadioListTile<bool>(
            value: false,
            title: const Text("Font Type 2c"),
            groupValue: fontType,
            onChanged: (value) {
              setState(() {
                fontType = value!;
              });
            },
          ),
          15.heightBox,
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Center(
              child: Text("Save Settings"),
            ),
          )
        ],
      ),
    );
  }
}

enum PaperType {
  A4,
  p58,
  p80,
  custom;

  /// width of the page in mm (-1 => not set)
  double get width {
    switch (this) {
      case PaperType.p58:
        return 58;
      case PaperType.p80:
        return 80;
      default:
        return -1;
    }
  }
}
