import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';

class CustomerPageMobileScreen extends StatelessWidget {
  static const route = 'CustomerPageMobileScreen';
  const CustomerPageMobileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          color: Colors.white,
          child: SafeArea(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Iconsax.arrow_left_2_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(
                  width: DEFAULT_MARGIN,
                ),
                Text(
                  'Khách hàng',
                  style: AppTextStyle.medium(
                    PLUS_LARGE_TEXT_SIZE,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.filter_search_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(
                  width: MEDIUM_MARGIN,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.search_rounded,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
