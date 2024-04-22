import 'dart:convert';

class UserStreamModel {
  final int v;
  final String id;
  final double angle;
  final double lat;
  final double lon;
  final Region region;
  final DateTime updateDate;
  final String user;

  UserStreamModel({
    required this.v,
    required this.id,
    required this.angle,
    required this.lat,
    required this.lon,
    required this.region,
    required this.updateDate,
    required this.user,
  });

  UserStreamModel copyWith({
    int? v,
    String? id,
    double? angle,
    double? lat,
    double? lon,
    Region? region,
    DateTime? updateDate,
    String? user,
  }) =>
      UserStreamModel(
        v: v ?? this.v,
        id: id ?? this.id,
        angle: angle ?? this.angle,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        region: region ?? this.region,
        updateDate: updateDate ?? this.updateDate,
        user: user ?? this.user,
      );

  factory UserStreamModel.fromRawJson(String str) =>
      UserStreamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserStreamModel.fromJson(Map<String, dynamic> json) =>
      UserStreamModel(
        v: json["__v"],
        id: json["_id"],
        angle: double.parse(json["angle"].toString()),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        region: Region.fromJson(json["region"]),
        updateDate: DateTime.parse(json["updateDate"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "__v": v,
        "_id": id,
        "angle": angle,
        "lat": lat,
        "lon": lon,
        "region": region.toJson(),
        "updateDate": updateDate.toIso8601String(),
        "user": user,
      };
}

class Region {
  final double lat;
  final double lon;
  final String name;

  Region({
    required this.lat,
    required this.lon,
    required this.name,
  });

  Region copyWith({
    double? lat,
    double? lon,
    String? name,
  }) =>
      Region(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        name: name ?? this.name,
      );

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "name": name,
      };
}

class MarksInRange {
  final double lat;
  final double lon;
  final String type;
  final String id;
  final bool isActive;

  MarksInRange({
    required this.lat,
    required this.lon,
    required this.type,
    required this.id,
    required this.isActive,
  });

  MarksInRange copyWith({
    double? lat,
    double? lon,
    String? type,
    String? id,
    bool? isActive,
  }) =>
      MarksInRange(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        type: type ?? this.type,
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
      );

  factory MarksInRange.fromRawJson(String str) =>
      MarksInRange.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarksInRange.fromJson(Map<String, dynamic> json) => MarksInRange(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        type: json["type"],
        id: json["_id"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "type": type,
        "_id": id,
        "isActive": isActive,
      };
}
