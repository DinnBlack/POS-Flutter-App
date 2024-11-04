import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_grid_products_item.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_list_products_item.dart';

import '../../../../features/product/bloc/product_bloc.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import '../product_create/product_create_screen.dart';

class ProductsListScreen extends StatefulWidget {
  final bool isGridView;
  final bool? isOrderPage;

  const ProductsListScreen({
    super.key,
    required this.isGridView,
    this.isOrderPage = false,
  });

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  late final CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = context.read<CategoryBloc>();

    _categoryBloc.stream.listen((state) {
      context
          .read<ProductBloc>()
          .add(ProductFilterChanged(_categoryBloc.selectedCategory!));
    });

    context.read<ProductBloc>().add(ProductFetchStarted());
  }

  void _addProduct() {
    Navigator.pushNamed(context, ProductCreateScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        if (constraints.maxWidth >= 1350) {
          crossAxisCount = 6;
        } else if (constraints.maxWidth >= 1100) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth >= 850) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 320) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 2;
        }

        double itemHeight = 142;
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * 10) / crossAxisCount;

        return Container(
          // color: PRIMARY_COLOR,
          padding: const EdgeInsets.only(bottom: DEFAULT_PADDING),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductFetchInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductFetchSuccess) {
                final products = state.products;

                final itemCount = products.length + 1;

                if (widget.isGridView) {
                  return GridView.builder(
                    padding: const EdgeInsets.only(
                      left: DEFAULT_PADDING,
                      right: DEFAULT_PADDING,
                      bottom: DEFAULT_PADDING,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: itemWidth / itemHeight,
                    ),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        final product = products[index];
                        return CustomGridProductsItem(product: product);
                      } else {
                        return _buildAddProductButton(widget.isGridView);
                      }
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: DEFAULT_PADDING,
                    ),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        final product = products[index];
                        return Column(
                          children: [
                            CustomListProductsItem(
                              product: product,
                              isOrderPage: widget.isOrderPage!,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: GREY_LIGHT_COLOR.withOpacity(0.02),
                            ),
                          ],
                        );
                      } else {
                        // Nút "Add Product"
                        return _buildAddProductButton(widget.isGridView);
                      }
                    },
                  );
                }
              } else if (state is ProductFetchFailure) {
                return Center(
                  child: Text('Failed to fetch products: ${state.error}'),
                );
              } else {
                print(state);
                return const Center(child: Text('No products found.'));
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildAddProductButton(bool isGridView) {
    return GestureDetector(
      onTap: _addProduct,
      child: Container(
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: isGridView ? BorderRadius.circular(DEFAULT_BORDER_RADIUS) : BorderRadius.zero,
          border: isGridView ? Border.all(color: GREY_COLOR.withOpacity(0.5), width: 1) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add),
            const SizedBox(
              height: DEFAULT_MARGIN,
            ),
            Text(
              'Thêm sản phẩm',
              style: AppTextStyle.medium(SMALL_TEXT_SIZE),
            ),
          ],
        ),
      ),
    );
  }
}