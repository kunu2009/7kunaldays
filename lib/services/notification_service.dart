import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );

    // Request permissions for Android 13+
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleDailyReminders() async {
    // Morning Reminder - 6:00 AM
    await _scheduleNotification(
      id: 1,
      title: '🌅 Rise & Focus',
      body: 'Water + Movement + Today\'s Mission',
      hour: 6,
      minute: 0,
    );

    // College Focus - 11:45 AM
    await _scheduleNotification(
      id: 2,
      title: '🏫 College Mode',
      body: 'Stay present. Every lecture counts.',
      hour: 11,
      minute: 45,
    );

    // Night Closure - 10:15 PM
    await _scheduleNotification(
      id: 3,
      title: '🌙 Night Reflection',
      body: 'Log your wins. Plan tomorrow. 1% better.',
      hour: 22,
      minute: 15,
    );
  }

  static Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminders',
          'Daily Reminders',
          channelDescription: 'Notifications for daily routine',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static Future<void> showStreakReminder(String message) async {
    await _notifications.show(
      99,
      '🔥 Streak Alert',
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'streaks',
          'Streak Notifications',
          channelDescription: 'Motivational streak reminders',
          importance: Importance.max,
          priority: Priority.max,
        ),
      ),
    );
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
