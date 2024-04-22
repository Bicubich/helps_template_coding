part of 'privacy_policy_screen_cubit.dart';

abstract class PrivacyPolicyScreenState extends Equatable {
  const PrivacyPolicyScreenState();

  @override
  List<Object> get props => [];
}

class PrivacyPolicyScreenInitial extends PrivacyPolicyScreenState {
  final List<PrivacyPolicyModel> privacyPolicyList;

  const PrivacyPolicyScreenInitial({required this.privacyPolicyList});
}

class PrivacyPolicyScreenUpdating extends PrivacyPolicyScreenState {}
