import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:helps_flutter/constants/paths.dart';

class AnnouncementSelectCityCubit extends Cubit<List<String>> {
  AnnouncementSelectCityCubit() : super([]) {
    _init();
  }

  Future _init() async {
    List<String> cityList = await parseCitiesFromJson();
    emit(cityList);
  }

  Future<List<String>> parseCitiesFromJson() async {
    final String jsonString = await rootBundle.loadString(Paths.citiesDataPath);
    final List<dynamic> jsonList = json.decode(jsonString);

    final List<String> cityNames = [];
    for (final city in jsonList) {
      cityNames.add(city['name']);
    }

    return cityNames;
  }
}
