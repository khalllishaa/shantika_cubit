part of 'promo_check_cubit.dart';

sealed class PromoCheckState extends Equatable {
  const PromoCheckState();

  @override
  List<Object> get props => [];
}

final class PromoCheckInitial extends PromoCheckState {}

final class PromoCheckStateLoading extends PromoCheckState {}

final class PromoCheckStateSuccess extends PromoCheckState {
  final int discount;
  final GuardModel? guard;

  PromoCheckStateSuccess({required this.discount, this.guard});
}

final class PromoCheckStateError extends PromoCheckState {
  final String message;

  PromoCheckStateError({required this.message});
}
