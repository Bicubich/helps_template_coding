import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/components/helps_selector/cubit/selector_cubit.dart';

class SelectorChip extends StatelessWidget {
  final String text;
  final bool selected;
  final int index;

  const SelectorChip(
      {required this.text,
      required this.selected,
      required this.index,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<SelectorCubit>().onSelectorItemTap(index),
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: index != 0 ? 2 : 0),
          decoration: BoxDecoration(
            color: selected ? UiConstants.kColorBase01.withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            text,
            style: UiConstants.kTextStyleText3
                .copyWith(color: UiConstants.kColorBase01),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
