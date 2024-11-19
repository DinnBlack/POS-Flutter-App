import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

import '../../../../core/widgets/common_widgets/custom_floating_button.dart';
import '../../widget/custom_grid_products_item.dart';
import '../../widget/custom_list_products_item.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../../core/utils/app_text_style.dart';
import '../product_create/product_create_screen.dart';

class ProductListScreen extends StatefulWidget {
  final bool isGridView;
  final bool? isOrderPage;
  final bool isFloating;
  final bool isAddProduct;

  const ProductListScreen({
    super.key,
    required this.isGridView,
    this.isOrderPage = false,
    this.isFloating = false,
    this.isAddProduct = false,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final CategoryBloc _categoryBloc;
  late final StreamSubscription _categoryBlocSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _categoryBloc = context.read<CategoryBloc>();
    _categoryBlocSubscription = _categoryBloc.stream.listen((state) {
      if (mounted) {
        context
            .read<ProductBloc>()
            .add(ProductFilterChanged(_categoryBloc.selectedCategory!));
      }
    });
    context.read<ProductBloc>().add(ProductFetchStarted());
  }

  @override
  void dispose() {
    _categoryBlocSubscription.cancel();
      super.dispose();
  }

  void _addProduct() {
    Navigator.pushNamed(context, ProductCreateScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: LayoutBuilder(
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
              (constraints.maxWidth - (crossAxisCount - 1) * 10) /
                  crossAxisCount;

          return Container(
            padding: const EdgeInsets.only(bottom: kPaddingMd),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductFetchInProgress) {
                  return const SizedBox();
                } else if (state is ProductFetchSuccess) {
                  final products = state.products;
                  final itemCount =
                      products.length + (widget.isAddProduct ? 1 : 0);

                  if (widget.isGridView) {
                    return GridView.builder(
                      padding: const EdgeInsets.only(
                        left: kPaddingMd,
                        right: kPaddingMd,
                        bottom: kPaddingMd,
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
                          return CustomGridProductsItem(
                            product: product,
                            isOrderPage: widget.isOrderPage!,
                          );
                        } else if (widget.isAddProduct) {
                          return _buildAddProductButton(widget.isGridView);
                        }
                        return Container();
                      },
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: kPaddingMd,
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
                                color: kColorLightGrey.withOpacity(0.2),
                              ),
                            ],
                          );
                        } else if (widget.isAddProduct) {
                          return _buildAddProductButton(widget.isGridView);
                        }
                        return Container();
                      },
                    );
                  }
                } else if (state is ProductFetchFailure) {
                  return Center(
                    child: Text('Failed to fetch products: ${state.error}'),
                  );
                } else {
                  return const Center(child: Text('No products found.'));
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: widget.isFloating
          ? CustomFloatingButton(
              text: 'Tạo Sản Phẩm',
              onPressed: _addProduct,
              icon: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildAddProductButton(bool isGridView) {
    return GestureDetector(
      onTap: _addProduct,
      child: Container(
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: isGridView
              ? BorderRadius.circular(kBorderRadiusMd)
              : BorderRadius.zero,
          border: isGridView
              ? Border.all(color: kColorGrey.withOpacity(0.5), width: 1)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add),
            const SizedBox(
              height: kMarginMd,
            ),
            Text(
              textAlign: TextAlign.center,
              'Thêm sản phẩm',
              style: AppTextStyle.medium(kTextSizeSm),
            ),
          ],
        ),
      ),
    );
  }
}
