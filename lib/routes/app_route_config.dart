import 'package:calendar_app/pages/calendar_page.dart';
import 'package:calendar_app/pages/fall_back_page.dart';
import 'package:calendar_app/pages/home_page.dart';
import 'package:calendar_app/pages/landing_page.dart';
import 'package:calendar_app/pages/splash_page.dart';
import 'package:calendar_app/pages/test/calendar_test_page.dart';
import 'package:calendar_app/routes/app_route_names.dart';
import 'package:flutter/material.dart';

class AppRouteConfig {
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.testPage:
        return MaterialPageRoute(builder: (context) => const CalendarTestPage());
      case AppRouteNames.splashPage:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case AppRouteNames.landingPage:
        return MaterialPageRoute(builder: (context) => const LandingPage());
      case AppRouteNames.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppRouteNames.calendarPage:
        return MaterialPageRoute(builder: (context) => const CalendarPage());
      default:
        return MaterialPageRoute(builder: (context) => const FallBackPage());
    }
  }
}
