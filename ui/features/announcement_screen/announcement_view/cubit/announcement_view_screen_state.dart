part of 'announcement_view_screen_cubit.dart';

abstract class AnnouncementViewScreenState extends Equatable {
  const AnnouncementViewScreenState();

  @override
  List<Object> get props => [];
}

class AnnouncementViewScreenLoading extends AnnouncementViewScreenState {}

class AnnouncementViewScreenLoaded extends AnnouncementViewScreenState {
  final List<AnnouncementResponseModel> announcementList;

  const AnnouncementViewScreenLoaded({
    required this.announcementList,
  });

  @override
  List<Object> get props => [announcementList];
}
