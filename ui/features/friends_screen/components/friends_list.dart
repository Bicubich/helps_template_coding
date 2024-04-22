import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/ui/features/friends_screen/components/friend_item/friend_item_cubit.dart';
import 'package:helps_flutter/ui/features/friends_screen/components/friend_item/friends_item.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({
    super.key,
    required this.friendListType,
    required this.expansionTileController,
  });

  final ExpansionTileController expansionTileController;
  final FriendListType friendListType;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: expansionTileController,
      shape: const Border(bottom: BorderSide(width: 1)),
      tilePadding: getMarginOrPadding(right: 15),
      childrenPadding: UiConstants.appPaddingHorizontal,
      iconColor: UiConstants.kColorBase01,
      collapsedIconColor: UiConstants.kColorBase01,
      title: ListTile(
        title: Text(
          '${Utils.getFriendsNameList(friendListType)} (50)',
          style: UiConstants.kTextStyleText5
              .copyWith(color: UiConstants.kColorBase01),
        ),
      ),
      children: List.generate(
        5,
        (index) => Column(
          children: [
            BlocProvider(
              create: (context) => FriendItemCubit(),
              child: FriendsItem(
                friendListType: friendListType,
              ),
            ),
            if (index != -1)
              SizedBox(
                height: 20.h,
              )
          ],
        ),
      ),
    );
  }
}
