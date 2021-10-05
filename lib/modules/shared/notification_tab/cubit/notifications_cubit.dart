import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:gadha/modules/shared/notification_tab/data/notifications_service.dart';

import 'package:gadha/modules/shared/notification_tab/modes/notifications.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsLoading()) {
    refresh();
  }

  final _notifications = <NotificationModel>[];

  factory NotificationsCubit.of(BuildContext context) =>
      BlocProvider.of<NotificationsCubit>(context, listen: false);

  Future<void> refresh() async {
    _pageNo = 0;
   _canLoadMore = true;
    _notifications.clear();
    return loadMore();
  }

  int _pageNo = 0;
   bool _canLoadMore = true;
  //bool get canLoadMore => false;
   bool get canLoadMore => _canLoadMore;

  Future<void> loadMore() async {
     if (!_canLoadMore) return;
    try {
      emit(_pageNo == 0
          ? NotificationsLoading()
          : NotificationsLoadingMore(_notifications));
      final data = await NotificationsService.findMany(++_pageNo);

       _canLoadMore = data.isNotEmpty;
      _notifications.addAll(data);
      emitNotifications();
    } catch (e) {
      emit(NotificationsCant(e.toString()));
    }
  }

  void emitNotifications() {
    if (_notifications.isEmpty) {
      emit(NotificationsEmpty());
    } else {
      emit(NotificationsLoaded(_notifications));
    }
  }
}
