part of 'schedule_bridge_screen_cubit.dart';

abstract class ScheduleBridgeScreenState extends Equatable {
  const ScheduleBridgeScreenState();

  @override
  List<Object> get props => [];
}

class ScheduleBridgeScreenLoaded extends ScheduleBridgeScreenState {
  final List<BridgeScheduleModel> bridgeScheduleList;

  const ScheduleBridgeScreenLoaded({
    required this.bridgeScheduleList,
  });

  @override
  List<Object> get props => [bridgeScheduleList];
}

class ScheduleBridgeScreenLoading extends ScheduleBridgeScreenState {}

class ScheduleBridgeScreenError extends ScheduleBridgeScreenState {}
