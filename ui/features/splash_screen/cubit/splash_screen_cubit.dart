import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:helps_flutter/constants/utils.dart';

class SplashScreenCubit extends Cubit<void> {
  final BuildContext context;
  SplashScreenCubit(this.context) : super(()) {
    init(context);
  }

  init(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    Utils.pushToInitialScreen(context);
  }
}
