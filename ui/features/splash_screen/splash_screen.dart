import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/ui/features/splash_screen/cubit/splash_screen_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenCubit(context),
      child: BlocBuilder<SplashScreenCubit, void>(
        builder: (context, state) {
          return Center(
            child: Image.asset(
              Paths.logoTextPath,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
