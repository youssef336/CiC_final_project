import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @onBoardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onBoardingSkip;

  /// No description provided for @onBoardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Reduce Waste. Discover Value.'**
  String get onBoardingTitle;

  /// No description provided for @onBoardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Buy discounted mystery bags from local restaurants and enjoy safe, affordable meals with AI-powered quality verification.'**
  String get onBoardingSubtitle;

  /// No description provided for @onBoardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Smart Food. Zero Waste.'**
  String get onBoardingTitle2;

  /// No description provided for @onBoardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Discover surplus meals at lower prices and verify freshness using Xspire’s AI camera technology.'**
  String get onBoardingSubtitle2;

  /// No description provided for @onBoardingButtomText.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get onBoardingButtomText;

  /// No description provided for @onLoginLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get onLoginLogin;

  /// No description provided for @onLoginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get onLoginEmail;

  /// No description provided for @onLoginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get onLoginPassword;

  /// No description provided for @onLoginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get onLoginForgotPassword;

  /// No description provided for @onLoginCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get onLoginCreateAccount;

  /// No description provided for @onLoginCreateAccountText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get onLoginCreateAccountText;

  /// No description provided for @onLoginLoginOrDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get onLoginLoginOrDivider;

  /// No description provided for @onLoginLoginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get onLoginLoginWithGoogle;

  /// No description provided for @onLoginLoginWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Login with Facebook'**
  String get onLoginLoginWithFacebook;

  /// No description provided for @onLoginLoginWithApple.
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get onLoginLoginWithApple;

  /// No description provided for @onSignupSignup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get onSignupSignup;

  /// No description provided for @onSignupName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get onSignupName;

  /// No description provided for @onSignupEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get onSignupEmail;

  /// No description provided for @onSignupPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get onSignupPassword;

  /// No description provided for @onSignupTermsandConditions.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to '**
  String get onSignupTermsandConditions;

  /// No description provided for @onSignupTermsandConditionsText.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get onSignupTermsandConditionsText;

  /// No description provided for @onSignupTermsandConditionsText2.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get onSignupTermsandConditionsText2;

  /// No description provided for @onSignupTermsandConditionsText3.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get onSignupTermsandConditionsText3;

  /// No description provided for @onSignupTermsandConditionsErrorBar.
  ///
  /// In en, this message translates to:
  /// **'Please accept the Terms and Conditions and Privacy Policy'**
  String get onSignupTermsandConditionsErrorBar;

  /// No description provided for @onSignupCreateNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get onSignupCreateNewAccount;

  /// No description provided for @onSignupCreateNewAccountText.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get onSignupCreateNewAccountText;

  /// No description provided for @onSignupCreateNewAccountText2.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get onSignupCreateNewAccountText2;

  /// No description provided for @onSignupTextFeils.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get onSignupTextFeils;

  /// No description provided for @homeViewWelcomeAppbar.
  ///
  /// In en, this message translates to:
  /// **'Good Morning !..'**
  String get homeViewWelcomeAppbar;

  /// No description provided for @homeViewAppbarPoint.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get homeViewAppbarPoint;

  /// No description provided for @buttonNavigationBarEntityHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get buttonNavigationBarEntityHome;

  /// No description provided for @buttonNavigationBarEntityProducts.
  ///
  /// In en, this message translates to:
  /// **'products'**
  String get buttonNavigationBarEntityProducts;

  /// No description provided for @buttonNavigationBarEntityCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get buttonNavigationBarEntityCart;

  /// No description provided for @buttonNavigationBarEntityProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get buttonNavigationBarEntityProfile;

  /// No description provided for @cartViewHeader.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartViewHeader;

  /// No description provided for @checkOutViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkOutViewTitle;

  /// No description provided for @checkOutViewAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get checkOutViewAddress;

  /// No description provided for @checkOutViewPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get checkOutViewPayment;

  /// No description provided for @checkOutViewShipingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Cash On Delivery'**
  String get checkOutViewShipingTitle1;

  /// No description provided for @checkOutViewShipingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Delivery From Location'**
  String get checkOutViewShipingSubtitle1;

  /// No description provided for @checkOutViewShipingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get checkOutViewShipingTitle2;

  /// No description provided for @checkOutViewShipingPrice.
  ///
  /// In en, this message translates to:
  /// **' EGP'**
  String get checkOutViewShipingPrice;

  /// No description provided for @checkOutViewShipingError.
  ///
  /// In en, this message translates to:
  /// **'Please Select Payment Method'**
  String get checkOutViewShipingError;

  /// No description provided for @checkOutViewShipingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get checkOutViewShipingSubtitle2;

  /// No description provided for @checkOutViewPayWithPayPal.
  ///
  /// In en, this message translates to:
  /// **'Pay with PayPal'**
  String get checkOutViewPayWithPayPal;

  /// No description provided for @checkOutViewNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get checkOutViewNext;

  /// No description provided for @orderSummaryWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Summary :'**
  String get orderSummaryWidgetTitle;

  /// No description provided for @orderSummaryWidgetSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal :'**
  String get orderSummaryWidgetSubtotal;

  /// No description provided for @orderSummaryWidgetShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping :'**
  String get orderSummaryWidgetShipping;

  /// No description provided for @orderSummaryWidgetTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get orderSummaryWidgetTotal;

  /// No description provided for @orderCubitBlocConsumer.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully'**
  String get orderCubitBlocConsumer;

  /// No description provided for @addressSummaryWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address :'**
  String get addressSummaryWidgetTitle;

  /// No description provided for @addressSummaryWidgetChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get addressSummaryWidgetChange;

  /// No description provided for @addressInputSectionName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get addressInputSectionName;

  /// No description provided for @addressInputSectionEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get addressInputSectionEmail;

  /// No description provided for @addressInputSectionPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get addressInputSectionPhone;

  /// No description provided for @addressInputSectionAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressInputSectionAddress;

  /// No description provided for @addressInputSectionCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get addressInputSectionCity;

  /// No description provided for @addressInputSectionFloor.
  ///
  /// In en, this message translates to:
  /// **'Floor Number , Apartment Number ..'**
  String get addressInputSectionFloor;

  /// No description provided for @profileViewLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileViewLanguage;

  /// No description provided for @profileViewLanguageValueItem.
  ///
  /// In en, this message translates to:
  /// **'Arabic Language'**
  String get profileViewLanguageValueItem;

  /// No description provided for @profileViewLanguageValueItem2.
  ///
  /// In en, this message translates to:
  /// **'English Language'**
  String get profileViewLanguageValueItem2;

  /// No description provided for @profileViewProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile Image'**
  String get profileViewProfileImage;

  /// No description provided for @profileViewFavourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get profileViewFavourites;

  /// No description provided for @profileViewLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileViewLogout;

  /// No description provided for @profileViewLogoutText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get profileViewLogoutText;

  /// No description provided for @profileViewLogoutText2.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileViewLogoutText2;

  /// No description provided for @profileViewLogoutText3.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileViewLogoutText3;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'en':
      return SEn();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
