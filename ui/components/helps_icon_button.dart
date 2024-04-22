import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpsIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? iconPath;
  final IconData? icon;
  final double width;
  final double height;
  final Color? iconColor;

  const HelpsIconButton(
      {required this.onPressed,
      this.iconPath,
      this.width = 24,
      this.height = 24,
      this.iconColor,
      super.key,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsets>(
              (states) => const EdgeInsets.all(0)),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.transparent),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
        ),
        onPressed: () => onPressed(),
        child: iconPath != null
            ? SvgPicture.asset(
                iconPath!,
                semanticsLabel: 'Icon',
                width: width,
                height: height,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              )
            : Icon(
                icon,
                size: width,
                color: iconColor,
              ),
      ),
    );
  }
}
