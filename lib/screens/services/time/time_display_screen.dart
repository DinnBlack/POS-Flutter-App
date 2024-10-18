import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

class TimeDisplayScreen extends StatefulWidget {
  const TimeDisplayScreen({super.key});

  @override
  State<TimeDisplayScreen> createState() => _TimeDisplayScreenState();
}

class _TimeDisplayScreenState extends State<TimeDisplayScreen> {
  late String _currentTime;
  late String _currentDate;
  late String _currentDay;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _updateTime();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentDay = DateFormat('EEE').format(now);
      _currentDate = DateFormat('dd MMM yyyy').format(now);
      _currentTime = DateFormat('hh:mm').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Iconsax.calendar_1_copy,
                    color: PRIMARY_COLOR,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "$_currentDay, $_currentDate",
                style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          child: Text(
            '-',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Iconsax.clock_copy,
                    color: PRIMARY_COLOR,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _currentTime,
                style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR),
              ),
              const SizedBox(width: 5),
              Text(
                DateFormat('a').format(DateTime.now()),
                style: AppTextStyle.medium(SMALL_TEXT_SIZE, GREY_COLOR),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
