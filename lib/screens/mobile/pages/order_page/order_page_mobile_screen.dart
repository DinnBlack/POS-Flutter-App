import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/screens/services/order/order_create/order_create_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import 'package:pos_flutter_app/utils/ui_util/format_text.dart';

import '../../../../features/app/bloc/app_cubit.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../widgets/normal_widgets/custom_text_field_search_product.dart';
import '../../../services/category/list_categories_horizontal_screen.dart';
import '../../../services/product/list_products/list_products_screen.dart';

class OrderPageMobileScreen extends StatefulWidget {
  const OrderPageMobileScreen({super.key});

  @override
  State<OrderPageMobileScreen> createState() => _OrderPageMobileScreenState();
}

class _OrderPageMobileScreenState extends State<OrderPageMobileScreen> {
  bool isGridView = true;
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.saveContext(context);
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
                    if (context.read<OrderBloc>().orderProductList.isNotEmpty) {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(DEFAULT_PADDING),
                            decoration: BoxDecoration(
                                color: WHITE_COLOR,
                                borderRadius: BorderRadius.circular(
                                    DEFAULT_BORDER_RADIUS)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Xác nhận dừng tạo đơn hàng?',
                                  style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: GREY_LIGHT_COLOR,
                                ),
                                Text(
                                  'Thông tin đơn hàng sẽ không được lưu khi dừng tạo đơn hàng. Bạn có chắc rằng muốn thực hiện',
                                  style: AppTextStyle.medium(MEDIUM_TEXT_SIZE),
                                ),
                                const SizedBox(height: MEDIUM_MARGIN),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Từ chối',
                                        style: AppTextStyle.semibold(
                                          LARGE_TEXT_SIZE,
                                          GREY_COLOR,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: MEDIUM_MARGIN),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<OrderBloc>().add(
                                            ClearOrderProductListStarted());
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Xác nhận',
                                        style: AppTextStyle.semibold(
                                          LARGE_TEXT_SIZE,
                                          PRIMARY_COLOR,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: DEFAULT_MARGIN),
                                  ],
                                ),
                                const SizedBox(height: MEDIUM_MARGIN),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      Navigator.pop(context);
                    }
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
            const ListCategoriesHorizontalScreen(),
            Expanded(
              child: ListProductsScreen(
                isGridView: isGridView,
                isOrderPage: true,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          final orderProductList = context.read<OrderBloc>().orderProductList;

          int totalPrice = orderProductList.fold(0, (sum, item) {
            return sum + (item.price * (item.quantityOrder ?? 1));
          });

          return orderProductList.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(DEFAULT_PADDING),
                  decoration:  BoxDecoration(
                    color: WHITE_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: GREY_LIGHT_COLOR,
                        offset: const Offset(0, -1),
                        blurRadius: 4,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderCreateScreen.route);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(DEFAULT_PADDING),
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius:
                            BorderRadius.circular(SMALL_BORDER_RADIUS),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.shopping_bag,
                            color: WHITE_COLOR,
                          ),
                          const SizedBox(width: SMALL_MARGIN),
                          Text(
                            FormatText.formatCurrency(totalPrice),
                            style:
                                AppTextStyle.bold(LARGE_TEXT_SIZE, WHITE_COLOR),
                          ),
                          Spacer(),
                          Text(
                            'Tiếp tục',
                            style:
                                AppTextStyle.bold(LARGE_TEXT_SIZE, WHITE_COLOR),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox();
        },
      ),
    );
  }
}
