part of 'settings_screen_cubit.dart';

abstract class SettingsScreenState extends Equatable {
  const SettingsScreenState();

  @override
  List<Object> get props => [];
}

class SettingsScreenLoading extends SettingsScreenState {}

class SettingsScreenLoaded extends SettingsScreenState {
  final List<List<SettingsModel>> settingsList;

  const SettingsScreenLoaded({
    required this.settingsList,
  });

  @override
  List<Object> get props => [settingsList];
}
