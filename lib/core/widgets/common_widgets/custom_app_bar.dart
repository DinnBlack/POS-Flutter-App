import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../utils/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Widget? leading;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;
  final bool isTitleCenter;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const CustomAppBar({
    Key? key,
    this.title,
    this.subtitle,
    this.backgroundColor = kColorWhite,
    this.titleColor = kColorBlack,
    this.subtitleColor = kColorBlack,
    this.leading,
    this.onLeadingTap,
    this.actions,
    this.isTitleCenter = false,
    this.titleStyle,
    this.subtitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kHeightMd),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingLg),
        alignment: Alignment.center,
        color: backgroundColor,
        child: SafeArea(
          child: isTitleCenter
              ? Stack(
                  children: [
                    // Centered title and subtitle in Column
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              style: titleStyle ??
                                  AppTextStyle.semibold(
                                      kTextSizeMd, titleColor!),
                            ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: subtitleStyle ??
                                  AppTextStyle.medium(
                                      kTextSizeSm, subtitleColor!),
                            ),
                        ],
                      ),
                    ),
                    // Leading widget
                    if (leading != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap:
                              onLeadingTap ?? () => Navigator.of(context).pop(),
                          child: leading!,
                        ),
                      ),
                    // Actions widget
                    if (actions != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: actions!
                              .map((action) => Padding(
                                    padding:
                                        const EdgeInsets.only(left: kMarginMd),
                                    child: action,
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                )
              : Row(
                  children: [
                    // Leading widget
                    if (leading != null)
                      GestureDetector(
                        onTap:
                            onLeadingTap ?? () => Navigator.of(context).pop(),
                        child: leading!,
                      ),
                    if (leading != null) const SizedBox(width: kMarginMd),
                    // Title and subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              style: titleStyle ??
                                  AppTextStyle.semibold(
                                      kTextSizeLg, titleColor!),
                            ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: subtitleStyle ??
                                  AppTextStyle.medium(
                                      kTextSizeSm, subtitleColor!),
                            ),
                        ],
                      ),
                    ),
                    // Actions widget
                    if (actions != null)
                      Row(
                        children: actions!
                            .map((action) => Padding(
                                  padding:
                                      const EdgeInsets.only(left: kMarginMd),
                                  child: action,
                                ))
                            .toList(),
                      ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
