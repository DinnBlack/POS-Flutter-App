import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../features/category/bloc/category_bloc.dart';
import '../../../services/category/list_categories_horizontal_screen.dart';
import '../../../services/category/list_categories_vertical_screen.dart';
import '../../../services/product/list_products/list_products_screen.dart';
import '../../../services/product/product_create/product_create_screen.dart';

class InventoryPageMobileScreen extends StatefulWidget {
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
      backgroundColor: BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
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
                        color: BLACK_TEXT_COLOR,
                      ),
                    );
                  },
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: PRIMARY_COLOR,
                    unselectedLabelColor: GREY_COLOR,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: PRIMARY_COLOR,
                          width: 2.0,
                        ),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        child: Text(
                          'Sản phẩm',
                          style: TextStyle(fontSize: LARGE_TEXT_SIZE),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Danh mục',
                          style: TextStyle(fontSize: LARGE_TEXT_SIZE),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    child: Container(
                      width: 1.0,
                      height: 20.0,
                      color: GREY_LIGHT_COLOR,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DEFAULT_MARGIN),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      const ListCategoriesHorizontalScreen(),
                      SizedBox(height: DEFAULT_MARGIN),
                      Expanded(
                        child: ListProductsScreen(
                          isGridView: isGridView,
                          isOrderPage: false,
                        ),
                      ),
                    ],
                  ),
                  const ListCategoriesVerticalScreen(),
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
