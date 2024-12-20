import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

import '../../utils/format_text.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final bool isPassword;
  final bool isNumeric;
  final bool isPhoneNumber;
  final String? title;
  final bool isRequired;
  final TextEditingController? controller;
  final bool autofocus;
  final double? height;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.isPassword = false,
    this.isNumeric = false,
    this.isPhoneNumber = false,
    this.title,
    this.isRequired = false,
    this.controller,
    this.autofocus = false,
    this.height,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validateInput(String value) {
    if (widget.isRequired && value.isEmpty) {
      setState(() {
        _errorText = 'This field is required';
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      if (!_focusNode.hasFocus) {
        _validateInput(widget.controller?.text ?? '');
      }
    });
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Text(
                  widget.title!,
                  style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                ),
                if (widget.isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
          height: widget.height ?? kHeightMd,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: _focusNode.hasFocus ? kColorPrimary : kColorLightGrey,
            ),
            color: kColorWhite,
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLines ?? 1,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType:
                widget.isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters: widget.isNumeric
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyle.regular(kTextSizeMd, kColorGrey),
              border: InputBorder.none,
              isDense: true,
              errorText: _errorText,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: kColorGrey,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : null,
            ),
            onChanged: (value) {
              String formattedValue = value;

              if (widget.isNumeric && !widget.isPhoneNumber) {
                String cleanedValue =
                    value.replaceAll('.', '').replaceAll('đ', '').trim();
                final intValue = int.tryParse(cleanedValue) ?? 0;
                formattedValue = FormatText.formatCurrency(intValue);
              }

              if (widget.isPhoneNumber) {
                formattedValue = value;
              }

              widget.controller!.text = formattedValue;
              widget.controller!.selection = TextSelection.fromPosition(
                  TextPosition(offset: formattedValue.length));

              widget.onChanged?.call(formattedValue);
              _validateInput(value);
            },
            autofocus: widget.autofocus,
          ),
        ),
      ],
    );
  }
}
