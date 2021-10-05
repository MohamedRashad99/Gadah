part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsLoaded(this.notifications);
}

class NotificationsLoadingMore extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsLoadingMore(this.notifications);
}

class NotificationsCant extends NotificationsState {
  final String msg;
  NotificationsCant(this.msg);
}

class NotificationsEmpty extends NotificationsState {}
