import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/custom_button.dart';
import 'package:pos_flutter_app/features/menu/screen/menu_screen.dart';
import 'package:pos_flutter_app/features/store/model/store_model.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import '../../core/widgets/common_widgets/custom_app_bar.dart';
import '../../core/widgets/normal_widgets/image_slider.dart';
import '../../features/search/screen/search_screen.dart';
import '../../features/store/bloc/store_bloc.dart';

class MainMobileScreen extends StatefulWidget {
  static const route = 'MainMobileScreen';

  const MainMobileScreen({super.key});

  @override
  MainMobileScreenState createState() => MainMobileScreenState();
}

class MainMobileScreenState extends State<MainMobileScreen> {
  bool _isNavigating = false;

  Future<void> _refreshPage() async {
    if (!_isNavigating) {
      setState(() {
        _isNavigating = true;
      });
      await Navigator.pushNamed(context, SearchScreen.route);
      setState(() {
        _isNavigating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<StoreBloc>().selectedStore;
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: _buildAppBar(store),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar(StoreModel? store) {
    return CustomAppBar(
      isTitleCenter: true,
      leading: ClipOval(
        child: Image.asset(
          'assets/images/store.jpg',
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
      ),
      title: store?.name,
      titleStyle: AppTextStyle.semibold(kTextSizeLg),
      subtitle: 'Chủ cửa hàng',
      subtitleStyle: AppTextStyle.medium(kTextSizeSm),
      actions: [
        InkWell(
          onTap: () {
            // Navigate to menu screen
          },
          child: FaIcon(FontAwesomeIcons.search),
        ),
        InkWell(
          onTap: () {
            // Navigate to menu screen
          },
          child: FaIcon(FontAwesomeIcons.ellipsis),
        ),
      ],
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: ClipPath(
          //     clipper: BottomCurveClipper(),
          //     child: Container(
          //       height: 120,
          //       color: kColorPrimary,
          //     ),
          //   ),
          // ),
          RefreshIndicator(
            onRefresh: _refreshPage,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const MiniDashBoard(),
                const SizedBox(
                  height: kMarginMd,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
                  child: Text(
                    'Chức năng',
                    style: AppTextStyle.semibold(kTextSizeLg),
                  ),
                ),
                const MenuScreen(
                  allowedTitles: [
                    'Bán hàng',
                    'Sản phẩm',
                    'Đơn hàng',
                    'Khách hàng'
                  ],
                ),
                SizedBox(height: kMarginMd),
                ImageSlider(),
                SizedBox(height: kMarginMd),
                ContactBox(),
                SizedBox(height: kMarginMd),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactBox extends StatelessWidget {
  const ContactBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kMarginMd),
      margin: const EdgeInsets.symmetric(horizontal: kMarginMd),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(kBorderRadiusMd),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/store.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: kMarginMd),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bạn cần hỗ trợ?',
                      style: AppTextStyle.semibold(kTextSizeMd),
                    ),
                    Text(
                      'Hướng dẫn, giải đáp thắc mắc khách hàng',
                      style: AppTextStyle.medium(kTextSizeSm),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // Align evenly
            children: [
              Flexible(
                flex: 1,
                child: CustomButton(
                  text: 'Chat ngay',
                  onPressed: () {},
                  isOutlineButton: true,
                  icon: FontAwesomeIcons.solidMessage,
                  textStyle: AppTextStyle.medium(kTextSizeXs, kColorPrimary),
                  height: 40,
                ),
              ),
              const SizedBox(width: kMarginSm),
              Flexible(
                flex: 1,
                child: CustomButton(
                  text: 'Messenger',
                  onPressed: () {},
                  isOutlineButton: true,
                  icon: FontAwesomeIcons.facebookMessenger,
                  textStyle: AppTextStyle.medium(kTextSizeXs, kColorPrimary),
                  height: 40,
                ),
              ),
              const SizedBox(width: kMarginSm),
              Flexible(
                flex: 1,
                child: CustomButton(
                  text: 'ZaloOA',
                  onPressed: () {},
                  isOutlineButton: true,
                  icon: FontAwesomeIcons.phoneFlip,
                  textStyle: AppTextStyle.medium(kTextSizeXs, kColorPrimary),
                  height: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: kMarginMd),
          CustomButton(
            text: 'Miễn phí tư vấn cửa hàng mẫu',
            height: 40,
            textStyle: AppTextStyle.medium(kTextSizeSm, kColorWhite),
            icon: FontAwesomeIcons.phone,
            onPressed: () {},
          ),
        ],
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
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(kPaddingMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _miniDashBoardItem(
                      backgroundColor: Color(0xFFFFDFE2),
                      backgroundIconColor: Color(0xFFE32A3A),
                      title: 'Doanh thu',
                      iconData: Iconsax.chart_21_copy,
                      iconColor: kColorWhite,
                    ),
                  ),
                  SizedBox(width: kMarginMd),
                  Expanded(
                    child: _miniDashBoardItem(
                      backgroundColor: Color(0xFFDFF8FF),
                      backgroundIconColor: Color(0xFF0587FF),
                      title: 'Đơn hàng chờ',
                      iconData: Iconsax.document_normal_copy,
                      iconColor: kColorWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: kMarginMd,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _miniDashBoardItem(
                      backgroundColor: Color(0xFFFAF3D6),
                      backgroundIconColor: Color(0xFFE15705),
                      title: 'Đơn hàng',
                      iconData: Iconsax.document_normal_copy,
                      iconColor: kColorWhite,
                    ),
                  ),
                  SizedBox(width: kMarginMd),
                  Expanded(
                    child: _miniDashBoardItem(
                      backgroundColor: Color(0xFFECFBD0),
                      backgroundIconColor: Color(0xFF196F40),
                      title: 'Lợi nhuận',
                      iconData: Iconsax.money_4_copy,
                      iconColor: kColorWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _miniDashBoardItem extends StatefulWidget {
  final IconData iconData;
  final String title;
  final Color iconColor;
  final Color backgroundIconColor;
  final Color backgroundColor;

  const _miniDashBoardItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.iconColor,
    required this.backgroundIconColor,
    required this.backgroundColor,
  });

  @override
  _miniDashBoardItemState createState() => _miniDashBoardItemState();
}

class _miniDashBoardItemState extends State<_miniDashBoardItem> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(kBorderRadiusLg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kPaddingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(kPaddingSm),
                  decoration: BoxDecoration(
                    color: widget.backgroundIconColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.iconData,
                    color: widget.iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  height: kMarginSm,
                ),
                Text(
                  widget.title,
                  style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                ),
                const SizedBox(
                  height: kMarginSm,
                ),
                Text(
                  '100',
                  style: AppTextStyle.bold(kTextSizeXl),
                ),
              ],
            ),
          ),
        ),
      ),
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
