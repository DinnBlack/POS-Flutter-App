import 'package:flutter/material.dart';
import 'package:pos_flutter_app/database/db_products.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_grid_products_item.dart';

class ProductsLandscapeScreen extends StatelessWidget {
  const ProductsLandscapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),

      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth >= 1350) {
            crossAxisCount = 6;
          } else if (constraints.maxWidth >= 1100) {
            crossAxisCount = 5;
          } else if (constraints.maxWidth >= 850) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

          double itemHeight = 260;
          double itemWidth =
              (constraints.maxWidth - (crossAxisCount - 1) * 10) / crossAxisCount;

          return GridView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemCount: dbProducts.length,
            itemBuilder: (context, index) {
              final product = dbProducts[index];
              return CustomGridProductsItem(product: product);
            },
          );
        },
      ),
    );
  }
}
