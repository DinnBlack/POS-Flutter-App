import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

class CustomTextFieldSearchProduct extends StatelessWidget {
  const CustomTextFieldSearchProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: DEFAULT_PADDING,
          left: DEFAULT_PADDING,
          right: DEFAULT_PADDING),
      color: WHITE_COLOR,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: DEFAULT_PADDING,
        ),
        decoration: BoxDecoration(
          color: BACKGROUND_COLOR,
          border: Border.all(width: 1, color: GREY_LIGHT_COLOR),
          borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: GREY_COLOR,
            ),
            SizedBox(width: DEFAULT_MARGIN),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search something sweet on your mind...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
