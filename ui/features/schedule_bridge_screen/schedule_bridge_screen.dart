import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/bridge_schedule_model.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_fetch_data_error_widget.dart';
import 'package:helps_flutter/ui/components/helps_loading_indicator.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/schedule_bridge_screen/components/schedule_bridge_list.dart';
import 'package:helps_flutter/ui/features/schedule_bridge_screen/cubit/schedule_bridge_screen_cubit.dart';

class ScheduleBridgeScreen extends StatelessWidget {
  ScheduleBridgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBridgeScreenCubit(),
      child: BlocBuilder<ScheduleBridgeScreenCubit, ScheduleBridgeScreenState>(
        builder: (context, state) {
          return HelpsTemplate(
            actions: [
              Padding(
                padding: UiConstants.appPaddingHorizontal,
                child: GestureDetector(
                  onTap: () => context
                      .read<ScheduleBridgeScreenCubit>()
                      .getScheduleData(),
                  child: const Icon(
                    Icons.refresh,
                  ),
                ),
              ),
            ],
            body: state is ScheduleBridgeScreenLoaded
                ? (state.bridgeScheduleList.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          BridgeScheduleModel bridgeScheduleItem =
                              state.bridgeScheduleList[index];
                          return ScheduleBridgeList(
                            expansionTileController: ExpansionTileController(),
                            bridgeItem: bridgeScheduleItem,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                        itemCount: state.bridgeScheduleList.length,
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
                : state is ScheduleBridgeScreenError
                    ? HelpsFetchDataErrorWidget()
                    : HelpsLoadingIndicator(),
          );
        },
      ),
    );
  }
}
