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

  /// No description provided for @homeBestSellersTitle.
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get homeBestSellersTitle;

  /// No description provided for @homeBestSellersViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeBestSellersViewAll;

  /// No description provided for @homeFeaturedItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Item'**
  String get homeFeaturedItemTitle;

  /// No description provided for @homeFeaturedItemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Special Offer'**
  String get homeFeaturedItemSubtitle;

  /// No description provided for @homeFeaturedItemShopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get homeFeaturedItemShopNow;

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

  /// No description provided for @profileViewTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profileViewTheme;

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

  /// No description provided for @profileViewPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get profileViewPoints;

  /// No description provided for @pointsPageYourPoints.
  ///
  /// In en, this message translates to:
  /// **'Your Points'**
  String get pointsPageYourPoints;

  /// No description provided for @pointsPagePts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get pointsPagePts;

  /// No description provided for @pointsPageRewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards & Discounts'**
  String get pointsPageRewardsTitle;

  /// No description provided for @pointsPageDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get pointsPageDiscount;

  /// No description provided for @pointsPagePointsRequired.
  ///
  /// In en, this message translates to:
  /// **'points required'**
  String get pointsPagePointsRequired;

  /// No description provided for @pointsPageUnlocked.
  ///
  /// In en, this message translates to:
  /// **'UNLOCKED'**
  String get pointsPageUnlocked;

  /// No description provided for @pointsPageProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get pointsPageProgress;

  /// No description provided for @pointsPagePointsToGo.
  ///
  /// In en, this message translates to:
  /// **'points to go!'**
  String get pointsPagePointsToGo;

  /// No description provided for @pointsPageAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get pointsPageAdd;

  /// No description provided for @pointsPageDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get pointsPageDelete;

  /// No description provided for @productGridViewPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productGridViewPlaceholder;

  /// No description provided for @searchProductsHint.
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get searchProductsHint;

  /// No description provided for @loadDemoDataButton.
  ///
  /// In en, this message translates to:
  /// **'Load Demo Data'**
  String get loadDemoDataButton;

  /// No description provided for @demoDataLoadedMessage.
  ///
  /// In en, this message translates to:
  /// **'Demo data loaded! Go to Cart to test checkout.'**
  String get demoDataLoadedMessage;

  /// No description provided for @homeViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeViewTitle;

  /// No description provided for @logoutErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error occurred during logout'**
  String get logoutErrorMessage;

  /// Message shown when coupon discount is successfully applied
  ///
  /// In en, this message translates to:
  /// **'Discount applied: {discount} EGP'**
  String couponDiscountApplied(String discount);

  /// No description provided for @invalidCouponError.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired coupon code'**
  String get invalidCouponError;

  /// No description provided for @couponCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Coupon code'**
  String get couponCodeHint;

  /// No description provided for @errorPageNotFound.
  ///
  /// In en, this message translates to:
  /// **'404 Not Found'**
  String get errorPageNotFound;

  /// No description provided for @paymentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get paymentSuccessMessage;

  /// No description provided for @paymentErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment error'**
  String get paymentErrorMessage;

  /// No description provided for @weakPasswordError.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak.'**
  String get weakPasswordError;

  /// No description provided for @emailAlreadyInUseError.
  ///
  /// In en, this message translates to:
  /// **'The email address is already in use by another account.'**
  String get emailAlreadyInUseError;

  /// No description provided for @networkRequestFailedError.
  ///
  /// In en, this message translates to:
  /// **'Network request failed, please check your internet connection.'**
  String get networkRequestFailedError;

  /// No description provided for @invalidEmailError.
  ///
  /// In en, this message translates to:
  /// **'The email address is not valid.'**
  String get invalidEmailError;

  /// No description provided for @unknownErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred please try again later.'**
  String get unknownErrorMessage;

  /// No description provided for @emailPasswordProblemError.
  ///
  /// In en, this message translates to:
  /// **'There is a problem in email or password'**
  String get emailPasswordProblemError;

  /// No description provided for @signInCancelledError.
  ///
  /// In en, this message translates to:
  /// **'Sign-in cancelled by user'**
  String get signInCancelledError;

  /// No description provided for @googleSignInFailedError.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In failed'**
  String get googleSignInFailedError;

  /// No description provided for @availableBagsSwipeHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe →'**
  String get availableBagsSwipeHint;

  /// No description provided for @bagCurrencySuffix.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get bagCurrencySuffix;

  /// No description provided for @bagCardReserve.
  ///
  /// In en, this message translates to:
  /// **'Reserve'**
  String get bagCardReserve;

  /// Number of mystery bags still available
  ///
  /// In en, this message translates to:
  /// **'{count} Bags left'**
  String bagCardBagsLeft(String count);

  /// No description provided for @bagDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Mystery Bag Arousa'**
  String get bagDetailsTitle;

  /// No description provided for @bagDetailsPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get bagDetailsPriceLabel;

  /// No description provided for @bagDetailsCurrentPrice.
  ///
  /// In en, this message translates to:
  /// **'50 EGP'**
  String get bagDetailsCurrentPrice;

  /// No description provided for @bagDetailsOldPrice.
  ///
  /// In en, this message translates to:
  /// **'100 EGP'**
  String get bagDetailsOldPrice;

  /// No description provided for @bagDetailsWhatInsideTitle.
  ///
  /// In en, this message translates to:
  /// **'What is in the bag?'**
  String get bagDetailsWhatInsideTitle;

  /// No description provided for @bagDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'One Arousa sandwich made with pita bread, served with crispy fries and a refreshing drink.'**
  String get bagDetailsDescription;

  /// No description provided for @bagDetailsReservePickup.
  ///
  /// In en, this message translates to:
  /// **'Reserve for pickup'**
  String get bagDetailsReservePickup;

  /// No description provided for @productsViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get productsViewTitle;

  /// No description provided for @availableBagsTitle.
  ///
  /// In en, this message translates to:
  /// **'Available bags'**
  String get availableBagsTitle;

  /// No description provided for @restaurantNameMadbinaZamalek.
  ///
  /// In en, this message translates to:
  /// **'Madbina - Zamalek'**
  String get restaurantNameMadbinaZamalek;

  /// Restaurant branch count label
  ///
  /// In en, this message translates to:
  /// **'{count} branch'**
  String restaurantBranchesCount(String count);

  /// Distance to restaurant in kilometers
  ///
  /// In en, this message translates to:
  /// **'{distance} kilometers'**
  String restaurantDistanceKilometers(String distance);

  /// No description provided for @bagTitleAroussaSandwich.
  ///
  /// In en, this message translates to:
  /// **'Aroussa Sandwich Bag'**
  String get bagTitleAroussaSandwich;

  /// No description provided for @bagTitleMasrawy.
  ///
  /// In en, this message translates to:
  /// **'Masrawy Bag'**
  String get bagTitleMasrawy;

  /// No description provided for @statusBadgeAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get statusBadgeAvailable;

  /// No description provided for @statusBadgeNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get statusBadgeNow;

  /// Number of results displayed in product header
  ///
  /// In en, this message translates to:
  /// **'{count} results'**
  String productViewResults(String count);

  /// No description provided for @couponPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Coupon'**
  String get couponPageTitle;

  /// No description provided for @couponCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Coupon Code'**
  String get couponCodeLabel;

  /// No description provided for @couponPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Use this code to redeem your points'**
  String get couponPageDescription;

  /// No description provided for @couponCopyButton.
  ///
  /// In en, this message translates to:
  /// **'Copy Code'**
  String get couponCopyButton;

  /// No description provided for @couponCopiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Coupon code copied!'**
  String get couponCopiedMessage;

  /// No description provided for @couponUniqueText.
  ///
  /// In en, this message translates to:
  /// **'This code is unique to your account'**
  String get couponUniqueText;
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
