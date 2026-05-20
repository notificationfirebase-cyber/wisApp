import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/no_internet_controller.dart';
import '../routes/navigation_routes.dart';

/// Place this as [builder] in GetMaterialApp.
/// It listens to connectivity changes and auto-navigates to NoInternetScreen
/// on any screen when internet is lost, and auto-recovers when it returns.
class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  StreamSubscription<List<ConnectivityResult>>? _sub;
  bool _wasOffline = false;

  @override
  void initState() {
    super.initState();
    // Check immediately on launch
    _checkOnLaunch();
    // Then listen for changes
    _sub = Connectivity().onConnectivityChanged.listen(_onChanged);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Runs once at app launch — if already offline, redirect immediately.
  Future<void> _checkOnLaunch() async {
    final results = await Connectivity().checkConnectivity();
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);
    if (!hasNetwork) {
      _wasOffline = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.currentRoute != Pages.routeNoInternet) {
          Get.toNamed(Pages.routeNoInternet);
        }
      });
      return;
    }
    // Has a network adapter — confirm real internet
    final hasReal = await _hasRealInternet();
    if (!hasReal) {
      _wasOffline = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.currentRoute != Pages.routeNoInternet) {
          Get.toNamed(Pages.routeNoInternet);
        }
      });
    }
  }

  Future<void> _onChanged(List<ConnectivityResult> results) async {
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);

    if (!hasNetwork) {
      _wasOffline = true;
      if (Get.currentRoute != Pages.routeNoInternet) {
        Get.toNamed(Pages.routeNoInternet);
      }
      return;
    }

    final hasReal = await _hasRealInternet();
    if (!hasReal) {
      _wasOffline = true;
      if (Get.currentRoute != Pages.routeNoInternet) {
        Get.toNamed(Pages.routeNoInternet);
      }
    } else if (_wasOffline) {
      _wasOffline = false;
      Get.find<NoInternetController>().retryConnection(silent: true);
    }
  }

  Future<bool> _hasRealInternet() async {
    try {
      final r = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 4));
      return r.isNotEmpty && r[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}