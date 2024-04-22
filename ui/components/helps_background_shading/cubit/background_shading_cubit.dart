import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'background_shading_state.dart';

class BackgroundShadingCubit extends Cubit<BackgroundShadingState> {
  BackgroundShadingCubit() : super(BackgroundShadingInactive());

  Future activate() async {
    emit(BackgroundShadingActive());
  }

  Future hide() async {
    emit(BackgroundShadingInactive());
  }
}
