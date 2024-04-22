import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';

part 'helps_text_field_with_text_state.dart';

class HelpsTextFieldWithTextCubit extends Cubit<HelpsTextFieldWithTextState> {
  HelpsTextFieldWithTextCubit()
      : super(const HelpsTextFieldWithTextState(
            isValid: true, isNotEmpty: false));

  void onEditingComplete(String value,
      {RegExp? regExp, String? customErrorText}) {
    bool isValid = true;
    bool isNotEmpty = false;
    String? errorText;

    if (value.isEmpty) {
      isValid = false;
      errorText = LocaleKeys.kTextRequiredField.tr();
    } else {
      isNotEmpty = true;
      if (regExp != null) {
        isValid = regExp.hasMatch(value);
        if (!isValid) {
          errorText = customErrorText ?? '';
        }
      }
    }

    emit(HelpsTextFieldWithTextState(
        isValid: isValid, isNotEmpty: isNotEmpty, errorText: errorText));
  }
}
