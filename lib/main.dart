import 'package:flutter/material.dart';
import 'package:mysterybag/core/helper_functions/on_generate_routes.dart';
import 'package:mysterybag/features/home/presentation/views/home_view.dart';
import 'package:mysterybag/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const MysteryBag());
}

class MysteryBag extends StatelessWidget {
  const MysteryBag({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
