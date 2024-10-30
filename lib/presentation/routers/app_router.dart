import 'package:flutter/material.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/user_details_screen/user_details_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String login = "loginScreen";
  static const String home = "homeScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _screen(const LoginScreen());
      case home:
        return _screen(const HomeScreen());
      default:
        throw Exception("Route was not Found");
    }
  }

  static _screen(Widget screenName) {
    return MaterialPageRoute(
        builder: (context) => screenName);
  }
  static _screenWithData(RouteSettings settings,Widget screenName) {
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => screenName);
  }
}
