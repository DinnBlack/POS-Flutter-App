import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/screens/mobile/main_mobile_screen.dart';
import '../../../features/store/bloc/store_bloc.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/ui_util/app_text_style.dart';
import '../../../widgets/common_widgets/custom_button.dart';
import '../../../widgets/common_widgets/custom_text_field.dart';

class StoreCreateScreen extends StatefulWidget {
  static const route = 'StoreCreateScreen';

  const StoreCreateScreen({super.key});

  @override
  _StoreCreateScreenState createState() => _StoreCreateScreenState();
}

class _StoreCreateScreenState extends State<StoreCreateScreen> {
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();

  @override
  void dispose() {
    storeNameController.dispose();
    businessTypeController.dispose();
    super.dispose();
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
                    'Tạo cửa hàng của bạn',
                    style: AppTextStyle.semibold(
                        SUPER_LARGE_TEXT_SIZE, WHITE_COLOR),
                  ),
                  const SizedBox(height: DEFAULT_MARGIN),
                  Text(
                    'Nhập các thông tin cần thiết cho cửa hàng của bạn',
                    style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, WHITE_COLOR),
                  ),
                  const SizedBox(height: SUPER_LARGE_MARGIN),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: MEDIUM_MARGIN),
                    padding: const EdgeInsets.all(LARGE_PADDING),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
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
                        CustomTextField(
                          hintText: 'Tên cửa hàng',
                          onChanged: (value) {},
                          controller: storeNameController,
                          isRequired: true, // Mark as required
                        ),
                        const SizedBox(height: MEDIUM_MARGIN),
                        CustomTextField(
                          hintText: 'Loại hình kinh doanh',
                          onChanged: (value) {},
                          controller: businessTypeController,
                          isRequired: true,
                        ),
                        const SizedBox(height: MEDIUM_MARGIN),
                        BlocConsumer<StoreBloc, StoreState>(
                          listener: (context, state) {
                            if (state is StoreCreateSuccess) {
                              Navigator.pushNamed(context, MainMobileScreen.route);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Store created successfully'),
                                ),
                              );
                            } else if (state is StoreCreateFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${state.error}'),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is StoreCreateInProgress) {
                              return const CircularProgressIndicator();
                            }
                            return CustomButton(
                              text: 'Bắt đầu',
                              onPressed: () {
                                if (storeNameController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Tên cửa hàng không được để trống'),
                                    ),
                                  );
                                  return;
                                }
                                if (businessTypeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Loại hình kinh doanh không được để trống'),
                                    ),
                                  );
                                  return;
                                }

                                BlocProvider.of<StoreBloc>(context).add(
                                  StoreCreateStated(
                                    storeName: storeNameController.text,
                                    businessType: businessTypeController.text,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
