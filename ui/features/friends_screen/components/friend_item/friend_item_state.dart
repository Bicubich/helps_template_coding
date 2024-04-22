part of 'friend_item_cubit.dart';

abstract class FriendItemState extends Equatable {
  const FriendItemState();

  @override
  List<Object> get props => [];
}

class FriendItemInitial extends FriendItemState {
  final bool isExpanded;
  const FriendItemInitial({required this.isExpanded});

  FriendItemInitial copyWith({
    bool? isExpanded,
  }) {
    return FriendItemInitial(
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object> get props => [isExpanded];
}
