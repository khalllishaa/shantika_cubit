import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/model/notification_model.dart';
import 'package:shantika_cubit/model/response/notifications_response.dart';
import 'package:shantika_cubit/repository/notification_repository.dart';
import 'package:shantika_cubit/utility/resource/data_state.dart';

class NotificationListState {
  final List<NotificationItem> notifications;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMoreData;

  const NotificationListState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMoreData = true,
  });

  NotificationListState copyWith({
    List<NotificationItem>? notifications,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMoreData,
  }) {
    return NotificationListState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

class NotificationListCubit extends Cubit<DataState<NotificationModel>> {
  final NotificationRepository _repository;

  NotificationListCubit(this._repository) : super(const DataStateLoading());

  Future<void> getNotifications({int page = 1}) async {
    emit(const DataStateLoading());

    final result = await _repository.notifications(page: page);

    if (result is DataStateSuccess<NotificationModel>) {
      emit(DataStateSuccess(result.data!));
    } else if (result is DataStateError<NotificationModel>) {
      emit(DataStateError(result.exception!));
    }
  }

  Future<void> markAsRead(String id) async {
    await _repository.readNotification(id: id);
    // Refresh notifications after marking as read
    await getNotifications();
  }

  Future<void> markAllAsRead() async {
    await _repository.readAllNotification();
    // Refresh notifications after marking all as read
    await getNotifications();
  }
}