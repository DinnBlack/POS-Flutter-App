import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/screens/mobile/main_mobile_screen.dart';
import '../../../core/widgets/common_widgets/custom_button.dart';
import '../../../core/widgets/common_widgets/custom_text_field.dart';
import '../bloc/store_bloc.dart';
import '../../../core/utils/app_text_style.dart';

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
                    'Tạo cửa hàng của bạn',
                    style: AppTextStyle.semibold(
                        kTextSizeXxl, kColorWhite),
                  ),
                  const SizedBox(height: kMarginMd),
                  Text(
                    'Nhập các thông tin cần thiết cho cửa hàng của bạn',
                    style: AppTextStyle.medium(kTextSizeSm, kColorWhite),
                  ),
                  const SizedBox(height: kMarginXxl),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: kMarginMd),
                    padding: const EdgeInsets.all(kPaddingLg),
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
                        CustomTextField(
                          hintText: 'Tên cửa hàng',
                          onChanged: (value) {},
                          controller: storeNameController,
                          isRequired: true, // Mark as required
                        ),
                        const SizedBox(height: kMarginMd),
                        CustomTextField(
                          hintText: 'Loại hình kinh doanh',
                          onChanged: (value) {},
                          controller: businessTypeController,
                          isRequired: true,
                        ),
                        const SizedBox(height: kMarginMd),
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
