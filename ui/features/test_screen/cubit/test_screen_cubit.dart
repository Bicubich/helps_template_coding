import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'test_screen_state.dart';

class TestScreenCubit extends Cubit<TestScreenState> {
  TestScreenCubit() : super(TestScreenInitial(stringList: []));

  addString() {
    TestScreenInitial state = this.state as TestScreenInitial;
    List<String> stringList = state.stringList;
    emit(
      TestScreenInitial(stringList: state.stringList),
    );
    stringList.add('Привет');
    emit(
      state.copyWith(stringList: stringList),
    );
  }
}
