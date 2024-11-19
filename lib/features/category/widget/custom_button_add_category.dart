import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

import '../screen/dialog/add_category_bottom_sheet.dart';

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
          color: kColorPrimary,
          borderRadius: BorderRadius.circular(kBorderRadiusMd),
        ),
        height: 40,
        width: isTitle ? null : 40,
        child: isTitle
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.add_copy,
                      color: kColorWhite,
                    ),
                    const SizedBox(
                      width: kMarginSm,
                    ),
                    Text(
                      'Thêm danh mục',
                      style: AppTextStyle.medium(kTextSizeMd, kColorWhite),
                    )
                  ],
                ),
              )
            : const Icon(
              Iconsax.add_copy,
              color: kColorWhite,
            ),
      ),
    );
  }
}
