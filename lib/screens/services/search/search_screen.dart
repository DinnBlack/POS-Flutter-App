import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_text_field.dart';

import '../../../utils/constants/constants.dart';

class SearchScreen extends StatelessWidget {
  static const route = 'SearchScreen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Iconsax.arrow_left_2_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(
                  width: DEFAULT_MARGIN,
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
