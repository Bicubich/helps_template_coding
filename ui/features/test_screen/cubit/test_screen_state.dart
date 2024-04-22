part of 'test_screen_cubit.dart';

abstract class TestScreenState extends Equatable {
  const TestScreenState();

  @override
  List<Object> get props => [];
}

class TestScreenInitial extends TestScreenState {
  final List<String> stringList;

  const TestScreenInitial({
    required this.stringList,
  });

  TestScreenInitial copyWith({
    List<String>? stringList,
  }) {
    return TestScreenInitial(
      stringList: stringList ?? this.stringList,
    );
  }

  @override
  List<Object> get props => [stringList];
}
