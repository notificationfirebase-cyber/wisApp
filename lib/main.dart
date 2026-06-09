import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:wis_app/firebase_options.dart';
import 'package:wis_app/routes/navigation_routes.dart';

import 'common/connectivity_wrapper.dart';
import 'controller/splash_controller.dart';

/// ✅ Background notification handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint(
    'Background message: ${message.notification?.title}',
  );
}

/// ✅ Local notification plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// ✅ Android notification channel
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'Used for important notifications.',
  importance: Importance.high,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ✅ Lock orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// ✅ Register background handler
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  /// ✅ Request notification permissions
  NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  debugPrint(
    'Permission status: ${settings.authorizationStatus}',
  );

  /// ✅ iOS APNS Token
  if (GetPlatform.isIOS) {
    await Future.delayed(const Duration(seconds: 2));

    String? apnsToken =
    await FirebaseMessaging.instance.getAPNSToken();

    debugPrint('APNS Token: $apnsToken');
  }

  /// ✅ Get FCM Token
  try {
    String? fcmToken =
    await FirebaseMessaging.instance.getToken();

    debugPrint('FCM Token: $fcmToken');
  } catch (e) {
    debugPrint('FCM Token Error: $e');
  }

  /// ✅ Android local notification settings
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  /// ✅ iOS local notification settings
  const DarwinInitializationSettings iosSettings =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  /// ✅ Combined settings
  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  /// ✅ Initialize local notifications
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      debugPrint(
        'Notification tapped: ${details.payload}',
      );
    },
  );

  /// ✅ Create Android channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// ✅ Foreground notifications
  FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
      debugPrint(
        'Foreground message: ${message.notification?.title}',
      );

      RemoteNotification? notification =
          message.notification;

      if (notification != null) {
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(),
          ),
          payload: message.data.toString(),
        );
      }
    },
  );

  /// ✅ Notification tap when app in background
  FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
      debugPrint(
        'Notification tapped from background: ${message.data}',
      );

      /// Add navigation logic here
    },
  );

  /// ✅ Dependency injection
  Get.put(
    SplashController(),
    permanent: true,
  );

  runApp(const MyApp());
}

/// ✅ Root App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WIS Parent',
      initialRoute: Pages.initRoute,
      getPages: Pages.appRoutes,
      builder: (context, child) =>
          ConnectivityWrapper(child: child!),
    );
  }
}