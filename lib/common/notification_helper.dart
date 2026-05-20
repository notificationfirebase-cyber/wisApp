import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

/// A singleton class to manage notifications
class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  /// Call this once in main.dart (usually in `main()` before runApp)
  static Future<void> init() async {
    if (_isInitialized) return;

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(initSettings);
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    _isInitialized = true;
  }

  /// Call this to schedule a notification
  static Future<void> scheduleReminder({
    required String title,
    required String body,
    required DateTime scheduledDateTime,
    int id = 0,
  }) async {
    print("alarm rings");
    print("⏰ Scheduling notification at: $scheduledDateTime");
    print("⏰ Current time: ${DateTime.now()}");
    print("⏰ Timezone: ${tz.local}");
    //openExactAlarmSettings();
    final result = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    if (result != true) {
      print("🔴 Notification permission denied!");
      return;
    }
    /* await _notificationsPlugin.show(
      0,
      'Test Immediate',
      'This should show instantly',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
*/


    try {
      final tzScheduledDateTime = tz.TZDateTime.from(scheduledDateTime, tz.local);
      print("📅 Scheduling notification for: $tzScheduledDateTime");

      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzScheduledDateTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel_id',
            'Reminders',
            channelDescription: 'Channel for task reminders',
            importance: Importance.max,
            priority: Priority.high,
            fullScreenIntent: true,

          ),

        ),
        //androidAllowWhileIdle: true,
       // uiLocalNotificationDateInterpretation:
      //  UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      print("✅ Notification scheduled successfully.");
    } catch (e, stackTrace) {
      print("❌ Failed to schedule notification: $e");
      print("📍 Stack trace:\n$stackTrace");
    }

  }
}
void openExactAlarmSettings() {
  const AndroidIntent intent = AndroidIntent(
    action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
  );
  intent.launch();
}