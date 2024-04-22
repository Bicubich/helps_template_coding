import 'package:flutter/material.dart';
import 'package:helps_flutter/ui/components/custom_app_bar.dart';
import 'package:helps_flutter/ui/components/helps_background_shading/background_shading.dart';

class HelpsTemplate extends StatelessWidget {
  const HelpsTemplate(
      {super.key, required this.body, this.isNeedAppBar = true, this.actions});

  final Widget body;
  final bool isNeedAppBar;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: isNeedAppBar
            ? CustomAppBar(
                actions: actions,
              )
            : null,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            body,
            HelpsBackgroundShading(),
          ],
        ),
      ),
    );
  }
}
