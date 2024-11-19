import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/custom_text_field.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widgets/custom_floating_button.dart';
import '../../../../features/customer/screen/customer_create/customer_create_screen.dart';
import '../../../../features/customer/screen/customer_list/customer_list_screen.dart';

class CustomerPageMobileScreen extends StatelessWidget {
  static const route = 'CustomerPageMobileScreen';

  const CustomerPageMobileScreen({super.key});

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
                Text(
                  'Khách hàng',
                  style: AppTextStyle.medium(
                    kTextSizeXxl,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.filter_search_copy,
                    color: kColorBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Column(
        children: [
          CustomTextField(hintText: ''),
          Expanded(child: CustomerListScreen()),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        text: 'Thêm Khách hàng',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.only(top: kMarginLg),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(kBorderRadiusMd),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: kPaddingMd,
                    right: kPaddingMd,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const CustomerCreateScreen(),
                ),
              );
            },
          );
        },
        icon: const Icon(Iconsax.user_add_copy, color: Colors.white),
      ),
    );
  }
}
