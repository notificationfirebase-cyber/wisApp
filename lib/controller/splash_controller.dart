import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/navigation_routes.dart';
import '../service/device_token_service.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      _onLoad();
    });
  }

  Future<void> _onLoad() async {
    // Check internet before navigating to login (which loads a WebView)
    final hasInternet = await _hasRealInternet();

    if (!hasInternet) {
      Get.offAllNamed(Pages.routeNoInternet);
    } else {
     await _saveDeviceToken(); // ← add this

      Get.offAllNamed(Pages.routeLogin);
    }
  }

  Future<bool> _hasRealInternet() async {
    try {
      final results = await Connectivity().checkConnectivity();
      final hasNetwork = results.any((r) => r != ConnectivityResult.none);
      if (!hasNetwork) return false;

      // Then confirm real internet via DNS
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }



  Future<void> _saveDeviceToken() async {
    try {
      /// ✅ iOS ke liye APNS token wait karo
      if (Platform.isIOS) {
        String? apnsToken;

        int retry = 0;

        while (apnsToken == null && retry < 5) {
          await Future.delayed(const Duration(seconds: 2));

          apnsToken =
          await FirebaseMessaging.instance.getAPNSToken();

          debugPrint('APNS Token: $apnsToken');

          retry++;
        }

        /// Agar APNS token nahi mila to stop
        if (apnsToken == null) {
          debugPrint(
            'APNS token not available. Skipping FCM token save.',
          );
          return;
        }
      }

      /// ✅ FCM token
      final fcmToken =
      await FirebaseMessaging.instance.getToken();

      // final prefs = await SharedPreferences.getInstance();
      //
      // final authToken =
      //     prefs.getString('auth_token') ?? '';

      debugPrint('FCM Token: $fcmToken');

      // debugPrint('Auth Token: $authToken');

      if (fcmToken != null && fcmToken.isNotEmpty) {
        final service = DeviceTokenService();

        await service.saveDeviceToken(
          token: fcmToken,
          deviceType:
          Platform.isAndroid ? 'android' : 'ios',
         // authToken: authToken,
        );

        debugPrint('Device token saved successfully');
      }
    } catch (e) {
      debugPrint('Save device token error: $e');
    }
  }}