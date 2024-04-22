import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selector_state.dart';

class SelectorCubit extends Cubit<SelectorState> {
  SelectorCubit() : super(const SelectorState(selectedIndex: 0));

  void onSelectorItemTap(int index) {
    emit(SelectorState(selectedIndex: index));
  }
}
