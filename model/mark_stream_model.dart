import 'dart:convert';

class MarkStreamModel {
  final String id;
  final bool isActive;
  final double? lat;
  final double? lon;
  final String? type;

  MarkStreamModel({
    required this.id,
    required this.isActive,
    required this.lat,
    required this.lon,
    required this.type,
  });

  MarkStreamModel copyWith({
    String? id,
    bool? isActive,
    double? lat,
    double? lon,
    String? type,
  }) =>
      MarkStreamModel(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        type: type ?? this.type,
      );

  factory MarkStreamModel.fromRawJson(String str) =>
      MarkStreamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarkStreamModel.fromJson(Map<String, dynamic> json) =>
      MarkStreamModel(
        id: json["_id"],
        isActive: json["isActive"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "lat": lat,
        "lon": lon,
        "type": type,
      };
}

enum MarkStreamType { traffic_police }
