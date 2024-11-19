import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/custom_app_bar.dart';
import 'package:pos_flutter_app/screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widgets/custom_floating_button.dart';
import '../../../../features/order/screen/orders_list/orders_list_screen.dart';

class ActivityPageMobileScreen extends StatefulWidget {
  static const route = 'ActivityPageMobileScreen';

  const ActivityPageMobileScreen({super.key});

  @override
  _ActivityPageMobileScreenState createState() =>
      _ActivityPageMobileScreenState();
}

class _ActivityPageMobileScreenState extends State<ActivityPageMobileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'Tất cả',
    'Chờ xác nhận',
    'Đang xử lý',
    'Hoàn thành',
    'Hủy'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            Expanded(
              child: CustomAppBar(
                // backgroundColor: kColorPrimary,
                isTitleCenter: false,
                leading: const Icon(FontAwesomeIcons.arrowLeft),
                title: 'Đơn hàng',
                titleStyle: AppTextStyle.medium(kTextSizeLg),
                actions: [
                  InkWell(
                    onTap: () {},
                    child: const FaIcon(FontAwesomeIcons.search),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const FaIcon(FontAwesomeIcons.ellipsis),
                  ),
                ],
              ),
            ),
            Center(
              child: ButtonsTabBar(
                controller: _tabController,
                backgroundColor: kColorPrimary.withOpacity(0.1),
                unselectedBackgroundColor: kColorWhite,
                labelStyle: AppTextStyle.medium(kTextSizeMd, kColorPrimary),
                unselectedLabelStyle:
                    AppTextStyle.medium(kTextSizeMd, kColorGrey),
                unselectedBorderColor: Colors.transparent,
                borderColor: kColorPrimary,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kPaddingLg),
                borderWidth: 1,
                radius: 100,
                tabs: _tabs
                    .map((tab) => Tab(
                          text: tab,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: kMarginSm,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrdersListScreen(),
          OrdersListScreen(status: 'Chờ xác nhận'),
          OrdersListScreen(status: 'Đang xử lý'),
          OrdersListScreen(status: 'Hoàn tất'),
          OrdersListScreen(status: 'Hủy'),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        text: 'Tạo Đơn Hàng',
        onPressed: () {
          Navigator.pushNamed(context, OrderPageMobileScreen.route);
        },
        icon: const Icon(Icons.add, color: kColorWhite),
      ),
    );
  }
}
