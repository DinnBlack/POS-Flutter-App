import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

class MenuSideItemLogout extends StatefulWidget {
  const MenuSideItemLogout({super.key});

  @override
  _MenuSideItemLogoutState createState() => _MenuSideItemLogoutState();
}

class _MenuSideItemLogoutState extends State<MenuSideItemLogout> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: () => _showLogoutConfirmationDialog(context),
          child: AnimatedContainer(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
              color: _isPressed
                  ? Colors.red[700]
                  : _isHovered
                      ? RED_COLOR.withOpacity(0.1)
                      : GREY_LIGHT_COLOR,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: WHITE_COLOR,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Log Out',
                  style:
                      AppTextStyle.medium(MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }
}
