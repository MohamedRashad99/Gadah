import 'dart:async';

import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:gadha/modules/shared/notification_tab/modes/notifications.dart';
import 'package:laravel_exception/laravel_exception.dart';

class NotificationsService {

  NotificationsService._();
  static Future<List<NotificationModel>> findMany(int page) async {
    final resp = await Api.get(kUserNotifications, query: {
      'page':page
    });
    if (resp.statusCode != 200) throw LaravelException.parse(resp.data);
    return (resp.data['data'] as List)
        .map((e) => NotificationModel.fromMap(e))
        .toList();
  }
}
