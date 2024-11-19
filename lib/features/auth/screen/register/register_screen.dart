import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

import '../../../../core/widgets/common_widgets/custom_button.dart';
import '../../../../core/widgets/common_widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  static const route = 'RegisterScreen';

  const RegisterScreen({super.key});

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
                    'Đăng kí tài khoản',
                    style: AppTextStyle.semibold(
                        kTextSizeXxl, kColorWhite),
                  ),
                  const SizedBox(height: kMarginMd),
                  Text(
                    'Đăng nhập bằng Goole hoặc số điện thoại của bạn',
                    style: AppTextStyle.medium(kTextSizeMd, kColorWhite),
                  ),
                  const SizedBox(height: kMarginXxl),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: kMarginMd),
                    padding: const EdgeInsets.all(kPaddingLg),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(kBorderRadiusMd),
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
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: kColorWhite,
                              side: BorderSide(color: kColorLightGrey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    kBorderRadiusMd),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_icon.png',
                                  height: 20,
                                ),
                                const SizedBox(width: kMarginMd),
                                Text(
                                  'Đăng nhập với Google',
                                  style: AppTextStyle.medium(kTextSizeMd),
                                ),
                              ],
                            ),
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
                              style: AppTextStyle.medium(kTextSizeSm),
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
                              color:
                              kColorGrey,
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
                                        context, 'RegisterScreen');
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
        ],
      ),
    );
  }
}
