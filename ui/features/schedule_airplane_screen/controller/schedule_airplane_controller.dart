import 'package:flutter/material.dart';

class AirplaneScheduleController {
  static String getArgumentRegion(BuildContext context) {
    // Получаем аргументы из текущего маршрута
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return args!['region'];
  }

  static int countIntervals(DateTime start, DateTime end) {
    // Проверяем, что end > start
    if (end.isBefore(start)) {
      throw ArgumentError("End time must be after start time");
    }

    // Вычисляем разницу между end и start в минутах
    int differenceInMinutes = end
        .copyWith(minute: 0, hour: end.hour + 1)
        .difference(start.copyWith(minute: 0, hour: start.hour))
        .inMinutes;

    // Вычисляем количество промежутков, округляя вверх
    int numberOfIntervals = differenceInMinutes ~/ Duration(hours: 1).inMinutes;

    return numberOfIntervals;
  }

  static String getMonthNameInGenitiveCase(DateTime date) => [
        'января',
        'февраля',
        'марта',
        'апреля',
        'мая',
        'июня',
        'июля',
        'августа',
        'сентября',
        'октября',
        'ноября',
        'декабря',
      ][date.month - 1];
}
