import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'friend_item_state.dart';

class FriendItemCubit extends Cubit<FriendItemState> {
  FriendItemCubit() : super(const FriendItemInitial(isExpanded: false));

  Future expandItem() async {
    emit(const FriendItemInitial(isExpanded: true));
  }

  Future collapseItem() async {
    emit(const FriendItemInitial(isExpanded: false));
  }
}
