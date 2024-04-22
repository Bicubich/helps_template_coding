import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/components/helps_background_shading/cubit/background_shading_cubit.dart';
import 'package:helps_flutter/ui/components/helps_loading_indicator.dart';

class HelpsBackgroundShading extends StatefulWidget {
  const HelpsBackgroundShading({
    Key? key,
  }) : super(key: key);

  @override
  State<HelpsBackgroundShading> createState() => _HelpsBackgroundShadingState();
}

class _HelpsBackgroundShadingState extends State<HelpsBackgroundShading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 250),
    );

    colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: UiConstants.kColorBase09.withOpacity(0.3),
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BackgroundShadingCubit, BackgroundShadingState>(
      listener: (context, state) =>
          onBackgroundShadingStateChange(context, state),
      builder: (context, state) {
        if (state is BackgroundShadingInactive) {
          return Container();
        } else {
          return GestureDetector(
            onTap: () => {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: UiConstants.kColorBackground.withOpacity(0.6),
              child: HelpsLoadingIndicator(),
            ),
          );
        }
      },
    );
  }

  void onBackgroundShadingStateChange(
      BuildContext context, BackgroundShadingState state) {
    if (state is BackgroundShadingActive) {
      controller.forward();
    }
    if (state is BackgroundShadingInactive) {
      controller
          .reverse()
          .then((value) => context.read<BackgroundShadingCubit>().hide());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
