import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/features/product/bloc/product_bloc.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../widgets/common_widgets/custom_bottom_bar.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  static const route = "invoiceDetails";

  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          color: BACKGROUND_COLOR,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    context.read<OrderBloc>().add(ClearOrderProductListStarted());
                    context.read<ProductBloc>().add(ProductFetchStarted());
                  },
                  child: const Icon(
                    Iconsax.arrow_left_2_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                Text(
                  'Chi tiết hóa đơn',
                  style: AppTextStyle.medium(PLUS_LARGE_TEXT_SIZE),
                ),
                const Icon(
                  Iconsax.arrow_left_2_copy,
                  color: BACKGROUND_COLOR,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(MEDIUM_MARGIN),
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
              ),
              child: const Placeholder(),
            ),

          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
                left: DEFAULT_PADDING,
                top: DEFAULT_PADDING,
                right: DEFAULT_PADDING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildColumn(Icons.arrow_circle_right, 'Chi tiết'),
                // Vertical line
                _buildColumn(Icons.print_rounded, 'In'),
                // Vertical line
                _buildColumn(Icons.send, 'Gửi'),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        rightButtonText: 'Tạo đơn mới',
        hasShadow: false,
        onRightButtonPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          context.read<OrderBloc>().add(ClearOrderProductListStarted());
          context.read<ProductBloc>().add(ProductFetchStarted());
        },
      ),
    );
  }

  Widget _buildColumn(IconData icon, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            // Handle tap
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: PRIMARY_COLOR,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: AppTextStyle.medium(
                  MEDIUM_TEXT_SIZE,
                  PRIMARY_COLOR,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
