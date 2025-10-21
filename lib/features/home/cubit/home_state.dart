part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeStateLoading extends HomeState {}

final class HomeStateSuccess extends HomeState {
  final HomeResponse data;

  HomeStateSuccess({required this.data});
}

final class HomeStateError extends HomeState {
  final String message;

  HomeStateError({required this.message});
}
