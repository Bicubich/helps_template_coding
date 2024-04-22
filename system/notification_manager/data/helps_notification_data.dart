class HelpsNotificationData {
  static const String channelWithoutSound = 'Notification Without Sound';
  static const String channelWitSound = 'Notification With Sound';
  static const String sosChannelId = 'firebase_sos_notification';
  static const String sosChannelWithoutSoundId =
      'firebase_sos_notification_without_sound';
  static const String dpsChannelId = 'dps_notification';
  static const String dpsChannelWithoutSoundId =
      'dps_notification_without_sound';
  static const String bridgesChannelId = 'firebase_bridges_notification';
  static const String bridgesChannelWithoutSoundId =
      'firebase_bridges_notification_without_sound';
  static const String othersChannelId = 'Firebase Others Notification';
  static const String othersChannelWithoutSoundId =
      'Firebase Others Notification_without_sound';
}

enum HelpsNotificationType { sos, dps, bridges, others }
