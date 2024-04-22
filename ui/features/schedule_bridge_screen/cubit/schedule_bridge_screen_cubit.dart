import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/api/model/bridge_schedule_model.dart';

part 'schedule_bridge_screen_state.dart';

class ScheduleBridgeScreenCubit extends Cubit<ScheduleBridgeScreenState> {
  ScheduleBridgeScreenCubit() : super(ScheduleBridgeScreenLoading()) {
    _init();
  }

  List<BridgeScheduleModel> bridgeScheduleList = [];

  Future _init() async {
    await getScheduleData();
  }

  Future getScheduleData() async {
    emit(ScheduleBridgeScreenLoading());
    try {
      bridgeScheduleList = await HelpsApi.getBridgeSchedule();
    } catch (e) {
      emit(ScheduleBridgeScreenError());
      return;
    }

    emit(ScheduleBridgeScreenLoaded(bridgeScheduleList: bridgeScheduleList));
  }
}
