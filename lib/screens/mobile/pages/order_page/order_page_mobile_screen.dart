import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/services/products/list_products/list_products_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../widgets/normal_widgets/custom_text_field_search_product.dart';
import '../../../services/categories/list_categories_screen.dart';

class OrderPageMobileScreen extends StatefulWidget {
  const OrderPageMobileScreen({super.key});

  @override
  State<OrderPageMobileScreen> createState() => _OrderPageMobileScreenState();
}

class _OrderPageMobileScreenState extends State<OrderPageMobileScreen> {
  bool isGridView = true;
  double totalPrice = 200000; // Giả sử tổng giá hiện tại

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
                  'Bán hàng',
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
                  onTap: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  child: Icon(
                    isGridView ? Iconsax.grid_8_copy : Iconsax.menu_1_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(
                  width: MEDIUM_MARGIN,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.menu_board_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const CustomTextFieldSearchProduct(),
            const SizedBox(height: DEFAULT_MARGIN),
            const ListCategoriesScreen(),
            Expanded(
              child: ListProductsScreen(isGridView: isGridView),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Iconsax.shopping_bag,
                      color: PRIMARY_COLOR,
                    ),
                    onPressed: () {
                      // Xử lý hiển thị giỏ hàng
                    },
                  ),
                  const SizedBox(width: SMALL_MARGIN),
                  Text(
                    '${totalPrice.toStringAsFixed(0)}đ',
                    style:
                        AppTextStyle.bold(PLUS_LARGE_TEXT_SIZE, PRIMARY_COLOR),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.arrow_right_3,
                  color: WHITE_COLOR,
                ),
                label: Text(
                  'Tiếp tục',
                  style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, WHITE_COLOR),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
