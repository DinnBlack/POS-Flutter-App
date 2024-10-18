import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';


class CustomTextFieldSearchActivity extends StatelessWidget {
  const CustomTextFieldSearchActivity({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: GREY_LIGHT_COLOR,
              borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
            ),
            child: const Icon(
              Icons.search_rounded,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration:  InputDecoration(
                hintText: 'Search',
                hintStyle: AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
