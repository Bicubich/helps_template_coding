import 'dart:convert';

class AnnouncementModel {
  final String carBrand;
  final String carModel;
  final String carClass;
  final String city;
  final String manufactoryYear;
  final String description;
  final String phone;
  final int pledge;
  final int rentPrice;
  final String subway;
  final String telegram;
  final String whatsapp;

  AnnouncementModel({
    required this.carBrand,
    required this.carModel,
    required this.carClass,
    required this.city,
    required this.manufactoryYear,
    required this.description,
    required this.phone,
    required this.pledge,
    required this.rentPrice,
    required this.subway,
    required this.telegram,
    required this.whatsapp,
  });

  AnnouncementModel copyWith({
    String? carBrand,
    String? carModel,
    String? carClass,
    String? city,
    String? manufactoryYear,
    String? description,
    String? phone,
    int? pledge,
    int? rentPrice,
    String? subway,
    String? telegram,
    String? whatsapp,
  }) =>
      AnnouncementModel(
        carBrand: carBrand ?? this.carBrand,
        carModel: carModel ?? this.carModel,
        carClass: carClass ?? this.carClass,
        city: city ?? this.city,
        manufactoryYear: manufactoryYear ?? this.manufactoryYear,
        description: description ?? this.description,
        phone: phone ?? this.phone,
        pledge: pledge ?? this.pledge,
        rentPrice: rentPrice ?? this.rentPrice,
        subway: subway ?? this.subway,
        telegram: telegram ?? this.telegram,
        whatsapp: whatsapp ?? this.whatsapp,
      );

  factory AnnouncementModel.fromRawJson(String str) =>
      AnnouncementModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        carClass: json["carClass"],
        city: json["city"],
        manufactoryYear: json["manufactoryYear"],
        description: json["description"],
        phone: json["phone"],
        pledge: json["pledge"],
        rentPrice: json["rentPrice"],
        subway: json["subway"],
        telegram: json["telegram"],
        whatsapp: json["whatsapp"],
      );

  Map<String, dynamic> toJson() => {
        "carBrand": carBrand,
        "carModel": carModel,
        "carClass": carClass,
        "city": city,
        "manufactoryYear": manufactoryYear,
        "description": description,
        "phone": phone,
        "pledge": pledge,
        "rentPrice": rentPrice,
        "subway": subway,
        "telegram": telegram,
        "whatsapp": whatsapp,
      };
}
