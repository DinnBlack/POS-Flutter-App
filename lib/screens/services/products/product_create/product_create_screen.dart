import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

import '../../../../widgets/common_widgets/custom_text_field.dart';
import '../../../../widgets/normal_widgets/custom_button_add_image.dart';

class ProductCreateScreen extends StatelessWidget {
  const ProductCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: DEFAULT_MARGIN,
                ),
                CustomButtonAddImage(
                  title: 'Ảnh sản phẩm',
                ),
                SizedBox(
                  height: DEFAULT_MARGIN,
                ),
                CustomTextField(
                  hintText: 'Tên sản phẩm',
                  title: 'Tên sản phẩm',
                  isRequired: true,
                ),
                SizedBox(
                  height: DEFAULT_MARGIN,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Giá bán',
                        isNumeric: true,
                        title: 'Giá bán',
                        isRequired: true,
                      ),
                    ),
                    SizedBox(
                      width: DEFAULT_MARGIN,
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Giá vốn',
                        isNumeric: true,
                        title: 'Giá vốn',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: DEFAULT_MARGIN,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Giá khuyến mãi',
                        isNumeric: true,
                        title: 'Giá khuyến mãi',
                      ),
                    ),
                    SizedBox(
                      width: DEFAULT_MARGIN,
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Đơn vị',
                        title: 'Đơn vị',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: DEFAULT_MARGIN,
                ),
                CustomTextField(
                  hintText: 'Mô tả',
                  title: 'Mô tả',
                ),
                SizedBox(
                  height: DEFAULT_MARGIN,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: BACKGROUND_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    print('Product creation cancelled');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: DEFAULT_MARGIN),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    print('Product created successfully');
                  },
                  child: const Text('Create Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
