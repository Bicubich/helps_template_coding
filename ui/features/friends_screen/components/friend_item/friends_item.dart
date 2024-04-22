import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/friends_screen/components/friend_item/friend_item_cubit.dart';
import 'package:helps_flutter/ui/features/friends_screen/components/friends_item_swipe_card.dart';

class FriendsItem extends StatefulWidget {
  const FriendsItem({super.key, required this.friendListType});

  final FriendListType friendListType;

  @override
  State<FriendsItem> createState() => _FriendsItemState();
}

class _FriendsItemState extends State<FriendsItem> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendItemCubit, FriendItemState>(
      builder: (context, state) {
        return SizedBox(
          height: 100.h,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 30.w,
                padding:
                    getMarginOrPadding(left: 12, right: 6, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: UiConstants.kColorBase10.withOpacity(0.2),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(24.r),
                    right: Radius.circular(12.r),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: getMarginOrPadding(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            height: 80.w,
                            Paths.friendsMenuImage1,
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Иван Иванов',
                                style: UiConstants.kTextStyleText11
                                    .copyWith(color: UiConstants.kColorBase01),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                '+7 999 999 99 11',
                                style: UiConstants.kTextStyleText11
                                    .copyWith(color: UiConstants.kColorPrimary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 98.h,
                      child: IconButton(
                        onPressed: () => _scrollController.animateTo(
                          state.isExpanded
                              ? 0.0
                              : _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        ),
                        icon: Icon(
                          (state as FriendItemInitial).isExpanded
                              ? Icons.arrow_back_ios_new_outlined
                              : Icons.arrow_forward_ios_outlined,
                          color: UiConstants.kColorBase01,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            UiConstants.kColorBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              FriendsItemSwipeCard(
                iconPath:
                    Utils.getFriendsSwipeCard(widget.friendListType, true),
                text: LocaleKeys.kTextAdd.tr(),
                onPressed: () {},
              ),
              SizedBox(
                width: 15.w,
              ),
              FriendsItemSwipeCard(
                iconPath:
                    Utils.getFriendsSwipeCard(widget.friendListType, false),
                text: LocaleKeys.kTextReject.tr(),
                onPressed: () => foo(),
                isLast: true,
              ),
            ],
          ),
        );
      },
    );
  }

  foo() {
    print(1);
  }

  // Функция, вызываемая при изменении прокрутки
  void _scrollListener() async {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent) {
      await context.read<FriendItemCubit>().collapseItem();
    } else {
      // Достигнуто начало списка
      await context.read<FriendItemCubit>().expandItem();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
