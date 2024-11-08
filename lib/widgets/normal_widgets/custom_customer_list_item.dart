import 'package:flutter/material.dart';
import 'package:pos_flutter_app/models/customer_model.dart';

class CustomCustomerListItem extends StatelessWidget {
final CustomerModel customer;

  const CustomCustomerListItem({
    super.key, required this.customer,
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
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(
          _getInitials(customer.name).toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(customer.name),
      subtitle: Text(customer.phoneNumber),
    );
  }
}
