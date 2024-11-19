import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/features/customer/model/customer_model.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

class CustomCustomerListItem extends StatelessWidget {
  final CustomerModel customer;
  final VoidCallback? onTap;

  const CustomCustomerListItem({
    super.key,
    required this.customer, this.onTap,
  });

  String _getInitials(String name) {
    List<String> words = name.split(" ");
    if (words.length > 1) {
      return words[0][0] + words[1][0];
    } else {
      return words[0][0];
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isGuest = customer.name == 'Khách lẻ';
    bool hasPhoneNumber = customer.phoneNumber.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: isGuest
              ? const Icon(Icons.person, color: Colors.white)
              : Text(
                  _getInitials(customer.name).toUpperCase(),
                  style: AppTextStyle.semibold(
                    kTextSizeMd,
                    kColorWhite,
                  ),
                ),
        ),
        title: Text(customer.name),
        subtitle: hasPhoneNumber ? Text(customer.phoneNumber) : null,
      ),
    );
  }
}
