part of 'schedule_airplane_screen_cubit.dart';

abstract class ScheduleAirplaneScreenState extends Equatable {
  const ScheduleAirplaneScreenState();

  @override
  List<Object> get props => [];
}

class ScheduleAirplaneScreenLoaded extends ScheduleAirplaneScreenState {
  final List<AirplaneScheduleModel> airplaneScheduleList;

  const ScheduleAirplaneScreenLoaded({
    required this.airplaneScheduleList,
  });

  @override
  List<Object> get props => [airplaneScheduleList];
}

class ScheduleAirplaneScreenLoading extends ScheduleAirplaneScreenState {}

class ScheduleAirplaneScreenError extends ScheduleAirplaneScreenState {}
