part of 'profile_screen_cubit.dart';

abstract class ProfileScreenState extends Equatable {
  const ProfileScreenState();

  @override
  List<Object> get props => [];
}

class ProfileScreenLoading extends ProfileScreenState {}

class ProfileScreenError extends ProfileScreenState {}

class ProfileScreenLoaded extends ProfileScreenState {
  final UserModel user;

  const ProfileScreenLoaded({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
