import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../models/product_model.dart';

class CustomListOrderDetailsPageItem extends StatelessWidget {
  const CustomListOrderDetailsPageItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
            child: Image.asset(
              product.image!,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR),
                ),
                Text(
                  '${product.price}',
                  style: AppTextStyle.medium(SMALL_TEXT_SIZE, GREY_COLOR),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Iconsax.edit,
                      color: PRIMARY_COLOR,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MEDIUM_BORDER_RADIUS),
                        border: Border.all(color: GREY_LIGHT_COLOR, width: 1),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Iconsax.minus_copy,
                          ),
                          Text('', style: TextStyle(fontSize: MEDIUM_TEXT_SIZE)),
                          Icon(
                            Iconsax.add_circle,
                            color: PRIMARY_COLOR,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
