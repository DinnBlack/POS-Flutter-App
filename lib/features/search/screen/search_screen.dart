import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

import '../../../core/widgets/common_widgets/custom_text_field.dart';

class SearchScreen extends StatelessWidget {
  static const route = 'SearchScreen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(kPaddingMd),
          color: Colors.white,
          child: SafeArea(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Iconsax.arrow_left_2_copy,
                    color: kColorBlack,
                  ),
                ),
                const SizedBox(
                  width: kMarginMd,
                ),
                const Expanded(
                    child: SizedBox(
                  child: CustomTextField(
                    height: 40,
                    hintText: 'Tìm sản phẩm, đơn, khách hàng,...',
                    autofocus: true,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
