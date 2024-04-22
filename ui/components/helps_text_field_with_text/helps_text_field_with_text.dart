import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/components/helps_text_field_with_text/components/helps_text_field_with_text_text_field.dart';
import 'package:helps_flutter/ui/components/helps_text_field_with_text/cubit/helps_text_field_with_text_cubit.dart';

class HelpsTextFieldWithText extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final String? labelFloating;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final int minLines;
  final int? maxLines;
  final String? prefixText;
  final String? errorText;
  final RegExp? regExp;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;

  const HelpsTextFieldWithText({
    required this.controller,
    this.hintText,
    this.validator,
    super.key,
    this.label,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.minLines = 1,
    this.prefixText,
    this.errorText,
    this.regExp,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.maxLines,
    this.labelFloating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (label != null)
          Container(
            padding: getMarginOrPadding(right: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              '$label:',
              style: UiConstants.kTextStyleText3
                  .copyWith(color: UiConstants.kColorBase01),
            ),
          ),
        BlocProvider(
          create: (context) => HelpsTextFieldWithTextCubit(),
          child: HelpsTextFieldWithTextTextField(
              controller: controller,
              inputFormatters: inputFormatters,
              hintText: hintText,
              label: label,
              labelFloating: labelFloating,
              minLines: minLines,
              maxLines: maxLines,
              prefixText: prefixText,
              validator: validator,
              regExp: regExp,
              errorText: errorText,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              maxLength: maxLength,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: contentPadding),
        )
      ],
    );
  }
}
