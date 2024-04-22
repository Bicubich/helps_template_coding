import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helps_flutter/model/sos_stream_model.dart';
import 'package:helps_flutter/model/user_stream_model.dart';

class UserPointModel {
  Marker marker;
  UserStreamModel? userStream;
  SosStreamModel? sosStream;
  bool isAnimationReversed;
  Timer? animationTimer;

  UserPointModel({
    required this.marker,
    this.userStream,
    this.sosStream,
    this.isAnimationReversed = false,
    this.animationTimer,
  });

  setMarker(Marker marker) {
    this.marker = marker;
  }

  setSosStream(SosStreamModel sosStream) {
    this.sosStream = sosStream;
  }

  setUserStream(UserStreamModel userStream) {
    this.userStream = userStream;
  }
}
