part of 'guard_recomendation_cubit.dart';

sealed class GuardRecomendationState extends Equatable {
  const GuardRecomendationState();

  @override
  List<Object> get props => [];
}

final class GuardRecomendationInitial extends GuardRecomendationState {}

final class GuardRecomendationStateLoading extends GuardRecomendationState {}

final class GuardRecomendationStateSuccess extends GuardRecomendationState {
  final GuardModel guard;

  GuardRecomendationStateSuccess({required this.guard});
}

final class GuardRecomendationStateError extends GuardRecomendationState {
  final String message;

  GuardRecomendationStateError({required this.message});
}
