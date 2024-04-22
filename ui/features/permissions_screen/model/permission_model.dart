import 'package:permission_handler/permission_handler.dart';

class PermissionModel {
  final Permission permission;
  final int? minAndroidApiVersion;
  final int? minIOSVersion;
  bool isGranted;
  final String name;
  final String description;

  PermissionModel({
    required this.permission,
    this.minAndroidApiVersion,
    this.minIOSVersion,
    this.isGranted = false,
    required this.name,
    required this.description,
  });
}
