import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/api/model/airplane_schedule_model.dart';

part 'schedule_airplane_screen_state.dart';

class ScheduleAirplaneScreenCubit extends Cubit<ScheduleAirplaneScreenState> {
  final String region;
  ScheduleAirplaneScreenCubit(this.region)
      : super(ScheduleAirplaneScreenLoading()) {
    _init();
  }

  List<AirplaneScheduleModel> airplaneScheduleList = [];

  Future _init() async {
    await getScheduleData();
  }

  Future getScheduleData() async {
    emit(ScheduleAirplaneScreenLoading());
    try {
      airplaneScheduleList = await HelpsApi.getAirplaneSchedule(region);
    } catch (e) {
      emit(ScheduleAirplaneScreenError());
      return;
    }

    emit(ScheduleAirplaneScreenLoaded(
        airplaneScheduleList: airplaneScheduleList));
  }
}
