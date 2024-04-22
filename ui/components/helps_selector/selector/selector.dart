import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/components/helps_selector/cubit/selector_cubit.dart';
import 'package:helps_flutter/ui/components/helps_selector/selector/selector_chip.dart';

class Selector extends StatefulWidget {
  const Selector({super.key, required this.titlesList});

  final List<String> titlesList;

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UiConstants.kColorBase01.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: getMarginOrPadding(all: 2),
      child: BlocBuilder<SelectorCubit, SelectorState>(
        builder: (context, state) {
          return Row(
            children: List.generate(
              widget.titlesList.length,
              (index) => Expanded(
                child: SelectorChip(
                  text: widget.titlesList[index],
                  selected: state.selectedIndex == index,
                  index: index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
