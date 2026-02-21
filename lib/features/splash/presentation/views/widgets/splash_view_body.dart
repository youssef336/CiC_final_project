import 'package:flutter/material.dart';
import 'package:mysterybag/assets.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/services/firebase_auth_services.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
import 'package:mysterybag/features/auth/presentation/views/Sign_in_view.dart';
import 'package:mysterybag/features/home/presentation/views/home_view.dart';

import '../../../../onBoarding/presentation/views/on_boarding.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  bool isBorderingViewSeen = Prefs.getBool(KisBoardingViewSeen);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Scale from 0.7x to 1.2x
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Fade from transparent to fully visible
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(const Duration(seconds: 5), () {
      if (isBorderingViewSeen) {
        var isLoggedIn = FirebaseAuthServices().isUserLoggedIn();
        if (isLoggedIn) {
          // User is logged in, navigate to home
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        } else {
          // User is not logged in, navigate to sign-in
          Navigator.pushReplacementNamed(context, SigninView.routeName);
        }
      } else {
        Navigator.pushReplacementNamed(context, OnBoarding.routeName);
      }
    });
    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            Assets.images.app_icon_jpg,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
