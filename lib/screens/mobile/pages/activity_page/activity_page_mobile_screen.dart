import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import 'package:pos_flutter_app/screens/services/order/orders_list/orders_list_screen.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../widgets/common_widgets/custom_floating_button.dart';

class ActivityPageMobileScreen extends StatefulWidget {
  const ActivityPageMobileScreen({super.key});

  @override
  _ActivityPageMobileScreenState createState() =>
      _ActivityPageMobileScreenState();
}

class _ActivityPageMobileScreenState extends State<ActivityPageMobileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

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
    _pageController = PageController();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(94),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(DEFAULT_PADDING),
              color: Colors.white,
              child: SafeArea(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Iconsax.arrow_left_2_copy,
                        color: BLACK_TEXT_COLOR,
                      ),
                    ),
                    const SizedBox(width: DEFAULT_MARGIN),
                    Text(
                      'Đơn hàng',
                      style: AppTextStyle.medium(PLUS_LARGE_TEXT_SIZE),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Iconsax.search_normal_copy,
                        color: BLACK_TEXT_COLOR,
                      ),
                    ),
                    const SizedBox(width: MEDIUM_MARGIN),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Iconsax.filter_copy,
                        color: BLACK_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 2,
                labelStyle: AppTextStyle.medium(LARGE_TEXT_SIZE),
                tabs: _tabs.map((title) {
                  return SizedBox(
                    width: 100,
                    child: Tab(text: title),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return OrdersListScreen();
            case 1:
              return OrdersListScreen(status: 'Chờ xác nhận');
            case 2:
              return OrdersListScreen(status: 'Đang xử lý');
            case 3:
              return OrdersListScreen(status: 'Hoàn tất');
            case 4:
              return OrdersListScreen(status: 'Hủy');
            default:
              return Center(child: Text("Unknown tab"));
          }
        },
      ),
      floatingActionButton: CustomFloatingButton(
        text: 'Tạo Đơn Hàng',
        onPressed: () {
          Navigator.pushNamed(context, OrderPageMobileScreen.route);
        },
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
