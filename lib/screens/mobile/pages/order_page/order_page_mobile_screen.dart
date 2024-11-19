import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/custom_app_bar.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/custom_text_field.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/loading_dialog.dart';
import 'package:pos_flutter_app/features/category/bloc/category_bloc.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import 'package:pos_flutter_app/core/utils/format_text.dart';
import '../../../../features/category/screen/categories_list/categories_list_horizontal_screen.dart';
import '../../../../features/category/screen/categories_list/categories_list_vertical_screen.dart';
import '../../../../features/order/screen/order_create/order_create_screen.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../../features/product/screen/products_list/product_list_screen.dart';

class OrderPageMobileScreen extends StatefulWidget {
  static const route = "OrderPageMobileScreen";

  const OrderPageMobileScreen({super.key});

  @override
  State<OrderPageMobileScreen> createState() => _OrderPageMobileScreenState();
}

class _OrderPageMobileScreenState extends State<OrderPageMobileScreen> {
  bool isGridView = true;
  int totalPrice = 0;
  int layoutState = 0;
  bool isLoadingDialogShown = false;

  @override
  void initState() {
    super.initState();
    totalPrice = context.read<OrderBloc>().totalProductCount;
    _checkLoadingState();
  }

  void _checkLoadingState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final isCategoryLoading =
          context.read<CategoryBloc>().state is CategoryFetchInProgress;
      final isProductLoading =
          context.read<ProductBloc>().state is ProductFetchInProgress;
      if (isCategoryLoading || isProductLoading) {
        if (!isLoadingDialogShown) {
          setState(() {
            isLoadingDialogShown = true;
          });
          const LoadingDialog();
        }
      } else {
        if (isLoadingDialogShown) {
          setState(() {
            isLoadingDialogShown = false;
          });
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = (layoutState == 2) ? kColorWhite : kColorBackground;

    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is ProductFetchInProgress ||
            state is CategoryFetchInProgress) {
          if (!isLoadingDialogShown) {
            setState(() {
              isLoadingDialogShown = true;
            });
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingDialog(),
            );
          }
        } else if (state is ProductFetchSuccess ||
            state is CategoryFetchSuccess) {
          if (isLoadingDialogShown) {
            setState(() {
              isLoadingDialogShown = false;
            });
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: kPaddingMd, right: kPaddingMd, bottom: kPaddingMd),
                color: kColorWhite,
                child: const CustomTextField(
                  hintText: 'Tìm kiếm...',
                  height: 40,
                ),
              ),
              Expanded(
                child: _buildBody(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      actions: [
        _buildFilterButton(),
        _buildLayoutToggleButton(),
        _buildMenuButton(),
      ],
      title: 'Bán hàng',
      leading: _buildBackButton(),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () {
        if (context.read<OrderBloc>().orderProductList.isNotEmpty) {
          _showStopOrderConfirmation();
        } else {
          Navigator.pop(context);
          context.read<CategoryBloc>().add(CategoryResetToDefaultStated());
          context.read<OrderBloc>().add(OrderFetchStarted());
        }
      },
      child: const Icon(Iconsax.arrow_left_2_copy, color: kColorBlack),
    );
  }

  void _showStopOrderConfirmation() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(kPaddingMd),
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xác nhận dừng tạo đơn hàng?',
                style: AppTextStyle.semibold(kTextSizeLg),
              ),
              Divider(
                thickness: 1,
                color: kColorLightGrey,
              ),
              Text(
                'Thông tin đơn hàng sẽ không được lưu khi dừng tạo đơn hàng. Bạn có chắc rằng muốn thực hiện?',
                style: AppTextStyle.medium(kTextSizeMd),
              ),
              const SizedBox(height: kMarginMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Từ chối',
                      style: AppTextStyle.semibold(
                        kTextSizeLg,
                        kColorGrey,
                      ),
                    ),
                  ),
                  const SizedBox(width: kMarginMd),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<OrderBloc>()
                          .add(ClearOrderProductListStarted());
                      Navigator.pop(context);
                      Navigator.pop(context);
                      context
                          .read<CategoryBloc>()
                          .add(CategoryResetToDefaultStated());
                      context.read<OrderBloc>().add(OrderFetchStarted());
                    },
                    child: Text(
                      'Xác nhận',
                      style: AppTextStyle.semibold(
                        kTextSizeLg,
                        kColorPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: kMarginMd),
                ],
              ),
              const SizedBox(height: kMarginMd),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterButton() {
    return InkWell(
      onTap: () {},
      child: const Icon(Iconsax.filter_search_copy),
    );
  }

  Widget _buildLayoutToggleButton() {
    return InkWell(
      onTap: () {
        setState(() {
          layoutState = (layoutState + 1) % 3;
        });
      },
      child: Icon(layoutState == 0
          ? Iconsax.grid_8_copy
          : layoutState == 1
              ? Iconsax.menu_1_copy
              : Iconsax.grid_6_copy),
    );
  }

  Widget _buildMenuButton() {
    return InkWell(
      onTap: () {},
      child: const Icon(Iconsax.menu_board_copy),
    );
  }

  Widget _buildBody() {
    if (layoutState == 0) {
      return const Column(
        children: [
          SizedBox(height: kMarginMd),
          CategoriesListHorizontalScreen(),
          SizedBox(height: kMarginMd),
          Expanded(
            child: ProductListScreen(
              isGridView: true,
              isOrderPage: true,
              isAddProduct: true,
            ),
          ),
        ],
      );
    } else if (layoutState == 1) {
      return const Column(
        children: [
          SizedBox(height: kMarginMd),
          CategoriesListHorizontalScreen(),
          SizedBox(height: kMarginMd),
          Expanded(
            child: ProductListScreen(
              isGridView: false,
              isOrderPage: true,
              isAddProduct: true,
            ),
          ),
        ],
      );
    } else {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: CategoriesListVerticalScreen(isOrderPage: true),
          ),
          Expanded(
            flex: 3,
            child: ProductListScreen(
              isGridView: true,
              isOrderPage: true,
              isAddProduct: true,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final orderProductList = context.read<OrderBloc>().orderProductList;
        return orderProductList.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(kPaddingMd),
                decoration: BoxDecoration(
                    color: kColorWhite,
                    border: Border(
                        top: BorderSide(color: kColorLightGrey, width: 1))),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderCreateScreen.route);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: kPaddingMd,
                      horizontal: kPaddingLg,
                    ),
                    decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(kBorderRadiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${orderProductList.length} sản phẩm',
                          style: AppTextStyle.medium(
                            kTextSizeMd,
                            kColorWhite,
                          ),
                        ),
                        Text(
                          FormatText.formatCurrency(totalPrice),
                          style: AppTextStyle.semibold(
                            kTextSizeMd,
                            kColorWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
