import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/ui/with_foreground_task.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/ui/components/helps_background_shading/cubit/background_shading_cubit.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_create_screen.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_screen.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_select_city/announcement_select_city_screen.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/announcement_view_screen.dart';
import 'package:helps_flutter/ui/features/friends_screen/friends_screen.dart';
import 'package:helps_flutter/ui/features/login_screen/login_screen.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/maps_screen.dart';
import 'package:helps_flutter/ui/features/menu_screen/menu_screen.dart';
import 'package:helps_flutter/ui/features/permissions_screen/permissions_screen.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:helps_flutter/ui/features/profile_screen/profile_screen.dart';
import 'package:helps_flutter/ui/features/registration_car_screen/registration_car_screen.dart';
import 'package:helps_flutter/ui/features/registration_user_screen/registration_user_screen.dart';
import 'package:helps_flutter/ui/features/schedule_airplane_screen/schedule_airplane_screen.dart';
import 'package:helps_flutter/ui/features/schedule_bridge_screen/schedule_bridge_screen.dart';
import 'package:helps_flutter/ui/features/settings_screen/settings_screen.dart';
import 'package:helps_flutter/ui/features/splash_screen/splash_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: ScreenUtilInit(
        designSize: const Size(360, 720 + kToolbarHeight),
        builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => NotificationCubit(),
            ),
            BlocProvider(
              create: (context) => BackgroundShadingCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Helps',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(background: UiConstants.kColorBackground),
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            //home: PrivacyPolicyScreen(),
            routes: {
              Routes.splashScreen: (context) => SplashScreen(),
              Routes.permissionsScreen: (context) => PermissionsScreen(),
              Routes.privacyPolicyScreen: (context) => PrivacyPolicyScreen(),
              Routes.loginScreen: (context) => LoginScreen(),
              Routes.userRegistrationScreen: (context) =>
                  RegistrationUserScreen(),
              Routes.carRegistrationScreen: (context) =>
                  RegistrationCarScreen(),
              Routes.mapsScreen: (context) => MapsScreen(),
              Routes.menuScreen: (context) => MenuScreen(),
              Routes.friendsScreen: (context) => FriendsScreen(),
              Routes.scheduleAirplaneScreen: (context) =>
                  ScheduleAirplaneScreen(),
              Routes.scheduleBridgeScreen: (context) => ScheduleBridgeScreen(),
              Routes.profileScreen: (context) => ProfileScreen(),
              Routes.settingsScreen: (context) => SettingsScreen(),
              Routes.announcementScreen: (context) => AnnouncementScreen(),
              Routes.announcementCreateScreen: (context) =>
                  AnnouncementCreateScreen(),
              Routes.announcementViewScreen: (context) =>
                  AnnouncementViewScreen(),
              Routes.announcementSelectCityScreen: (context) =>
                  AnnouncementSelectCityScreen(),
            },
            initialRoute: Routes.splashScreen,
          ),
        ),
      ),
    );
  }
}
