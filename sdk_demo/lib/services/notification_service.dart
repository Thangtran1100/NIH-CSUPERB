import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  // Initialize the notification service
  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );
  }

  static Future<void> showEndTripNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        payload: {'payload': payload},
      ),
    );
  }
}
