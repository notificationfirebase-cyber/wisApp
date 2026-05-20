import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wis_app/common/helper.dart';

import '../routes/navigation_routes.dart';

class LoginController extends GetxController {
  late final WebViewController webViewController;

  final RxBool isLoading = true.obs;
  final RxInt loadingProgress = 0.obs;

  final String loginUrl = 'https://wheaton.co.in/login';

  // Monitors connectivity while on the login/webview screen
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  @override
  void onInit() {
    super.onInit();
    _initWebView();
    _listenToConnectivity();
  }

  @override
  void onClose() {
    _connectivitySub?.cancel();
    super.onClose();
  }

  void _initWebView() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.primaryColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isLoading.value = true;
          },
          onProgress: (progress) {
            loadingProgress.value = progress;
          },
          onPageFinished: (url) {
            isLoading.value = false;
            _injectAppStyles();
          },
          onWebResourceError: (error) {
            isLoading.value = false;
            // WebView failed to load — check if it's a network issue
            _handleWebResourceError();
          },
        ),
      )
      ..loadRequest(Uri.parse(loginUrl));
  }

  void _listenToConnectivity() {
    _connectivitySub =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) async {
          final hasNetwork = results.any((r) => r != ConnectivityResult.none);
          if (!hasNetwork) {
            if (Get.currentRoute != Pages.routeNoInternet) {
              Get.toNamed(Pages.routeNoInternet);
            }
            return;
          }
          // Network came back — verify real internet
          final hasReal = await _hasRealInternet();
          if (!hasReal && Get.currentRoute != Pages.routeNoInternet) {
            Get.toNamed(Pages.routeNoInternet);
          }
        });
  }

  Future<void> _handleWebResourceError() async {
    final hasInternet = await _hasRealInternet();
    if (!hasInternet && Get.currentRoute != Pages.routeNoInternet) {
      Get.toNamed(Pages.routeNoInternet);
    }
  }

  Future<bool> _hasRealInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 4));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _injectAppStyles() {
    webViewController.runJavaScript('''
      (function() {
        var style = document.createElement('style');
        style.innerHTML = `
          body {
            background-color: #002B3D !important;
          }
          .login-box, .card, .auth-box, .wrapper {
            background-color: #003a52 !important;
          }
        `;
        document.head.appendChild(style);
      })();
    ''');
  }

  void reload() {
    webViewController.reload();
  }

  Future<bool> onBackPressed() async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return false;
    }
    return true;
  }
}