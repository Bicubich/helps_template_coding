import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/model/sos_stream_model.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/info_user_tap_marker_view/info_user_tap_marker_view_item.dart';

class InfoUserTapMarkerView extends StatelessWidget {
  const InfoUserTapMarkerView({super.key, required this.sosStreamModel});

  final SosStreamModel sosStreamModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoUserTapMarkerViewItem(
            suffixText: '${LocaleKeys.kTextFirstName.tr()}: ',
            text: sosStreamModel.user.name!),
        SizedBox(
          height: 5.h,
        ),
        InfoUserTapMarkerViewItem(
            suffixText: '${LocaleKeys.kTextSecondName.tr()}: ',
            text: sosStreamModel.user.surname!),
        SizedBox(
          height: 5.h,
        ),
        InfoUserTapMarkerViewItem(
            suffixText: '${LocaleKeys.kTextCarBrand.tr()}: ',
            text: sosStreamModel.user.carBrand!),
        SizedBox(
          height: 5.h,
        ),
        InfoUserTapMarkerViewItem(
            suffixText: '${LocaleKeys.kTextCarModel.tr()}: ',
            text: sosStreamModel.user.carModel!),
        SizedBox(
          height: 5.h,
        ),
        InfoUserTapMarkerViewItem(
            suffixText: '${LocaleKeys.kTextCarRegistrationNumber.tr()}: ',
            text: sosStreamModel.user.licensePlate!),
        SizedBox(
          height: 5.h,
        ),
        InfoUserTapMarkerViewItem(
            suffixText: '${LocaleKeys.kTextColor.tr()}: ',
            text: sosStreamModel.user.carColor!),
        SizedBox(
          height: 5.h,
        ),
        InfoUserTapMarkerViewItem(
          suffixText: '${LocaleKeys.kTextPhone.tr()}: ',
          text: sosStreamModel.user.phone!,
          isCopy: true,
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
