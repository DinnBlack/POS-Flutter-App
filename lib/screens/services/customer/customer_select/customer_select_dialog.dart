import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_text_field.dart';
import 'package:pos_flutter_app/widgets/normal_widgets/custom_customer_list_item.dart';

import '../../../../features/customer/bloc/customer_bloc.dart';
import '../../../../features/order/bloc/order_bloc.dart';
import '../../../../models/customer_model.dart';

class CustomerSelectDialog extends StatefulWidget {
  const CustomerSelectDialog({super.key});

  @override
  State<CustomerSelectDialog> createState() => _CustomerSelectDialogState();
}

class _CustomerSelectDialogState extends State<CustomerSelectDialog> {
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
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
      ),
      child: Container(
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min, // This ensures the dialog height is based on content
          children: [
            CustomTextField(
              controller: controller,
              hintText: 'Nhập tên hoặc số điện thoại',
              autofocus: true,
              onChanged: (query) {
                print('Search query: $query');
                final searchQuery = query?.trim() ?? '';

                if (searchQuery.isEmpty) {
                  // If query is empty, add event to show "Khách lẻ"
                  context.read<CustomerBloc>().add(CustomerSearchStated(''));
                } else {
                  // Otherwise, search for customers
                  context.read<CustomerBloc>().add(CustomerSearchStated(searchQuery));
                }
              },
            ),
            const SizedBox(height: MEDIUM_MARGIN),
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
            const SizedBox(height: MEDIUM_MARGIN),
            GestureDetector(
              onTap: () {
                // Handle "Tạo Mới" logic if you want
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tạo Mới',
                    style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, PRIMARY_COLOR),
                  ),
                  const Icon(
                    Icons.add_circle_rounded,
                    color: PRIMARY_COLOR,
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

