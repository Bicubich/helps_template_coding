import 'package:equatable/equatable.dart';

class TomasTextFieldWithTextState extends Equatable {
  final bool isValid;
  final bool isNotEmpty;
  final String? errorText;

  const TomasTextFieldWithTextState(
      {required this.isValid, required this.isNotEmpty, this.errorText});

  @override
  List<Object?> get props => [isValid, errorText];
}
