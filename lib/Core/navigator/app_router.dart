import 'package:flutter/material.dart';
import 'package:rotten_chickens/feature/auth/view/login_page.dart';
import 'package:rotten_chickens/feature/home_screen/view/home_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case '/Login':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case '/Home':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
    }
  }
}
