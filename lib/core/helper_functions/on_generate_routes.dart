import 'package:flutter/material.dart';
import 'package:mysterybag/features/auth/presentation/views/Sign_in_view.dart';
import 'package:mysterybag/features/auth/presentation/views/sign_up_view.dart';
import 'package:mysterybag/features/check_out/presentation/views/check_out_view.dart';
import 'package:mysterybag/features/home/domain/entities/cart_entites.dart';
import 'package:mysterybag/features/home/presentation/views/main_view.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/profile_viewLanguage_page.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/profile_view_avtar_page.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/profile_view_points_page.dart';
import 'package:mysterybag/features/onBoarding/presentation/views/on_boarding.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/bag_details_view.dart';
import 'package:mysterybag/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/bagDetails':
      return MaterialPageRoute(builder: (_) => const BagDetailsView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (_) => const MainView());

    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (_) => const SigninView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case OnBoarding.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoarding());
    case ProfileViewLanguagePage.routeName:
      return MaterialPageRoute(builder: (_) => const ProfileViewLanguagePage());

    case ProfileViewAvtarPage.routeName:
      return MaterialPageRoute(builder: (_) => const ProfileViewAvtarPage());
    case CheckOutView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      final cartItems = args['cartItems'] as CartEntites;
      // final notification =
      // args['notificationEntity'] as List<NotificationEntity>?;
      return MaterialPageRoute(
        builder: (_) => CheckOutView(
          cartItems: cartItems,
          // notificationEntity: notification,
        ),
      );
    case BagDetailsView.routeName:
      return MaterialPageRoute(builder: (_) => const BagDetailsView());
    case ProfileViewPointsPage.routeName:
      return MaterialPageRoute(builder: (_) => const ProfileViewPointsPage());

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('404 Not Found'))),
      );
  }
}
