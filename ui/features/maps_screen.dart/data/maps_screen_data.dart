import 'package:helps_flutter/constants/paths.dart';

class MapsScreenData {
  static Map<mapsIconType, String> mapsIcon = {
    mapsIconType.user: Paths.userCarPath,
    mapsIconType.userSos: Paths.userCarSosPath,
    mapsIconType.friend: Paths.friendCarPath,
    mapsIconType.friendSos: Paths.friendCarSosPath,
    mapsIconType.dps_100: Paths.dps100Path,
    mapsIconType.dps_150: Paths.dps150Path,
    mapsIconType.girl_100: Paths.girl100Path,
    mapsIconType.girl_150: Paths.girl150Path,
  };
}

enum mapsIconType {
  user,
  userSos,
  friend,
  friendSos,
  dps_100,
  dps_150,
  girl_100,
  girl_150,
}
