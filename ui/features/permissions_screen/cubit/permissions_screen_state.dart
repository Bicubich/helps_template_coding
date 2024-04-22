import 'package:equatable/equatable.dart';

abstract class PermissionsScreenState extends Equatable {
  const PermissionsScreenState();

  @override
  List<Object> get props => [];
}

class PermissionsScreenInitial extends PermissionsScreenState {}

class PermissionsScreenUpdating extends PermissionsScreenState {}
