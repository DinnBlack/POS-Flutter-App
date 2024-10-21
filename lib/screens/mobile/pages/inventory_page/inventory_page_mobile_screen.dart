import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/services/products/product_create/product_create_screen.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../widgets/normal_widgets/custom_text_field_search_product.dart';
import '../../../services/categories/list_categories_screen.dart';
import '../../../services/products/list_products/list_products_screen.dart';

class InventoryPageMobileScreen extends StatefulWidget {
  const InventoryPageMobileScreen({super.key});

  @override
  State<InventoryPageMobileScreen> createState() =>
      _InventoryPageMobileScreenState();
}

class _InventoryPageMobileScreenState extends State<InventoryPageMobileScreen> {
  bool isGridView = true;
  PageController _pageController = PageController();
  int _selectedIndex = 0; // Chỉ số trang hiện tại

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTitleTap(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật chỉ số trang hiện tại
    });
    _pageController.jumpToPage(index); // Nhảy đến trang tương ứng
  }

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
                  'Quản lý',
                  style: AppTextStyle.medium(
                    PLUS_LARGE_TEXT_SIZE,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(
                  width: MEDIUM_MARGIN,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.scan_barcode_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(
                  width: MEDIUM_MARGIN,
                ),
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
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: WHITE_COLOR,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => _onTitleTap(0),
                    child: Text(
                      'Sản phẩm',
                      style: AppTextStyle.medium(
                        MEDIUM_TEXT_SIZE,
                        _selectedIndex == 0
                            ? PRIMARY_COLOR
                            : BLACK_TEXT_COLOR,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _onTitleTap(1),
                    child: Text(
                      'Danh mục',
                      style: AppTextStyle.medium(
                        MEDIUM_TEXT_SIZE,
                        _selectedIndex == 1
                            ? PRIMARY_COLOR
                            : BLACK_TEXT_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: DEFAULT_MARGIN),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  Column(
                    children: [
                      const ListCategoriesScreen(),
                      Expanded(
                        child: ListProductsScreen(isGridView: isGridView),
                      ),
                    ],
                  ),
                  Column(
                    children: [

                      const Expanded(
                        child: ListCategoriesScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ProductCreateScreen.route);
        },
        backgroundColor: PRIMARY_COLOR,
        child: const Icon(Iconsax.add_copy, color: WHITE_COLOR),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
