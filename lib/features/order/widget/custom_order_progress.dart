import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

class CustomOrderProgress extends StatelessWidget {
  final String orderStatus;

  const CustomOrderProgress({Key? key, required this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> statuses = orderStatus == 'Hủy'
        ? ['Chờ xác nhận', 'Đang xử lý', 'Đã hủy']
        : ['Chờ xác nhận', 'Đang xử lý', 'Hoàn tất'];
    int progressIndex = orderStatus == 'Hủy'
        ? statuses.length - 1
        : statuses.indexOf(orderStatus);
    if (progressIndex == -1) {
      progressIndex = 0;
    }

    return Container(
      padding: const EdgeInsets.all(kPaddingMd),
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
                          color: kColorWhite,
                        ),
                      ),
                    if (index > 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: isComplete ? Colors.green : Colors.grey,
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusMd),
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
                                BorderRadius.circular(kBorderRadiusMd),
                          ),
                        ),
                      ),
                    if (index == 2)
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: kColorWhite,
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusMd),
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
