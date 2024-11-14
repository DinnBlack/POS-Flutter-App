import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';

class CustomOrderProgress extends StatelessWidget {
  final String orderStatus;

  const CustomOrderProgress({Key? key, required this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the statuses, replacing "Hoàn tất" with "Đã hủy" if orderStatus is "Hủy"
    final List<String> statuses = orderStatus == 'Hủy'
        ? ['Chờ xác nhận', 'Đang xử lý', 'Đã hủy']
        : ['Chờ xác nhận', 'Đang xử lý', 'Hoàn tất'];

    // Set progress index to reach "Đã hủy" if orderStatus is "Hủy"
    int progressIndex = orderStatus == 'Hủy' ? statuses.length - 1 : statuses.indexOf(orderStatus);
    if (progressIndex == -1) {
      progressIndex = 0;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: DEFAULT_PADDING, vertical: MEDIUM_PADDING),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(statuses.length, (index) {
          bool isComplete = progressIndex >= index;

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index == 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: WHITE_COLOR,
                        ),
                      ),
                    if (index > 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: isComplete ? Colors.green : Colors.grey,
                            borderRadius:
                            BorderRadius.circular(MEDIUM_BORDER_RADIUS),
                          ),
                        ),
                      ),
                    Icon(
                      Icons.check,
                      color: isComplete ? Colors.green : Colors.grey,
                      size: 20,
                    ),
                    if (index < statuses.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: isComplete ? Colors.green : Colors.grey,
                            borderRadius:
                            BorderRadius.circular(MEDIUM_BORDER_RADIUS),
                          ),
                        ),
                      ),
                    if (index == 2)
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius:
                            BorderRadius.circular(MEDIUM_BORDER_RADIUS),
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  statuses[index],
                  style: TextStyle(
                    color: isComplete ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
