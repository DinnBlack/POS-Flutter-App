import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

class CustomListStoreItem extends StatefulWidget {
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
  _CustomListStoreItemState createState() => _CustomListStoreItemState();
}

class _CustomListStoreItemState extends State<CustomListStoreItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController and the scale animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();  // Dispose the controller when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(top: kMarginMd),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kColorLightGrey),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/store.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: kMarginMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
