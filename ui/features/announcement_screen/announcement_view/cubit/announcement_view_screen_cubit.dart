import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helps_flutter/api/model/announcement_response_model.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/data/announcement_data.dart';

part 'announcement_view_screen_state.dart';

class AnnouncementViewScreenCubit extends Cubit<AnnouncementViewScreenState> {
  final bool isShowMyAnnouncement;
  final String? city;
  AnnouncementViewScreenCubit(
      {required this.isShowMyAnnouncement, required this.city})
      : super(AnnouncementViewScreenLoading()) {
    _init();
  }

  Future _init() async {
    await getAnnouncementData();
  }

  Future getAnnouncementData() async {
    emit(AnnouncementViewScreenLoading());
    List<AnnouncementResponseModel> announcementList = [];

    // в зависимости от раздела получаем объявления всех или только пользователя
    if (isShowMyAnnouncement) {
      //announcementList = await HelpsApi.getUserAnnouncements();
      announcementList =
          sortAnnouncements(AnnouncementData.announcementBufferData);
    } else {
      //announcementList = await HelpsApi.getActiveAnnouncements(city!);
      announcementList =
          sortAnnouncements(AnnouncementData.announcementBufferData);
    }

    emit(AnnouncementViewScreenLoaded(announcementList: announcementList));
  }

  List<AnnouncementResponseModel> sortAnnouncements(
      List<AnnouncementResponseModel> announcements) {
    // Отфильтруем и отсортируем объявления с shouldHighlight: true
    List<AnnouncementResponseModel> highlightedAnnouncements = announcements
        .where((announcement) => announcement.shouldHighlight)
        .toList();
    highlightedAnnouncements
        .sort((a, b) => b.creationDate.compareTo(a.creationDate));

    // Отфильтруем остальные объявления и отсортируем их по времени размещения
    List<AnnouncementResponseModel> nonHighlightedAnnouncements = announcements
        .where((announcement) => !announcement.shouldHighlight)
        .toList();
    nonHighlightedAnnouncements
        .sort((a, b) => b.creationDate.compareTo(a.creationDate));

    // Объединим отфильтрованные и отсортированные списки
    List<AnnouncementResponseModel> sortedAnnouncements = [];
    sortedAnnouncements.addAll(highlightedAnnouncements);
    sortedAnnouncements.addAll(nonHighlightedAnnouncements);

    return sortedAnnouncements;
  }
}
