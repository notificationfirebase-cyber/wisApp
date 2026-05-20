import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    final fcmToken = await FirebaseMessaging.instance.getToken();
     final prefs = await SharedPreferences.getInstance();
     final authToken = prefs.getString('auth_token') ?? '';  // wherever you store it

    print('fcmToken');
    print(fcmToken);
    print(authToken);


    if (fcmToken != null) {
      final service = DeviceTokenService();
      await service.saveDeviceToken(
        token: fcmToken,
        deviceType: Platform.isAndroid ? 'android' : 'ios',
        authToken: authToken,
      );
    }
  }
}