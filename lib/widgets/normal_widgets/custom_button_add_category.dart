import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../screens/services/category/dialog/add_category_bottom_sheet.dart';
import '../../utils/constants/constants.dart';

class CustomButtonAddCategory extends StatelessWidget {
  final bool isTitle;

  const CustomButtonAddCategory({
    super.key,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddCategoryBottomSheet(context);

      },
      child: Container(
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
        ),
        height: 40,
        width: isTitle ? null : 40,
        child: isTitle
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.add_copy,
                      color: WHITE_COLOR,
                    ),
                    const SizedBox(
                      width: SMALL_MARGIN,
                    ),
                    Text(
                      'Thêm danh mục',
                      style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, WHITE_COLOR),
                    )
                  ],
                ),
              )
            : const Icon(
              Iconsax.add_copy,
              color: WHITE_COLOR,
            ),
      ),
    );
  }
}
