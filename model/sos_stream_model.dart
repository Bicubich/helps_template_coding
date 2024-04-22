import 'dart:convert';

class SosStreamModel {
  final String id;
  final bool isActive;
  final double lat;
  final double lon;
  final DateTime dateStart;
  final User user;
  final int v;

  SosStreamModel({
    required this.id,
    required this.isActive,
    required this.lat,
    required this.lon,
    required this.dateStart,
    required this.user,
    required this.v,
  });

  SosStreamModel copyWith({
    String? id,
    bool? isActive,
    double? lat,
    double? lon,
    DateTime? dateStart,
    User? user,
    int? v,
  }) =>
      SosStreamModel(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        dateStart: dateStart ?? this.dateStart,
        user: user ?? this.user,
        v: v ?? this.v,
      );

  factory SosStreamModel.fromRawJson(String str) =>
      SosStreamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SosStreamModel.fromJson(Map<String, dynamic> json) => SosStreamModel(
        id: json["_id"],
        isActive: json["isActive"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        dateStart: DateTime.parse(json["dateStart"]),
        user: User.fromJson(json["user"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "lat": lat,
        "lon": lon,
        "dateStart": dateStart.toIso8601String(),
        "user": user.toJson(),
        "__v": v,
      };
}

class User {
  final String id;
  final String? name;
  final String? phone;
  final String? surname;
  final String? carBrand;
  final String? carColor;
  final String? carModel;
  final String? licensePlate;

  User({
    required this.id,
    this.name,
    this.phone,
    this.surname,
    this.carBrand,
    this.carColor,
    this.carModel,
    this.licensePlate,
  });

  User copyWith({
    String? id,
    String? name,
    String? phone,
    String? surname,
    String? carBrand,
    String? carColor,
    String? carModel,
    String? licensePlate,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        surname: surname ?? this.surname,
        carBrand: carBrand ?? this.carBrand,
        carColor: carColor ?? this.carColor,
        carModel: carModel ?? this.carModel,
        licensePlate: licensePlate ?? this.licensePlate,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        surname: json["surname"],
        carBrand: json["carBrand"],
        carColor: json["carColor"],
        carModel: json["carModel"],
        licensePlate: json["licensePlate"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "surname": surname,
        "carBrand": carBrand,
        "carColor": carColor,
        "carModel": carModel,
        "licensePlate": licensePlate,
      };
}
