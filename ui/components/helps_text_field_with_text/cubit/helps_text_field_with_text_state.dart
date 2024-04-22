part of 'helps_text_field_with_text_cubit.dart';

class HelpsTextFieldWithTextState extends Equatable {
  final bool isValid;
  final bool isNotEmpty;
  final String? errorText;

  const HelpsTextFieldWithTextState(
      {required this.isValid, required this.isNotEmpty, this.errorText});

  @override
  List<Object?> get props => [isValid, errorText];
}
