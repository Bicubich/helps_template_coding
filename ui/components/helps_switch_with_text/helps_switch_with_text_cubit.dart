import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'helps_switch_with_text_state.dart';

class HelpsSwitchWithTextCubit extends Cubit<bool> {
  final isSwitchEnabled;
  HelpsSwitchWithTextCubit(this.isSwitchEnabled) : super(isSwitchEnabled);

  changeSwitch(bool isSwitchEnabled) {
    emit(!state);
  }
}
