import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

class CustomTextFieldSearch extends StatelessWidget {
  const CustomTextFieldSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 5, left: 20),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search something sweet on your mind...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: kColorPrimary.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.search_rounded,
                  color: kColorPrimary,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
