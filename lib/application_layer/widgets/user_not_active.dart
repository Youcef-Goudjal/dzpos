import '../../core/extensions/extensions.dart';
import '../../product/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/manager/language/locale_keys.g.dart';

class UserNotActive extends StatelessWidget {
  final String uid;
  const UserNotActive({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            AppAssets.usersLottie,
            fit: BoxFit.cover,
          ),
          Text(
            LocaleKeys.your_account_is_not_activated.tr(),
            style: context.textTheme.titleLarge,
          ),
          5.heightBox,
          Text(LocaleKeys.user_not_active_desc.tr()),
          10.heightBox,
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer.withOpacity(0.5)),
            child: Center(
              child: SelectableText(
                uid,
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
