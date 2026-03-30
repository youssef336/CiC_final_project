import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/cubits/locale/locale_cubit.dart';
import 'package:mysterybag/core/cubits/theme/theme_cubit.dart';
import 'package:mysterybag/core/helper_functions/on_generate_routes.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
import 'package:mysterybag/features/home/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:mysterybag/features/splash/presentation/views/splash_view.dart';
import 'package:mysterybag/firebase_options.dart';
import 'package:mysterybag/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      // Already initialized, ignore
    } else {
      rethrow;
    }
  } catch (e) {
    // Check if it's the duplicate app error string
    final errorString = e.toString().toLowerCase();
    if (!errorString.contains('duplicate-app')) {
      rethrow;
    }
  }
  await Prefs.init();
  setupGetIt();
  runApp(
    Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<CartCubit>(create: (context) => CartCubit()),
        ],
        child: const MysteryBag(),
      ),
    ),
  );
}

class MysteryBag extends StatelessWidget {
  const MysteryBag({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeState) {
            String locale = Prefs.getString(Klocale);
            return MaterialApp(
              // ========== Dark Theme ==========
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: KdarkModeBgColor,
                primaryColor: KprimaryColor,
                colorScheme: const ColorScheme.dark(
                  brightness: Brightness.dark,
                  primary: KprimaryColor,
                  onPrimary: KlightModeCardColor,
                  secondary: KprimaryColorLight,
                  onSecondary: KprimaryColorDark,
                  surface: KdarkModeCardColor,
                  onSurface: KdarkModeTextColor,
                  error: KprimaryColorDark,
                  onError: KsecondaryColor,
                ).copyWith(
                  surfaceContainer: KdarkModeCardColor,
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: KprimaryColor,
                  foregroundColor: KsecondaryColor,
                  elevation: 0,
                ),
                cardColor: KdarkModeCardColor,
                dividerColor: KprimaryColorLight.withOpacity(0.2),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: KprimaryColor,
                  selectedItemColor: KprimaryColorLight,
                  unselectedItemColor: KdarkModeTextSecondary,
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: KprimaryColorLight,
                  foregroundColor: KprimaryColorDark,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: KdarkModeCardColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: KprimaryColorLight.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: KprimaryColorLight, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintStyle: const TextStyle(color: KdarkModeTextSecondary),
                ),
              ),
              // ========== Light Theme ==========
              theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: KlightModeBgColor,
                primaryColor: KprimaryColorLight,
                colorScheme: const ColorScheme.light(
                  brightness: Brightness.light,
                  primary: KprimaryColorLight,
                  onPrimary: KprimaryColorDark,
                  secondary: KprimaryColor,
                  onSecondary: KsecondaryColor,
                  surface: KlightModeCardColor,
                  onSurface: KlightModeTextColor,
                  error: KprimaryColorDark,
                  onError: KsecondaryColor,
                ).copyWith(
                  surfaceContainer: KlightModeCardColor,
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: KprimaryColorLight,
                  foregroundColor: KprimaryColorDark,
                  elevation: 0,
                ),
                cardColor: KlightModeCardColor,
                dividerColor: KdisabledColor.withOpacity(0.2),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: KlightModeCardColor,
                  selectedItemColor: KprimaryColor,
                  unselectedItemColor: KlightModeTextSecondary,
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: KprimaryColor,
                  foregroundColor: KlightModeCardColor,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: KlightModeCardColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: KdisabledColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: KprimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintStyle: const TextStyle(color: KlightModeTextSecondary),
                ),
              ),
              themeMode: themeState,
              title: 'Mystery Bag',

              localizationsDelegates: const [
                S.delegate, // Generated by Flutter Intl / gen-l10n
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
              // initialRoute: '/bagDetails',
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
