import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

class CustomListStoreItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomListStoreItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: DEFAULT_MARGIN, left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: GREY_LIGHT_COLOR),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/store.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: DEFAULT_MARGIN,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
