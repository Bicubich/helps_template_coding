class SettingsModel {
  SettingsModel({
    required this.name,
    required this.groupName,
    required this.sharedPreferencesKey,
    this.switchStatus = false,
  });

  final String name;
  final String groupName;
  final String sharedPreferencesKey;
  bool switchStatus;
}
