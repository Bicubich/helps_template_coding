import 'dart:async';

import 'package:bloc/bloc.dart';

class PresentWidgetCubit extends Cubit<int?> {
  PresentWidgetCubit() : super(30) {
    _init();
  }

  _init() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (state == 0) {
        emit(null);
      } else {
        emit(state! - 1);
      }
    });
  }
}
