
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kColorTransparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/animations/loading.json',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
