import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

import '../../product/model/product_model.dart';

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
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
            child: Image.asset(
              product.image!.first,
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
                  style: AppTextStyle.semibold(kTextSizeMd),
                ),
                Text(
                  '${product.price}',
                  style: AppTextStyle.medium(kTextSizeSm, kColorGrey),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Iconsax.edit,
                      color: kColorPrimary,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadiusMd),
                        border: Border.all(color: kColorLightGrey, width: 1),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Iconsax.minus_copy,
                          ),
                          Text('', style: TextStyle(fontSize: kTextSizeMd)),
                          Icon(
                            Iconsax.add_circle,
                            color: kColorPrimary,
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
