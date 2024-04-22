part of 'background_shading_cubit.dart';

sealed class BackgroundShadingState extends Equatable {
  const BackgroundShadingState();

  @override
  List<Object> get props => [];
}

final class BackgroundShadingActive extends BackgroundShadingState {}

final class BackgroundShadingInactive extends BackgroundShadingState {}
