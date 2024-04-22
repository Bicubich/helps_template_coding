import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSlidableActionWidget extends StatelessWidget {
  final int flex;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool autoClose;
  final SlidableActionCallback? onPressed;
  final IconData? icon;
  final String? imagePath;
  final double spacing;
  final String? label;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final TextStyle? labelStyle;

  const CustomSlidableActionWidget({
    Key? key,
    this.flex = 1,
    this.backgroundColor = Colors.white,
    this.foregroundColor,
    this.autoClose = true,
    this.onPressed,
    this.icon,
    this.imagePath,
    this.spacing = 4,
    this.label,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (icon != null) {
      children.add(
        Icon(icon),
      );
    } else if (imagePath != null) {
      children.add(
        SvgPicture.asset(imagePath!, height: 24.w),
      );
    }

    if (label != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(height: spacing));
      }

      children.add(
        Text(
          label!,
          overflow: TextOverflow.ellipsis,
          style: labelStyle,
        ),
      );
    }

    final child = children.length == 1
        ? children.first
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...children.map(
                (child) => Flexible(
                  child: child,
                ),
              ),
            ],
          );

    return CustomSlidableAction(
      borderRadius: borderRadius,
      padding: padding,
      onPressed: onPressed,
      autoClose: autoClose,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flex: flex,
      child: child,
    );
  }
}
