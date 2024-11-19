import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefreshIndicator({required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // You can listen to the scroll notification and trigger a custom refresh.
        if (notification is ScrollStartNotification) {
          // Custom logic for when the user starts pulling down to refresh
        }
        return true;
      },
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Handle custom refresh logic based on drag
        },
        child: child,
      ),
    );
  }
}
