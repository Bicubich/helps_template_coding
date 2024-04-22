import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_text_field_with_text/helps_text_field_with_text.dart';
import 'package:helps_flutter/ui/components/helps_selector/cubit/selector_cubit.dart';
import 'package:helps_flutter/ui/components/helps_selector/selector/selector.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/friends_screen/components/friends_list.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:ru_phone_formatter/ru_phone_formatter.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: '+7 ');
  final ruFormatter = RuPhoneInputFormatter(initialText: '+7 ');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<ExpansionTileController> expansionControllers = List.generate(
    4,
    (index) => ExpansionTileController(),
  );

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectorCubit(),
      child: HelpsTemplate(
        actions: [
          Padding(
            padding: UiConstants.appPaddingHorizontal,
            child: GestureDetector(
              onTap: () {}, // TODO: Обновить список
              child: const Icon(
                Icons.refresh,
              ),
            ),
          ),
        ],
        body: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: UiConstants.appPaddingHorizontal +
                    getMarginOrPadding(left: 10, right: 10),
                child: HelpsTextFieldWithText(
                  controller: _phoneController,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 28),
                    child: SvgPicture.asset(
                      Paths.friendsMenuIconSearch,
                      color: UiConstants.kColorBase01,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => _sendInvite(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: UiConstants.kColorBase01.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: getMarginOrPadding(all: 8),
                      child: SvgPicture.asset(
                        Paths.friendsMenuIconSend,
                        color: UiConstants.kColorPrimary,
                      ),
                    ),
                  ),
                  inputFormatters: [ruFormatter],
                  hintText: LocaleKeys.kTextPhone.tr(),
                  validator: (value) => Utils().validatePhone(value),
                  regExp: Utils.phoneRegexp,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  contentPadding: getMarginOrPadding(all: 0),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: UiConstants.appPaddingHorizontal,
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Selector(
                    titlesList: [
                      LocaleKeys.kTextFriends.tr(),
                      LocaleKeys.kTextIncoming.tr(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: BlocBuilder<SelectorCubit, SelectorState>(
                  builder: (context, selectorState) {
                    if (selectorState.selectedIndex == 0) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          FriendsList(
                            expansionTileController: expansionControllers[0],
                            friendListType: FriendListType.friends,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          FriendsList(
                            expansionTileController: expansionControllers[1],
                            friendListType: FriendListType.blackList,
                          ),
                        ],
                      );
                    } else {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          FriendsList(
                            expansionTileController: expansionControllers[2],
                            friendListType: FriendListType.newFriends,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          FriendsList(
                            expansionTileController: expansionControllers[3],
                            friendListType: FriendListType.rejected,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendInvite() {
    if (formKey.currentState!.validate()) {
      // опускаем клавиатуру
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<NotificationCubit>().showInfoNotification(
            context,
            LocaleKeys.kTextFriendRequestSent.tr(),
          );
      _phoneController.clear();
    }
  }
}
