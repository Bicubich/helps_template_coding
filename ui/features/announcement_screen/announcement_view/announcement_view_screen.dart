import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/components/helps_loading_indicator.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/components/all_announcement_item.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/components/my_announcement_item.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/cubit/announcement_view_screen_cubit.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';

class AnnouncementViewScreen extends StatelessWidget {
  const AnnouncementViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем аргументы из текущего маршрута
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    bool isShowMyAnnouncement = args!['myAnnouncement'];
    String? city = args['city'];

    return BlocProvider(
      create: (context) => AnnouncementViewScreenCubit(
          isShowMyAnnouncement: isShowMyAnnouncement, city: city),
      child:
          BlocBuilder<AnnouncementViewScreenCubit, AnnouncementViewScreenState>(
        builder: (context, state) {
          return HelpsTemplate(
            actions: [
              Padding(
                padding: UiConstants.appPaddingHorizontal,
                child: GestureDetector(
                  onTap: () => context
                      .read<AnnouncementViewScreenCubit>()
                      .getAnnouncementData(),
                  child: const Icon(
                    Icons.refresh,
                  ),
                ),
              ),
            ],
            body: state is AnnouncementViewScreenLoaded
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    padding: getMarginOrPadding(top: 10),
                    children: List.generate(
                      state.announcementList.length,
                      (index) => Column(
                        children: [
                          isShowMyAnnouncement
                              ? MyAnnouncementItem(
                                  announcement: state.announcementList[index],
                                )
                              : AllAnnouncementItem(
                                  announcement: state.announcementList[index],
                                ),
                          if (index != -1)
                            SizedBox(
                              height: 30.h,
                            )
                        ],
                      ),
                    ),
                  )
                : HelpsLoadingIndicator(),
          );
        },
      ),
    );
  }
}
