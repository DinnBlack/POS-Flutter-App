import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/services/products/list_products/list_products_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../utils/constants/constants.dart';

class OrderPageMobileScreen extends StatelessWidget {
  const OrderPageMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          'Order Page',
          style: AppTextStyle.medium(PLUS_LARGE_TEXT_SIZE, WHITE_COLOR),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: ListProductsScreen()),
        ],
      ),
    );
  }
}
