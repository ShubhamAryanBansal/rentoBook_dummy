import 'package:flutter/material.dart';
import 'package:rento_dummy/presentation/login_page.dart';

class AppRouter {

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Login_page(),
        );
      default:
        return null;
    }
  }
}