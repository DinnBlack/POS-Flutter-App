import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/loading_dialog.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/widgets/common_widgets/custom_button.dart';
import '../../../../core/widgets/common_widgets/custom_text_field.dart';
import '../../../../core/widgets/common_widgets/toast_helper.dart';
import '../../../store/screen/store_create_screen.dart';
import '../../../store/screen/store_select_screen.dart';
import '../../bloc/auth_bloc.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const route = 'LoginScreen';

  const LoginScreen({super.key});

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
                    'Đăng nhập tài khoản',
                    style: AppTextStyle.semibold(kTextSizeXxl, kColorWhite),
                  ),
                  const SizedBox(height: kMarginMd),
                  Text(
                    'Đăng nhập bằng Google hoặc số điện thoại của bạn',
                    style: AppTextStyle.medium(kTextSizeSm, kColorWhite),
                  ),
                  const SizedBox(height: kMarginXxl),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: kMarginMd),
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
                              SizedBox(
                                height: kHeightMd,
                                width: double.infinity,
                                child: BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthLoginSuccess) {
                                      if (state.isNewUser) {
                                        Navigator.pushNamed(
                                            context, StoreCreateScreen.route);
                                      } else {
                                        Navigator.pushNamed(
                                            context, StoreSelectScreen.route);
                                      }
                                      ToastHelper.showToast(context, 'Đăng nhập thành công', 'tài khoản của bạn đã được đăng nhập vào ứng dụng', ToastificationType.success);
                                    } else if (state is AuthLoginFailure) {
                                      ToastHelper.showToast(context, 'Đăng nhập thất bại', 'vui lòng đăng nhập lại để tiếp tục', ToastificationType.error);
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButton(
                                      iconImage: Image.asset(
                                        'assets/images/google_icon.png',
                                        height: 20,
                                      ),
                                      text: 'Đăng nhập với Google',
                                      isOutlineButton: true,
                                      borderColor: kColorLightGrey,
                                      textStyle: AppTextStyle.medium(kTextSizeMd),
                                      onPressed: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(AuthLoginWithGoogle());
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: kMarginMd),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: kColorLightGrey,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: kPaddingMd,
                                    ),
                                  ),
                                  Text(
                                    'Hoặc',
                                    style: AppTextStyle.medium(
                                        kTextSizeSm, kColorGrey),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: kColorLightGrey,
                                      thickness: 1,
                                      indent: kPaddingMd,
                                      endIndent: 0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: kMarginMd),
                              const CustomTextField(
                                hintText: 'Số điện thoại',
                                isNumeric: true,
                              ),
                              const SizedBox(height: kMarginMd),
                              CustomButton(
                                text: 'Đăng nhập',
                                onPressed: () {},
                              ),
                              const SizedBox(height: kMarginMd),
                              RichText(
                                text: TextSpan(
                                  style:
                                      AppTextStyle.medium(kTextSizeSm).copyWith(
                                    color: kColorGrey,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Bạn không có tài khoản? ',
                                      style: AppTextStyle.medium(
                                          kTextSizeSm, kColorGrey),
                                    ),
                                    TextSpan(
                                      text: 'Đăng ký',
                                      style: AppTextStyle.medium(
                                          kTextSizeSm, kColorPrimary),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, RegisterScreen.route);
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
                ],
              ),
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoginInProgress) {
                return const LoadingDialog();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
