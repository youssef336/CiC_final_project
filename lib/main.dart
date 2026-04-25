import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/cubits/locale/locale_cubit.dart';
import 'package:mysterybag/core/cubits/theme/theme_cubit.dart';
import 'package:mysterybag/core/helper_functions/themes.dart';
import 'package:mysterybag/core/helper_functions/on_generate_routes.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/features/home/domain/entities/cart_entites.dart';
import 'package:mysterybag/features/home/domain/entities/cart_item_entity.dart';
import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/features/splash/presentation/views/splash_view.dart';

import 'package:mysterybag/firebase_options.dart';
import 'package:mysterybag/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init (سيبيه عادي)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  } catch (e) {
    if (!e.toString().toLowerCase().contains('duplicate-app')) {
      rethrow;
    }
  }

  setupGetIt();

  await Prefs.init();

  // 🟢 Fake Cart Data
  final fakeCart = CartEntites([
    CartItemEntity(
      productEntity: ProductEntity(
        nameEn: "Test Product",
        nameAr: "منتج تجريبي",
        code: "123",
        description: "This is a test product",
        price: 100,
        reviews: [],
        expirationsMonths: 12,
        numbersOfCalories: 200,
        unitAmount: 1,
        isFeatured: true,
        imageUrl: "",
      ),
      count: 2,
    ),
  ]);

  runApp(
    Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LocaleCubit()),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: MysteryBag(fakeCart: fakeCart),
      ),
    ),
  );
}

class MysteryBag extends StatelessWidget {
  const MysteryBag({super.key, required this.fakeCart});

  final CartEntites fakeCart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeState) {
            String locale = Prefs.getString(Klocale);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Mystery Bag',

              // 🎨 Themes
              theme: LightColorTheme(),
              darkTheme: DarkColorTheme(),
              themeMode: themeState,

              // 🌍 Localization
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.supportedLocales,
              locale: localeState is LocaleChangedtoEnglish
                  ? const Locale('en')
                  : localeState is LocaleChangedtoArabic
                  ? const Locale('ar')
                  : Locale(locale.isEmpty ? 'ar' : locale),
              onGenerateRoute: onGenerateRoute,
              initialRoute: SplashView.routeName,
            );
          },
        );
      },
    );
  }
}
