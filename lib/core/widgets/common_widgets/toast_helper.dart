import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static void showToast(BuildContext context, String title, String description, ToastificationType type) {
    Color backgroundColor;

    switch (type) {
      case ToastificationType.success:
        backgroundColor = Colors.green;
        break;
      case ToastificationType.error:
        backgroundColor = Colors.red;
        break;
      case ToastificationType.warning:
        backgroundColor = Colors.orange;
        break;
      default:
        backgroundColor = Colors.white;
    }

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      description: RichText(
          text: TextSpan(
            text: description,
            style: const TextStyle(color: Colors.white),
          )),
      alignment: Alignment.topCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.check, color: Colors.white),
      showIcon: true,
      primaryColor: backgroundColor,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      padding:  const EdgeInsets.all(kPaddingMd),
      margin: const EdgeInsets.all(kPaddingMd),
      borderRadius: BorderRadius.circular(kBorderRadiusMd),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }
}
