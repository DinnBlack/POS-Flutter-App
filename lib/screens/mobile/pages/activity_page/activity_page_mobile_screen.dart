import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';

class ActivityPageMobileScreen extends StatelessWidget {
  const ActivityPageMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          'Activity',
          style: AppTextStyle.medium(PLUS_LARGE_TEXT_SIZE, WHITE_COLOR),
        ),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_square_left,
            color: WHITE_COLOR,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
