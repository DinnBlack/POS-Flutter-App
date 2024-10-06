import 'package:flutter/material.dart';
import '../../utils/ui_util/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.maxLines,
    this.minLines,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.grey_02,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          isDense: true,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
