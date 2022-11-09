import '../../product/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyBoxWidget extends StatelessWidget {
  const EmptyBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AppAssets.emptyBoxLottie),
    );
  }
}
