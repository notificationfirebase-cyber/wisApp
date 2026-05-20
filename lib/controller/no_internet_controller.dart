import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../routes/navigation_routes.dart';

class NoInternetController extends GetxController {
  final RxBool isChecking = false.obs;
  final RxBool isServerError = false.obs;

  // connectivity_plus v6+ emits List<ConnectivityResult>
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  @override
  void onInit() {
    super.onInit();
    _listenToConnectivity();
  }

  @override
  void onClose() {
    _connectivitySub?.cancel();
    super.onClose();
  }

  void _listenToConnectivity() {
    _connectivitySub =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
          final hasNetwork = results.any((r) => r != ConnectivityResult.none);
          if (hasNetwork) {
            // A network interface appeared — verify real internet then recover
            retryConnection(silent: true);
          }
        });
  }

  /// Called by "Try Again" button or auto on connectivity restore.
  Future<void> retryConnection({bool silent = false}) async {
    if (isChecking.value) return;
    isChecking.value = true;

    final hasInternet = await _checkInternet();

    if (!hasInternet) {
      isServerError.value = false;
      isChecking.value = false;
      return; // stay on NoInternetScreen
    }

    final serverOk = await _checkServer();
    isChecking.value = false;

    if (serverOk) {
      isServerError.value = false;
      Get.offAllNamed(Pages.routeSplash);
    } else {
      isServerError.value = true;
    }
  }

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _checkServer() async {
    try {
      final result = await InternetAddress.lookup('lms.wheatononlineschool.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}