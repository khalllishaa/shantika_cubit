import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/model/terms_conditions_model.dart';

abstract class TermsConditionsState extends Equatable {
  const TermsConditionsState();

  @override
  List<Object?> get props => [];
}

class TermsConditionsInitial extends TermsConditionsState {}

class TermsConditionsLoading extends TermsConditionsState {}

class TermsConditionsLoaded extends TermsConditionsState {
  final TermsConditionsModel termsConditions;

  const TermsConditionsLoaded(this.termsConditions);

  @override
  List<Object?> get props => [termsConditions];
}

class TermsConditionsError extends TermsConditionsState {
  final String message;

  const TermsConditionsError(this.message);

  @override
  List<Object?> get props => [message];
}