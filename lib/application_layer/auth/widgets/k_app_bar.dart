import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
