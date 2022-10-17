import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

Future<String?> confirmDeleteDialog(BuildContext context, {String? msg}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Product"),
        content: Text("$msg"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, "No");
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.error,
            ),
            onPressed: () {
              Navigator.pop(context, "Yes");
            },
            child: Text(
              "Yes",
              style: context.textTheme.titleLarge!.copyWith(
                color: context.onError,
              ),
            ),
          ),
        ],
      );
    },
  );
}
