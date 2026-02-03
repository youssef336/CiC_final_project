import 'package:flutter/material.dart';
import 'package:mysterybag/features/home/presentation/views/home_view.dart';
import 'package:mysterybag/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('404 Not Found'))),
      );
  }
}
