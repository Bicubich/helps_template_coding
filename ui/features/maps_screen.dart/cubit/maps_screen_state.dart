import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/model/user_point_model.dart';

abstract class MapsScreenState extends Equatable {
  const MapsScreenState();

  @override
  List<Object> get props => [];
}

class MapsScreenLoading extends MapsScreenState {}

class MapsScreenLocationPermissionDenied extends MapsScreenState {}

class MapsScreenLocationServiceDisable extends MapsScreenState {}

class MapsScreenUpdating extends MapsScreenState {}

class MapsScreenLoaded extends MapsScreenState {
  final LatLng userPosition;
  final double currentZoom;
  final List<UserPointModel> userPointList;
  final List<Marker> nonUserMarks;

  const MapsScreenLoaded({
    required this.userPosition,
    required this.currentZoom,
    required this.userPointList,
    required this.nonUserMarks,
  });

  MapsScreenLoaded copyWith({
    LatLng? userPosition,
    double? currentZoom,
    List<UserPointModel>? userPointList,
    List<Marker>? nonUserMarks,
  }) {
    return MapsScreenLoaded(
      userPosition: userPosition ?? this.userPosition,
      currentZoom: currentZoom ?? this.currentZoom,
      userPointList: userPointList ?? this.userPointList,
      nonUserMarks: nonUserMarks ?? this.nonUserMarks,
    );
  }

  @override
  List<Object> get props =>
      [userPosition, currentZoom, userPointList, nonUserMarks];
}
