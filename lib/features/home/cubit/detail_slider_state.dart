part of 'detail_slider_cubit.dart';

sealed class DetailSliderState extends Equatable {
  const DetailSliderState();

  @override
  List<Object> get props => [];
}

final class DetailSliderInitial extends DetailSliderState {}

final class DetailSliderStateLoading extends DetailSliderState {}

final class DetailSliderStateSuccess extends DetailSliderState {
  final SliderModel data;

  DetailSliderStateSuccess({required this.data});
}

final class DetailSliderStateError extends DetailSliderState {
  final String message;

  DetailSliderStateError({required this.message});
}
