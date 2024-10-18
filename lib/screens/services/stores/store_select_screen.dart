import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/screens/services/stores/store_create_screen.dart';

import '../../../features/store/bloc/store_bloc.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/ui_util/app_text_style.dart';
import '../../../widgets/common_widgets/custom_button.dart';
import '../../../widgets/normal_widgets/custom_list_store_item.dart';
import '../../mobile/main_mobile_screen.dart';

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
    // Fetch the user's stores when the screen is initialized
    context.read<StoreBloc>().add(StoreSelectStated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
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
                    style: AppTextStyle.semibold(
                        SUPER_LARGE_TEXT_SIZE, WHITE_COLOR),
                  ),
                  const SizedBox(height: DEFAULT_MARGIN),
                  Text(
                    'Chọn cửa hàng bạn muốn quản lý',
                    style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, WHITE_COLOR),
                  ),
                  const SizedBox(height: SUPER_LARGE_MARGIN),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: MEDIUM_MARGIN),
                    padding: const EdgeInsets.all(LARGE_PADDING),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                      color: WHITE_COLOR,
                      boxShadow: [
                        BoxShadow(
                          color: GREY_LIGHT_COLOR,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                            border:
                                Border.all(width: 1, color: GREY_LIGHT_COLOR),
                          ),
                          child: BlocBuilder<StoreBloc, StoreState>(
                            builder: (context, state) {
                              if (state is StoreSelectInProgress) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is StoreSelectSuccess) {
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
                                          bottom: index == stores.length - 1 ? DEFAULT_MARGIN : 0.0,
                                        ),
                                        child: CustomListStoreItem(
                                          title: store.name,
                                          subtitle: store.businessType,
                                          onTap: () {
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) => MainMobileScreen(store: store),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else if (state is StoreSelectFailure) {
                                return Center(
                                    child: Text('Error: ${state.error}'));
                              }
                              return const Center(
                                  child: Text('No stores found.'));
                            },
                          ),
                        ),
                        const SizedBox(height: MEDIUM_MARGIN),
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
                return Container(
                  color: Colors.black.withOpacity(0.1),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
