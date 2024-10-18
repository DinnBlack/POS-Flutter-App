import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/services/products/product_create/product_create_screen.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

class InventoryPageMobileScreen extends StatelessWidget {
  const InventoryPageMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text('Inventory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ProductCreateScreen(),
          )
        ],
      ),
    );
  }
}
