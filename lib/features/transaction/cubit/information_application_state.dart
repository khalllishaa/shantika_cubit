part of 'information_application_cubit.dart';

sealed class InformationApplicationState extends Equatable {
  const InformationApplicationState();

  @override
  List<Object> get props => [];
}

final class InformationApplicationInitial extends InformationApplicationState {}

final class InformationApplicationStateLoading extends InformationApplicationState {}

final class InformationApplicationStateSuccess extends InformationApplicationState {
  final ApplicationModel data;

  InformationApplicationStateSuccess({required this.data});
}

final class InformationApplicationStateError extends InformationApplicationState {
  final String message;

  InformationApplicationStateError({required this.message});
}
