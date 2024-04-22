import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helps_flutter/system/sqllite_manager.dart';
import 'package:helps_flutter/ui/features/settings_screen/data/settings_data.dart';
import 'package:helps_flutter/ui/features/settings_screen/model/settings_model.dart';

part 'settings_screen_state.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  SettingsScreenCubit() : super(SettingsScreenLoading()) {
    _init();
  }

  Future _init() async {
    List<List<SettingsModel>> settingsList = [...SettingsData.settingsData];
    await SqlLiteManager.initializeDatabase();
    for (List<SettingsModel> settingGroup in settingsList) {
      for (SettingsModel settingsItem in settingGroup) {
        bool switchStatus =
            SqlLiteManager.getSetting(settingsItem.sharedPreferencesKey);
        settingsItem.switchStatus = switchStatus;
      }
    }
    SqlLiteManager.closeDatabase();
    emit(SettingsScreenLoaded(settingsList: settingsList));
  }

  changeSwitch() {}
}
