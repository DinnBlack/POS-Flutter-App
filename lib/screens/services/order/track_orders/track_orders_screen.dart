import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/database/db_orders.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_list_track_orders_item.dart';


class TrackOrdersScreen extends StatefulWidget {
  const TrackOrdersScreen({super.key});

  @override
  _TrackOrdersScreenState createState() => _TrackOrdersScreenState();
}

class _TrackOrdersScreenState extends State<TrackOrdersScreen> {
  final ScrollController _scrollController = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = false;

  final double categoryItemWidth = 160;
  double availableWidth = 0;

  void _scrollLeft() {
    final scrollAmount = categoryItemWidth + 20;
    _scrollController.animateTo(
      _scrollController.offset - scrollAmount,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    final scrollAmount = categoryItemWidth + 20;
    _scrollController.animateTo(
      _scrollController.offset + scrollAmount,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        canScrollLeft = _scrollController.offset > 0;
        canScrollRight = _scrollController.offset <
            _scrollController.position.maxScrollExtent;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        availableWidth = MediaQuery.of(context).size.width - 120;
        canScrollRight = _scrollController.position.maxScrollExtent > 0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(MEDIUM_BORDER_RADIUS),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              children: List.generate(dbOrders.length, (index) {
                final order = dbOrders[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: index == dbOrders.length - 1 ? 10 : 0,
                  ),
                  child: CustomListTrackOrdersItem(
                    order: order,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(DEFAULT_BORDER_RADIUS)),
        boxShadow: [
          BoxShadow(
            color: GREEN_COLOR.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Track Order',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: GREY_COLOR,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 20),
          _buildScrollButton(
            icon: Iconsax.arrow_left_3,
            onPressed: canScrollLeft ? _scrollLeft : null,
            isEnabled: canScrollLeft,
          ),
          const SizedBox(width: 10),
          _buildScrollButton(
            icon: Iconsax.arrow_right_2,
            onPressed: canScrollRight ? _scrollRight : null,
            isEnabled: canScrollRight,
          ),
        ],
      ),
    );
  }

  Widget _buildScrollButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isEnabled,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: isEnabled ? PRIMARY_COLOR : GREY_COLOR.withOpacity(0.2),
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: isEnabled ? PRIMARY_COLOR : GREY_COLOR,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
