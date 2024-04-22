class BridgeScheduleController {
  static bool isBridgeOpen(DateTime startTime, DateTime endTime) {
    DateTime now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  static String formatTimeRange(DateTime startTime, DateTime endTime) {
    String startFormatted =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    String endFormatted =
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$startFormatted - $endFormatted';
  }
}
