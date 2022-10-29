import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

void statusHandler(BuildContext context, Status status, {String? msg}) {
  if (status.isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "$msg",
        ),
      ),
    );
  } else if (status.isFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.theme.errorColor,
        content: Text(
          "Oops !! \n $msg",
        ),
      ),
    );
  } else if (status == Status.info) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colorScheme.secondaryContainer,
        duration: const Duration(milliseconds: 100),
        // margin: const EdgeInsets.all(16),
        content: Text(
          "$msg",
        ),
      ),
    );
  }
}
