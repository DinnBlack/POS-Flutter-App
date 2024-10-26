import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/mobile/pages/activity_page/activity_page_mobile_screen.dart';
import 'package:pos_flutter_app/screens/mobile/pages/inventory_page/inventory_page_mobile_screen.dart';
import 'package:pos_flutter_app/screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../features/store/bloc/store_bloc.dart';
import '../../routes/page_routes.dart';
import '../../utils/constants/constants.dart';
import '../../widgets/common_widgets/menu_mobile.dart';
import '../../widgets/normal_widgets/image_slider.dart';

class MainMobileScreen extends StatefulWidget {
  static const route = 'MainMobileScreen';

  const MainMobileScreen({super.key});

  @override
  MainMobileScreenState createState() => MainMobileScreenState();
}

class MainMobileScreenState extends State<MainMobileScreen> {
  @override
  Widget build(BuildContext context) {
    final store = context.read<StoreBloc>().selectedStore;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          color: PRIMARY_COLOR,
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(DEFAULT_PADDING),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/store.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: SMALL_MARGIN,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store!.name,
                      style: AppTextStyle.semibold(
                        LARGE_TEXT_SIZE,
                        WHITE_COLOR,
                      ),
                    ),
                    Text(
                      'Thông tin cửa hàng >',
                      style: AppTextStyle.medium(
                        MEDIUM_TEXT_SIZE,
                        WHITE_COLOR,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.search_rounded,
                    color: WHITE_COLOR,
                  ),
                ),
                const SizedBox(
                  width: DEFAULT_MARGIN,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.message_notif_copy,
                    color: WHITE_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  height: 100,
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
            Column(
              children: [
                const MiniDashBoard(),
                MenuMobile(
                  onItemSelected: (route) {
                    switch (route) {
                      case PageRoutes.activityPageMobile:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ActivityPageMobileScreen(),
                          ),
                        );
                        break;
                      case PageRoutes.inventoryPageMobile:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const InventoryPageMobileScreen(),
                          ),
                        );
                        break;
                      case PageRoutes.orderPageMobile:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const OrderPageMobileScreen(),
                          ),
                        );
                        break;
                    }
                  },
                ),
                const SizedBox(height: DEFAULT_MARGIN,),
                const ImageSlider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MiniDashBoard extends StatelessWidget {
  const MiniDashBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(DEFAULT_PADDING),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hôm nay',
                  style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE, GREY_COLOR),
                ),
                const SizedBox(
                  width: SMALL_MARGIN,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.visibility_outlined,
                    color: GREY_COLOR,
                    size: LARGE_TEXT_SIZE,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Iconsax.chart_21_copy,
                  color: PRIMARY_COLOR,
                  size: LARGE_TEXT_SIZE,
                ),
                const SizedBox(
                  width: SMALL_MARGIN,
                ),
                Text(
                  'Xem lãi lỗ >',
                  style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, PRIMARY_COLOR),
                ),
              ],
            ),
          ),
          const Spacer(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: DEFAULT_MARGIN,
                ),
                const _miniDashBoardItem(
                  title: 'Doanh thu',
                  iconData: Iconsax.chart_21,
                  iconColor: ORANGE_COLOR,
                ),
                const SizedBox(
                  width: SUPER_LARGE_MARGIN,
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: GREY_LIGHT_COLOR,
                ),
                const SizedBox(
                  width: SUPER_LARGE_MARGIN,
                ),
                const _miniDashBoardItem(
                  title: 'Đơn hàng',
                  iconData: Iconsax.document_normal,
                  iconColor: PRIMARY_COLOR,
                ),
                const SizedBox(
                  width: SUPER_LARGE_MARGIN,
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: GREY_LIGHT_COLOR,
                ),
                const SizedBox(
                  width: SUPER_LARGE_MARGIN,
                ),
                const _miniDashBoardItem(
                  title: 'Lợi nhuận',
                  iconData: Iconsax.money_4,
                  iconColor: GREEN_COLOR,
                ),
                const SizedBox(
                  width: DEFAULT_MARGIN,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: DEFAULT_MARGIN,
          ),
        ],
      ),
    );
  }
}

class _miniDashBoardItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color iconColor;

  const _miniDashBoardItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: LARGE_TEXT_SIZE,
            ),
            const SizedBox(
              width: SMALL_MARGIN,
            ),
            Text(
              title,
              style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE, GREY_COLOR),
            ),
          ],
        ),
        const SizedBox(
          height: SMALL_MARGIN,
        ),
        Text(
          '0',
          style: AppTextStyle.semibold(
            LARGE_TEXT_SIZE,
          ),
        ),
      ],
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
