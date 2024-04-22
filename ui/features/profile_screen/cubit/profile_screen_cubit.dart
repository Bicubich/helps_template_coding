import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/api/model/user_model.dart';
import 'package:helps_flutter/constants/utils.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit() : super(ProfileScreenLoading()) {
    _init();
  }

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController secondNameController = TextEditingController();

  final TextEditingController phoneController =
      TextEditingController(text: '+7 ');

  final TextEditingController numberLicenseController = TextEditingController();

  final TextEditingController brandCarController = TextEditingController();

  final TextEditingController modelCarController = TextEditingController();

  final TextEditingController carRegNumberController = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  Future _init() async {
    UserModel? user = await HelpsApi.getUser();
    if (user == null) {
      emit(ProfileScreenError());
      return;
    }
    await initTextFieldControllers(user);
    emit(ProfileScreenLoaded(user: user));
  }

  Future initTextFieldControllers(UserModel user) async {
    firstNameController.text = user.name ?? '';
    secondNameController.text = user.surname ?? '';
    phoneController.text =
        Utils.formatPhoneNumberFromServerResponse(user.phone ?? '');
    numberLicenseController.text = user.driverLicenseNumber ?? '';
    brandCarController.text = user.carBrand ?? '';
    modelCarController.text = user.carModel ?? '';
    carRegNumberController.text = user.licensePlate ?? '';
    colorController.text = user.carColor ?? '';
  }
}
