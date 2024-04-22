import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/components/helps_text_field_with_text/cubit/helps_text_field_with_text_cubit.dart';

class HelpsTextFieldWithTextTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final String? labelFloating;
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

  const HelpsTextFieldWithTextTextField(
      {required this.controller,
      this.hintText,
      this.validator,
      this.label,
      this.minLines = 1,
      this.prefixText,
      this.errorText,
      this.regExp,
      super.key,
      this.inputFormatters,
      this.textInputAction,
      this.keyboardType,
      this.maxLength,
      this.prefixIcon,
      this.suffixIcon,
      this.contentPadding,
      this.maxLines,
      this.labelFloating});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          BlocBuilder<HelpsTextFieldWithTextCubit, HelpsTextFieldWithTextState>(
        builder: (context, state) {
          return TextFormField(
            inputFormatters: inputFormatters,
            minLines: minLines,
            maxLines: maxLines ?? minLines,
            controller: controller,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            maxLength: maxLength,
            decoration: InputDecoration(
              label: labelFloating != null ? Text(labelFloating!) : null,
              labelStyle: UiConstants.kTextStyleText4
                  .copyWith(color: UiConstants.kColorBase07),
              floatingLabelStyle: UiConstants.kTextStyleText4
                  .copyWith(color: UiConstants.kColorBase07),
              prefixIcon: prefixIcon,
              counterText: controller.text.isNotEmpty ? null : '',
              counterStyle: UiConstants.kTextStyleText9
                  .copyWith(color: UiConstants.kColorPrimary),
              prefixText: prefixText,
              fillColor: UiConstants.kColorBase01.withOpacity(0.2),
              filled: true,
              errorText: state.errorText,
              hintText: hintText,
              hintStyle: UiConstants.kTextStyleText4
                  .copyWith(color: UiConstants.kColorBase07),
              errorStyle: UiConstants.kTextStyleText4
                  .copyWith(color: UiConstants.kColorError, fontSize: 14.sp),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: UiConstants.kColorError),
                borderRadius: BorderRadius.circular(12.r),
              ),
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              enabledBorder: OutlineInputBorder(
                borderSide: state.isNotEmpty && state.isValid
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              border: OutlineInputBorder(
                borderSide: state.isNotEmpty && state.isValid
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: state.isNotEmpty && state.isValid
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: getMarginOrPadding(all: 2.w),
                      child: suffixIcon,
                    )
                  : (state.isNotEmpty && state.isValid
                      ? Padding(
                          padding: getMarginOrPadding(right: 24.w),
                          child: SvgPicture.asset(
                            Paths.checkIconPath,
                            semanticsLabel: 'Icon',
                            width: 24.w,
                            height: 24.w,
                            color: UiConstants.kColorSuccess,
                          ),
                        )
                      : null),
            ),
            style: UiConstants.kTextStyleText3.copyWith(
                color: UiConstants.kColorBase01, decorationThickness: 0),
            cursorColor: UiConstants.kColorBase01,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) => context
                .read<HelpsTextFieldWithTextCubit>()
                .onEditingComplete(controller.text,
                    regExp: regExp, customErrorText: errorText),
          );
        },
      ),
    );
  }
}
