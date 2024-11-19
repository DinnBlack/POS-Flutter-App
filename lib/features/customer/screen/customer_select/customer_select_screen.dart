import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

import '../../../../core/widgets/common_widgets/custom_text_field.dart';
import '../../widget/custom_customer_list_item.dart';
import '../../../../features/customer/bloc/customer_bloc.dart';
import '../../../../features/order/bloc/order_bloc.dart';
import '../../model/customer_model.dart';

class CustomerSelectScreen extends StatefulWidget {
  static const route = 'CustomerSelectScreen';
  const CustomerSelectScreen({super.key});

  @override
  State<CustomerSelectScreen> createState() => _CustomerSelectScreenState();
}

class _CustomerSelectScreenState extends State<CustomerSelectScreen> {
  @override
  void initState() {
    context.read<CustomerBloc>().add(CustomerSearchStated(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusMd),
      ),
      child: Container(
        padding: const EdgeInsets.all(kPaddingMd),
        decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.circular(kBorderRadiusMd),
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: controller,
              hintText: 'Nhập tên hoặc số điện thoại',
              autofocus: true,
              onChanged: (query) {
                print('Search query: $query');
                final searchQuery = query?.trim() ?? '';
                if (searchQuery.isEmpty) {
                  context.read<CustomerBloc>().add(CustomerSearchStated(''));
                } else {
                  // Otherwise, search for customers
                  context.read<CustomerBloc>().add(CustomerSearchStated(searchQuery));
                }
              },
            ),
            const SizedBox(height: kMarginMd),
            BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
                if (state is CustomerSearchSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) {
                      final customer = state.searchResults[index];
                      return CustomCustomerListItem(
                        customer: customer,
                        onTap: () {
                          Navigator.pop(context, customer);
                          context.read<OrderBloc>().add(SelectCustomerStarted(customerSelect: customer));
                        },
                      );
                    },
                  );
                } else if (state is CustomerSearchFailed) {
                  return Center(child: Text('Search failed: ${state.error}'));
                } else {
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        title: Text('Khách lẻ'),
                        subtitle: Text(''),
                        onTap: () {
                          Navigator.pop(context, CustomerModel(name: 'Khách lẻ', phoneNumber: ''));
                          // Reset the search after dialog is popped
                          context.read<CustomerBloc>().add(CustomerSearchStated(''));
                        },
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: kMarginMd),
            GestureDetector(
              onTap: () {
                // Handle "Tạo Mới" logic if you want
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tạo Mới',
                    style: AppTextStyle.medium(kTextSizeMd, kColorPrimary),
                  ),
                  const Icon(
                    Icons.add_circle_rounded,
                    color: kColorPrimary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

