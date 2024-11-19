import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/features/product/bloc/product_bloc.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widgets/custom_bottom_bar.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  static const route = "invoiceDetails";

  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(kPaddingMd),
          color: kColorWhite,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    context
                        .read<OrderBloc>()
                        .add(SetDefaultStated());
                    context.read<ProductBloc>().add(ProductFetchStarted());
                  },
                  child: const Icon(
                    Iconsax.arrow_left_2_copy,
                    color: kColorBlack,
                  ),
                ),
                Text(
                  'Chi tiết hóa đơn',
                  style: AppTextStyle.medium(kTextSizeLg),
                ),
                const Icon(
                  Iconsax.arrow_left_2_copy,
                  color: kColorWhite,
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
              margin: const EdgeInsets.all(kMarginMd),
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.circular(kBorderRadiusMd),
              ),
              child: const Placeholder(),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
                left: kPaddingMd,
                top: kPaddingMd,
                right: kPaddingMd),
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
          Navigator.of(context).pop();
          context.read<OrderBloc>().add(SetDefaultStated());
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
                color: kColorPrimary,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: AppTextStyle.medium(
                  kTextSizeMd,
                  kColorPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
