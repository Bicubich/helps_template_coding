import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/announcement_response_model.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_border_chip.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/features/announcement_screen/controller/announcement_controller.dart';

class MyAnnouncementItem extends StatefulWidget {
  MyAnnouncementItem({required this.announcement});
  final AnnouncementResponseModel announcement;

  @override
  State<MyAnnouncementItem> createState() => _MyAnnouncementItemState();
}

class _MyAnnouncementItemState extends State<MyAnnouncementItem> {
  bool isVisibleDescription = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getMarginOrPadding(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                padding: getMarginOrPadding(
                    left: 10, right: 10, bottom: 40, top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: UiConstants.kColorBase04.withOpacity(0.8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${LocaleKeys.kTextRent.tr()} ${widget.announcement.carBrand} - ${widget.announcement.carModel} (${widget.announcement.manufactoryYear})',
                      style: UiConstants.kTextStyleText4
                          .copyWith(color: UiConstants.kColorBase01),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '${widget.announcement.carClass}',
                      style: UiConstants.kTextStyleText9
                          .copyWith(color: UiConstants.kColorBase07),
                    ),
                    SizedBox(height: 15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.announcement.rentPrice} ${LocaleKeys.kTextPricePerDay.tr()}',
                          style: UiConstants.kTextStyleText4
                              .copyWith(color: UiConstants.kColorBase01),
                        ),
                        Text(
                          '${LocaleKeys.kTextSecurityDeposit.tr()}: ${widget.announcement.pledge}',
                          style: UiConstants.kTextStyleText9.copyWith(
                              color: UiConstants.kColorBase07,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () => setState(() {
                        isVisibleDescription = !isVisibleDescription;
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.kTextMoreDetails.tr(),
                            style: UiConstants.kTextStyleText12
                                .copyWith(color: UiConstants.kColorBase07),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            isVisibleDescription
                                ? Icons.keyboard_double_arrow_up
                                : Icons.keyboard_double_arrow_down,
                            color: UiConstants.kColorBase07,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Visibility(
                      visible: isVisibleDescription,
                      child: Text(
                        widget.announcement.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: HelpsBorderChip(
                  chipColor: widget.announcement.isActive
                      ? UiConstants.kColorSuccess
                      : UiConstants.kColorError,
                  text: widget.announcement.isActive
                      ? LocaleKeys.kTextActiveAd.tr()
                      : LocaleKeys.kTextHiddenAd.tr(),
                  textColor: UiConstants.kColorBase01,
                  isMainDiagonal: false,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: HelpsBorderChip(
                  chipColor: UiConstants.kColorPrimary,
                  text: widget.announcement.city,
                  textColor: UiConstants.kColorBase01,
                ),
              ),
              if (widget.announcement.expirationDate
                      .difference(DateTime.now())
                      .inDays <
                  3)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: HelpsBorderChip(
                    chipColor: Colors.transparent,
                    text:
                        '${LocaleKeys.kTextExpires.tr()} ${DateFormat('dd/MM/yyyy').format(widget.announcement.expirationDate)}',
                    textColor: UiConstants.kColorError,
                    isMainDiagonal: false,
                  ),
                ),
              if (widget.announcement.shouldHighlight)
                Positioned(
                  top: 0,
                  right: 0,
                  child: HelpsBorderChip(
                    chipColor: Colors.transparent,
                    text: LocaleKeys.kTextVIP.tr(),
                    textColor: UiConstants.kColorPrimary,
                    isMainDiagonal: false,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: getMarginOrPadding(left: 15, right: 15),
            child: Column(
              children: [
                HelpsButton(
                  onTap: () => AnnouncementController.changeAnnouncementVisible(
                      widget.announcement),
                  text: LocaleKeys.kTextChangeVisibility.tr(),
                  textColor: UiConstants.kColorBase01,
                  buttonColor: UiConstants.kColorBase10,
                  textStyle: UiConstants.kTextStyleText4,
                  isShadow: false,
                ),
                SizedBox(
                  height: 10.h,
                ),
                HelpsButton(
                  onTap: () => AnnouncementController.deleteAnnouncement(
                      context, widget.announcement.id),
                  text: LocaleKeys.kTextDelete.tr(),
                  textColor: UiConstants.kColorBase01,
                  buttonColor: UiConstants.kColorBase10,
                  textStyle: UiConstants.kTextStyleText4,
                  isShadow: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
