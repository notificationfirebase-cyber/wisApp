import 'package:get/get.dart';

import '../screens/login_screen.dart';
import '../screens/no_internet_screen.dart';
import '../screens/splash_screen.dart';



class Pages {
  static String routeSplash = "/splash";
  static String routeLogin = "/login";
  static String routeNoInternet = "/no-internet";

  static String initRoute = routeNoInternet;
  //static String initRoute = routeSplash;

  static var appRoutes = [

    GetPage(name: routeSplash, page: () =>  const SplashScreen()),
    GetPage(name: routeLogin, page: () =>   LoginScreen()),
    GetPage(name: routeNoInternet, page: () =>  NoInternetScreen()), // ← NEW


  ];

}