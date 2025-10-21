part of 'terms_conditions_cubit.dart';

sealed class TermsConditionsState extends Equatable {
  const TermsConditionsState();

  @override
  List<Object> get props => [];
}

final class TermsConditionsInitial extends TermsConditionsState {}

final class TermsConditionsLoading extends TermsConditionsState {}

final class TermsCondionsEmpty extends TermsConditionsState{}

final class TermsConditionsError extends TermsConditionsState {
  final String message;
  TermsConditionsError({required this.message});
}

final class TermsConditionStateData extends TermsConditionsState {
  final TermsConditionsModel termsConditionModel;
  TermsConditionStateData({required this.termsConditionModel});
}
