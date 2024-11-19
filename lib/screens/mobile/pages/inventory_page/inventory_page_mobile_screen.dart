import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../features/category/screen/categories_list/categories_list_horizontal_screen.dart';
import '../../../../features/category/screen/categories_list/categories_list_vertical_screen.dart';
import '../../../../features/product/screen/products_list/product_list_screen.dart';

class InventoryPageMobileScreen extends StatefulWidget {
  static const route = 'InventoryPageMobileScreen';
  const InventoryPageMobileScreen({super.key});

  @override
  State<InventoryPageMobileScreen> createState() =>
      _InventoryPageMobileScreenState();
}

class _InventoryPageMobileScreenState extends State<InventoryPageMobileScreen>
    with SingleTickerProviderStateMixin {
  bool isGridView = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(kPaddingMd),
          color: Colors.white,
          child: SafeArea(
            child: Row(
              children: [
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<CategoryBloc>()
                            .add(CategoryResetToDefaultStated());
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Iconsax.arrow_left_2_copy,
                        color: kColorBlack,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: kMarginMd,
                ),
                Text(
                  'Quản lý',
                  style: AppTextStyle.medium(
                    kTextSizeLg,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    color: kColorBlack,
                  ),
                ),
                const SizedBox(
                  width: kMarginMd,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.scan_barcode_copy,
                    color: kColorBlack,
                  ),
                ),
                const SizedBox(
                  width: kMarginMd,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.filter_search_copy,
                    color: kColorBlack,
                  ),
                ),
                const SizedBox(
                  width: kMarginMd,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  child: Icon(
                    isGridView ? Iconsax.grid_8_copy : Iconsax.menu_1_copy,
                    color: kColorBlack,
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
              color: kColorWhite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: kColorPrimary,
                    unselectedLabelColor: kColorGrey,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: kColorPrimary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        child: Text(
                          'Sản phẩm',
                          style: TextStyle(fontSize: kTextSizeLg),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Danh mục',
                          style: TextStyle(fontSize: kTextSizeLg),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    child: Container(
                      width: 1.0,
                      height: 20.0,
                      color: kColorLightGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kMarginMd),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      const CategoriesListHorizontalScreen(),
                      const SizedBox(height: kMarginMd),
                      Expanded(
                        child: ProductListScreen(
                          isGridView: isGridView,
                          isOrderPage: false,
                          isFloating: true,
                        ),
                      ),
                    ],
                  ),
                  const CategoriesListVerticalScreen(
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
