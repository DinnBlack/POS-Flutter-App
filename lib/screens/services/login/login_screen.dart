import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/screens/services/register/register_screen.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../../features/auth/bloc/auth_bloc.dart';
import '../../../widgets/common_widgets/custom_button.dart';
import '../../../widgets/common_widgets/custom_text_field.dart';
import '../store/store_create_screen.dart';
import '../store/store_select_screen.dart';

class LoginScreen extends StatelessWidget {
  static const route = 'LoginScreen';

  const LoginScreen({super.key});

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
                    'Đăng nhập tài khoản',
                    style: AppTextStyle.semibold(
                        SUPER_LARGE_TEXT_SIZE, WHITE_COLOR),
                  ),
                  const SizedBox(height: DEFAULT_MARGIN),
                  Text(
                    'Đăng nhập bằng Google hoặc số điện thoại của bạn',
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
                        SizedBox(
                          height: DEFAULT_HEIGHT,
                          width: double.infinity,
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthLoginSuccess) {
                                if (state.isNewUser) {
                                  Navigator.pushNamed(context, StoreCreateScreen.route);
                                } else {
                                  Navigator.pushNamed(context, StoreSelectScreen.route);
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login successful!')),
                                );
                              } else if (state is AuthLoginFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return OutlinedButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthLoginWithGoogle());
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: WHITE_COLOR,
                                  side: BorderSide(color: GREY_LIGHT_COLOR),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        DEFAULT_BORDER_RADIUS),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google_icon.png',
                                      height: 20,
                                    ),
                                    const SizedBox(width: DEFAULT_MARGIN),
                                    Text(
                                      'Đăng nhập với Google',
                                      style:
                                          AppTextStyle.medium(MEDIUM_TEXT_SIZE),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: MEDIUM_MARGIN),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Divider(
                                color: GREY_LIGHT_COLOR,
                                thickness: 1,
                                indent: 0,
                                endIndent: DEFAULT_PADDING,
                              ),
                            ),
                            Text(
                              'Hoặc',
                              style: AppTextStyle.medium(SMALL_TEXT_SIZE),
                            ),
                            Expanded(
                              child: Divider(
                                color: GREY_LIGHT_COLOR,
                                thickness: 1,
                                indent: DEFAULT_PADDING,
                                endIndent: 0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MEDIUM_MARGIN),
                        const CustomTextField(
                          hintText: 'Số điện thoại',
                          isNumeric: true,
                        ),
                        const SizedBox(height: MEDIUM_MARGIN),
                        CustomButton(
                          text: 'Đăng nhập',
                          onPressed: () {},
                        ),
                        const SizedBox(height: MEDIUM_MARGIN),
                        RichText(
                          text: TextSpan(
                            style:
                                AppTextStyle.medium(SMALL_TEXT_SIZE).copyWith(
                              color: GREY_COLOR,
                            ),
                            children: [
                              TextSpan(
                                text: 'Bạn không có tài khoản? ',
                                style: AppTextStyle.medium(
                                    SMALL_TEXT_SIZE, GREY_COLOR),
                              ),
                              TextSpan(
                                text: 'Đăng ký',
                                style: AppTextStyle.medium(
                                    SMALL_TEXT_SIZE, PRIMARY_COLOR),
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
                ],
              ),
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoginInProgress) {
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
