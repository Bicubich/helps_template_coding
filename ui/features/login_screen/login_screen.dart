import 'package:blur/blur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:flutter_login_yandex/flutter_login_yandex.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_background_shading/cubit/background_shading_cubit.dart';
import 'package:helps_flutter/ui/components/helps_support_button.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/login_screen/components/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      isNeedAppBar: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Text(
              LocaleKeys.kTextAppTitle.tr(),
              style: UiConstants.kTextStyleText1
                  .copyWith(color: UiConstants.kColorBase02),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding:
                  getMarginOrPadding(top: 32, bottom: 10, left: 33, right: 33),
              margin: UiConstants.appPaddingHorizontal +
                  UiConstants.appPaddingVertical,
              height: 400.h,
              decoration: BoxDecoration(
                color: UiConstants.kColorBase04.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    Paths.mapPlaceholderPath,
                    fit: BoxFit.fill,
                  ).blurred(
                    colorOpacity: 0.0,
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(20)),
                    blur: 2,
                  ),
                  Column(
                    children: [
                      Text(
                        LocaleKeys.kTextLogIn.tr(),
                        style: UiConstants.kTextStyleText2
                            .copyWith(color: UiConstants.kColorPrimary),
                      ),
                      const Spacer(),
                      //SignInButton(
                      //  onTap: () => googleSighIn(context),
                      //  iconPath: Paths.googleIconPath,
                      //  text: LocaleKeys.kSignInWithGoogle.tr(),
                      //),
                      //SizedBox(
                      //  height: 10.h,
                      //),
                      SignInButton(
                        onTap: () => yandexSignIn(context),
                        iconPath: Paths.yandexIconPath,
                        text: LocaleKeys.kSignInWithYandex.tr(),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SignInButton(
                        onTap: () => vkSignIn(context),
                        iconPath: Paths.vkIconPath,
                        text: LocaleKeys.kSignInWithVk.tr(),
                      ),
                      const Spacer(),
                      const HelpsSupportButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future googleSighIn(BuildContext context) async {
    //context.read<BackgroundShadingCubit>().activate();
    //try {
    //  GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
    //  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
    //  AuthCredential credential = GoogleAuthProvider.credential(
    //    accessToken: googleAuth?.accessToken,
    //    idToken: googleAuth?.idToken,
    //  );
//
    //  UserCredential userCredential =
    //      await FirebaseAuth.instance.signInWithCredential(credential);
    //  String? googleToken =
    //      (await userCredential.user?.getIdTokenResult())?.token;
    //  if (googleToken != null) {
    //    String? serverToken = await HelpsApi.loginGoogle(googleToken);
    //    if (serverToken != null) {
    //      SharedPreferencesHelper.setString(
    //          SharedPreferencesKeys.serverToken, serverToken);
    //      Utils.pushToInitialScreen(context);
    //    }
    //  }
    //} catch (e) {
    //  context.read<NotificationCubit>().showErrorNotification(
    //        context,
    //        LocaleKeys.kTextAuthorizationError.tr(),
    //      );
    //}

    //String serverToken =
    //    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjFmZDJmN2IyZGI2NDczZDNhMzFiYTQiLCJyb2xlcyI6WyJVU0VSIl0sImlhdCI6MTcxMzM2MTY1NX0.GyYK5m_UagdTlUsIRMSfQDwD5X_GOyWTVlrMnuYCSoQ";
//
    //SharedPreferencesHelper.setString(
    //    SharedPreferencesKeys.serverToken, serverToken);
    //Utils.pushToInitialScreen(context);
//
    //context.read<BackgroundShadingCubit>().hide();
  }

  Future yandexSignIn(BuildContext context) async {
    context.read<BackgroundShadingCubit>().activate();
    try {
      final flutterLoginYandexPlugin = FlutterLoginYandex();
      final response = await flutterLoginYandexPlugin.signIn();
      final String? yandexToken = response?['token'] as String?;
      if (yandexToken != null) {
        String? serverToken = await HelpsApi.loginYandex(yandexToken);
        if (serverToken != null) {
          SharedPreferencesHelper.setString(
              SharedPreferencesKeys.serverToken, serverToken);
          Utils.pushToInitialScreen(context);
        }
      }
    } catch (e) {
      context.read<NotificationCubit>().showErrorNotification(
            context,
            LocaleKeys.kTextAuthorizationError.tr(),
          );
    }
    context.read<BackgroundShadingCubit>().hide();
  }

  Future vkSignIn(BuildContext context) async {
    context.read<BackgroundShadingCubit>().activate();
    try {
      final vk = VKLogin();
      await vk.initSdk();
      final res = await vk.logIn(scope: [
        VKScope.email,
        VKScope.friends,
      ]);

      if (res.isValue) {
        final VKLoginResult result = res.asValue!.value;

        if (result.isCanceled) {
          context.read<NotificationCubit>().showErrorNotification(
                context,
                LocaleKeys.kTextAuthorizationError.tr(),
              );
        } else {
          final VKAccessToken? vkToken = result.accessToken;
          // Send access token to server for validation and auth
          if (vkToken != null) {
            String? serverToken = await HelpsApi.loginVk(vkToken.token);
            if (serverToken != null) {
              SharedPreferencesHelper.setString(
                  SharedPreferencesKeys.serverToken, serverToken);
              Utils.pushToInitialScreen(context);
            }
          }
        }
      } else {
        // Log in failed
        final errorRes = res.asError!;
        print('Error while log in: ${errorRes.error}');
        context.read<NotificationCubit>().showErrorNotification(
              context,
              LocaleKeys.kTextAuthorizationError.tr(),
            );
      }
    } catch (e) {
      context.read<NotificationCubit>().showErrorNotification(
            context,
            LocaleKeys.kTextAuthorizationError.tr(),
          );
    }
    context.read<BackgroundShadingCubit>().hide();
  }
}
