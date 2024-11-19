import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/features/store/screen/store_create_screen.dart';

import '../../../core/widgets/common_widgets/custom_button.dart';
import '../../../core/widgets/common_widgets/loading_dialog.dart';
import '../widget/custom_list_store_item.dart';
import '../../../features/store/bloc/store_bloc.dart';
import '../../../core/utils/app_text_style.dart';
import '../../../screens/mobile/main_mobile_screen.dart';

class StoreSelectScreen extends StatefulWidget {
  static const route = 'StoreSelectScreen';

  const StoreSelectScreen({super.key});

  @override
  State<StoreSelectScreen> createState() => _StoreSelectScreenState();
}

class _StoreSelectScreenState extends State<StoreSelectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(StoreFetchStated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.5,
              widthFactor: 1,
              child: Image.asset(
                'assets/images/head_auth.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chọn cửa hàng của bạn',
                    style: AppTextStyle.semibold(kTextSizeXxl, kColorWhite),
                  ),
                  const SizedBox(height: kMarginMd),
                  Text(
                    'Chọn cửa hàng bạn muốn quản lý',
                    style: AppTextStyle.medium(kTextSizeSm, kColorWhite),
                  ),
                  const SizedBox(height: kMarginXxl),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: kMarginMd),
                    padding: const EdgeInsets.all(kPaddingMd),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorderRadiusMd),
                      color: kColorWhite,
                      boxShadow: [
                        BoxShadow(
                          color: kColorLightGrey,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<StoreBloc, StoreState>(
                          builder: (context, state) {
                            if (state is StoreFetchInProgress) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is StoreFetchSuccess) {
                              final stores = state.stores;
                              return ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 300,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: stores.length,
                                  itemBuilder: (context, index) {
                                    final store = stores[index];
                                    return Container(
                                      margin: EdgeInsets.only(
                                        bottom: index == stores.length - 1
                                            ? kPaddingMd
                                            : 0.0,
                                      ),
                                      child: CustomListStoreItem(
                                        title: store.name,
                                        subtitle: store.businessType,
                                        onTap: () {
                                          context.read<StoreBloc>().add(
                                              StoreSelectStated(store: store));
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MainMobileScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (state is StoreFetchFailure) {
                              return Center(
                                  child: Text('Error: ${state.error}'));
                            }
                            return const Center(
                                child: Text('No stores found.'));
                          },
                        ),
                        const SizedBox(height: kMarginMd),
                        CustomButton(
                          text: 'Tạo cửa hàng mới',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, StoreCreateScreen.route);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              if (state is StoreSelectInProgress) {
                LoadingDialog.showLoadingDialog(context);
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
