// import 'package:flutter/material.dart';
// import 'package:pos_flutter_app/widgets/common_widgets/custom_text_field_search.dart';
//
// import '../../../../core/constants/constants.dart';
// import '../../../../widgets/common_widgets/header_side.dart';
// import '../../../services/category/categories_list/categories_list_horizontal_screen.dart';
// import '../../../services/order/order_details/order_details_page/order_details_page_screen.dart';
// import '../../../services/product/products_list/product_list_screen.dart';
// import '../../main_tablet_screen.dart';
//
// class OrderPageTabletScreen extends StatelessWidget {
//   const OrderPageTabletScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     String pageName = 'Order';
//     final mainScreenState =
//         context.findAncestorStateOfType<MainTabletScreenState>();
//
//     return Scaffold(
//       backgroundColor: BACKGROUND_COLOR,
//       body: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 HeaderSide(
//                   scaffoldKey: mainScreenState!.scaffoldKey,
//                   currentPageName: pageName,
//                 ),
//                 const CategoriesListHorizontalScreen(),
//                 const SizedBox(height: 10),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: CustomTextFieldSearch(),
//                 ),
//                 const Expanded(
//                   child: ProductsListScreen(isGridView: true,),
//                 ),
//               ],
//             ),
//           ),
//           const Flexible(
//             flex: 1,
//             child: OrderDetailsPageScreen(),
//           ),
//         ],
//       ),
//     );
//   }
// }
