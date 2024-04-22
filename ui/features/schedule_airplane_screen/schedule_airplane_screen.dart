import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/airplane_schedule_model.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_fetch_data_error_widget.dart';
import 'package:helps_flutter/ui/components/helps_loading_indicator.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/schedule_airplane_screen/components/schedule_airplane_list.dart';
import 'package:helps_flutter/ui/features/schedule_airplane_screen/controller/schedule_airplane_controller.dart';
import 'package:helps_flutter/ui/features/schedule_airplane_screen/cubit/schedule_airplane_screen_cubit.dart';

class ScheduleAirplaneScreen extends StatelessWidget {
  ScheduleAirplaneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String region = AirplaneScheduleController.getArgumentRegion(context);

    return BlocProvider(
      create: (context) => ScheduleAirplaneScreenCubit(region),
      child:
          BlocBuilder<ScheduleAirplaneScreenCubit, ScheduleAirplaneScreenState>(
        builder: (context, state) {
          return HelpsTemplate(
            actions: [
              Padding(
                padding: UiConstants.appPaddingHorizontal,
                child: GestureDetector(
                  onTap: () => context
                      .read<ScheduleAirplaneScreenCubit>()
                      .getScheduleData(),
                  child: const Icon(
                    Icons.refresh,
                  ),
                ),
              ),
            ],
            body: state is ScheduleAirplaneScreenLoaded
                ? (state.airplaneScheduleList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int hour =
                              state.airplaneScheduleList.first.arrivalDate.hour;
                          int day =
                              state.airplaneScheduleList.first.arrivalDate.day;
                          int month = state
                              .airplaneScheduleList.first.arrivalDate.month;
                          int year =
                              state.airplaneScheduleList.first.arrivalDate.year;

                          List<AirplaneScheduleModel> airplaneScheduleList = [];

                          for (AirplaneScheduleModel element
                              in state.airplaneScheduleList) {
                            DateTime bDate = DateTime(year, month, day, hour)
                                .add(Duration(hours: index));
                            DateTime aDate = DateTime(year, month, day, hour)
                                .add(Duration(hours: 1 + index));
                            bool isBefore = element.arrivalDate.isAfter(bDate);
                            bool isAfter = element.arrivalDate.isBefore(aDate);
                            // Проверяем, что arrivalDate находится после начала часа и до конца этого же часа
                            if (isBefore && isAfter) {
                              airplaneScheduleList.add(element);
                            }
                          }

                          return airplaneScheduleList.isNotEmpty
                              ? Column(
                                  children: [
                                    ScheduleAirplaneList(
                                      airplaneScheduleList:
                                          airplaneScheduleList,
                                      expansionTileController:
                                          ExpansionTileController(),
                                      title:
                                          '${DateTime(year, month, day, airplaneScheduleList.first.arrivalDate.hour).hour}:00 - ${DateTime(year, month, day, airplaneScheduleList.first.arrivalDate.hour).add(Duration(hours: 1)).hour}:00 (${DateTime(year, month, day, airplaneScheduleList.first.arrivalDate.hour).add(Duration(hours: 1)).day} ${AirplaneScheduleController.getMonthNameInGenitiveCase(DateTime(year, month, day, airplaneScheduleList.first.arrivalDate.hour).add(Duration(hours: 1)))})',
                                    ),
                                    if (index != -1)
                                      SizedBox(
                                        height: 20.h,
                                      )
                                  ],
                                )
                              : Container();
                        },
                        itemCount: AirplaneScheduleController.countIntervals(
                            state.airplaneScheduleList.first.arrivalDate,
                            state.airplaneScheduleList.last.arrivalDate),
                      )
                    : Center(
                        child: Text(
                          LocaleKeys.kTextDataIsEmpty.tr(),
                          textAlign: TextAlign.center,
                          style: UiConstants.kTextStyleText5.copyWith(
                            color: UiConstants.kColorBase01,
                          ),
                        ),
                      ))
                : state is ScheduleAirplaneScreenError
                    ? HelpsFetchDataErrorWidget()
                    : HelpsLoadingIndicator(),
          );
        },
      ),
    );
  }
}
