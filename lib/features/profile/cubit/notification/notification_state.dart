import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  final bool isAktivitasEnabled;
  final bool isSpesialEnabled;
  final bool isPengingatEnabled;

  const NotificationState({
    this.isAktivitasEnabled = false,
    this.isSpesialEnabled = false,
    this.isPengingatEnabled = false,
  });

  NotificationState copyWith({
    bool? isAktivitasEnabled,
    bool? isSpesialEnabled,
    bool? isPengingatEnabled,
  }) {
    return NotificationState(
      isAktivitasEnabled: isAktivitasEnabled ?? this.isAktivitasEnabled,
      isSpesialEnabled: isSpesialEnabled ?? this.isSpesialEnabled,
      isPengingatEnabled: isPengingatEnabled ?? this.isPengingatEnabled,
    );
  }

  @override
  List<Object?> get props => [
    isAktivitasEnabled,
    isSpesialEnabled,
    isPengingatEnabled,
  ];
}