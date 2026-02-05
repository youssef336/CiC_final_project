// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Skip`
  String get on_boarding_skip {
    return Intl.message('Skip', name: 'on_boarding_skip', desc: '', args: []);
  }

  /// `welcome to   `
  String get on_boarding_title {
    return Intl.message(
      'welcome to   ',
      name: 'on_boarding_title',
      desc: '',
      args: [],
    );
  }

  /// `Discover a unique shopping experience with FruitHUB. Explore our wide selection of premium fresh fruits and enjoy the best offers with top quality.`
  String get on_boarding_subtitle {
    return Intl.message(
      'Discover a unique shopping experience with FruitHUB. Explore our wide selection of premium fresh fruits and enjoy the best offers with top quality.',
      name: 'on_boarding_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Browse and Shop `
  String get on_boarding_title2 {
    return Intl.message(
      'Browse and Shop ',
      name: 'on_boarding_title2',
      desc: '',
      args: [],
    );
  }

  /// `We offer you the finest handpicked fruits. Check details, photos, and reviews to ensure you select the perfect fruit.`
  String get on_boarding_subtitle2 {
    return Intl.message(
      'We offer you the finest handpicked fruits. Check details, photos, and reviews to ensure you select the perfect fruit.',
      name: 'on_boarding_subtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Start now`
  String get on_boarding_buttom_text {
    return Intl.message(
      'Start now',
      name: 'on_boarding_buttom_text',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get on_Login_login {
    return Intl.message('Login', name: 'on_Login_login', desc: '', args: []);
  }

  /// `Email`
  String get on_Login_email {
    return Intl.message('Email', name: 'on_Login_email', desc: '', args: []);
  }

  /// `Password`
  String get on_Login_password {
    return Intl.message(
      'Password',
      name: 'on_Login_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get on_Login_forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'on_Login_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get on_Login_create_account {
    return Intl.message(
      'Create Account',
      name: 'on_Login_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get on_Login_create_account_text {
    return Intl.message(
      'Don\'t have an account?',
      name: 'on_Login_create_account_text',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get on_Login_login_or_divider {
    return Intl.message(
      'or',
      name: 'on_Login_login_or_divider',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get on_Login_login_with_google {
    return Intl.message(
      'Login with Google',
      name: 'on_Login_login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get on_Login_login_with_facebook {
    return Intl.message(
      'Login with Facebook',
      name: 'on_Login_login_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Login with Apple`
  String get on_Login_login_with_apple {
    return Intl.message(
      'Login with Apple',
      name: 'on_Login_login_with_apple',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get on_signup_Signup {
    return Intl.message(
      'Sign Up',
      name: 'on_signup_Signup',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get on_signup_name {
    return Intl.message('Name', name: 'on_signup_name', desc: '', args: []);
  }

  /// `Email`
  String get on_signup_email {
    return Intl.message('Email', name: 'on_signup_email', desc: '', args: []);
  }

  /// `Password`
  String get on_signup_password {
    return Intl.message(
      'Password',
      name: 'on_signup_password',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you agree to `
  String get on_signup_TermsandConditions {
    return Intl.message(
      'By creating an account, you agree to ',
      name: 'on_signup_TermsandConditions',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get on_signup_TermsandConditions_text {
    return Intl.message(
      'Terms and Conditions',
      name: 'on_signup_TermsandConditions_text',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get on_signup_TermsandConditions_text2 {
    return Intl.message(
      'and',
      name: 'on_signup_TermsandConditions_text2',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get on_signup_TermsandConditions_text3 {
    return Intl.message(
      'Privacy Policy',
      name: 'on_signup_TermsandConditions_text3',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the Terms and Conditions and Privacy Policy`
  String get on_signup_TermsandConditions_error_bar {
    return Intl.message(
      'Please accept the Terms and Conditions and Privacy Policy',
      name: 'on_signup_TermsandConditions_error_bar',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get on_signup_create_NewAccount {
    return Intl.message(
      'Create New Account',
      name: 'on_signup_create_NewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get on_signup_create_NewAccount_text {
    return Intl.message(
      'Already have an account?',
      name: 'on_signup_create_NewAccount_text',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get on_signup_create_NewAccount_text2 {
    return Intl.message(
      'Login',
      name: 'on_signup_create_NewAccount_text2',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields`
  String get on_signup_Text_feils {
    return Intl.message(
      'Please fill in all fields',
      name: 'on_signup_Text_feils',
      desc: '',
      args: [],
    );
  }

  /// ` Top Selling`
  String get top_selling {
    return Intl.message(
      ' Top Selling',
      name: 'top_selling',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get Products_view_title {
    return Intl.message(
      'Products',
      name: 'Products_view_title',
      desc: '',
      args: [],
    );
  }

  /// `Product added to cart`
  String get product_added_to_cart {
    return Intl.message(
      'Product added to cart',
      name: 'product_added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Product removed from cart`
  String get product_removed_from_cart {
    return Intl.message(
      'Product removed from cart',
      name: 'product_removed_from_cart',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get Custom_Exception_weak_password {
    return Intl.message(
      'The password provided is too weak.',
      name: 'Custom_Exception_weak_password',
      desc: '',
      args: [],
    );
  }

  /// `The email address is already in use by another account.`
  String get Custom_Exception_email_already_in_use {
    return Intl.message(
      'The email address is already in use by another account.',
      name: 'Custom_Exception_email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred please try again later.`
  String get Custom_Exception_unknown {
    return Intl.message(
      'An unknown error occurred please try again later.',
      name: 'Custom_Exception_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Network request failed, please check your internet connection.`
  String get Custom_Exception_network_request_failed {
    return Intl.message(
      'Network request failed, please check your internet connection.',
      name: 'Custom_Exception_network_request_failed',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid.`
  String get Custom_Exception_invalid_email {
    return Intl.message(
      'The email address is not valid.',
      name: 'Custom_Exception_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `There is a problem in email or password`
  String get Custom_Exception_there_is_problem_in_email_or_password {
    return Intl.message(
      'There is a problem in email or password',
      name: 'Custom_Exception_there_is_problem_in_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get product`
  String get Custom_Exception_failed_toget_product {
    return Intl.message(
      'Failed to get product',
      name: 'Custom_Exception_failed_toget_product',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning !..`
  String get Home_view_welcome_appbar {
    return Intl.message(
      'Good Morning !..',
      name: 'Home_view_welcome_appbar',
      desc: '',
      args: [],
    );
  }

  /// `Search for.......`
  String get Home_view_search_text_feild {
    return Intl.message(
      'Search for.......',
      name: 'Home_view_search_text_feild',
      desc: '',
      args: [],
    );
  }

  /// `Eid Offers`
  String get Home_view_feature_home_item_first_text {
    return Intl.message(
      'Eid Offers',
      name: 'Home_view_feature_home_item_first_text',
      desc: '',
      args: [],
    );
  }

  /// `25% Discount`
  String get Home_view_feature_home_item_second_text {
    return Intl.message(
      '25% Discount',
      name: 'Home_view_feature_home_item_second_text',
      desc: '',
      args: [],
    );
  }

  /// `Shop Now`
  String get Home_view_feature_home_item_third_text {
    return Intl.message(
      'Shop Now',
      name: 'Home_view_feature_home_item_third_text',
      desc: '',
      args: [],
    );
  }

  /// `Best Selling`
  String get Home_Best_Seller_Header {
    return Intl.message(
      'Best Selling',
      name: 'Home_Best_Seller_Header',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get Home_Best_Seller_Header_subtitle {
    return Intl.message(
      'More',
      name: 'Home_Best_Seller_Header_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Watermelon`
  String get Frute_first_item {
    return Intl.message(
      'Watermelon',
      name: 'Frute_first_item',
      desc: '',
      args: [],
    );
  }

  /// `20 EGP`
  String get Frute_first_item_price {
    return Intl.message(
      '20 EGP',
      name: 'Frute_first_item_price',
      desc: '',
      args: [],
    );
  }

  /// `1kg`
  String get Frute_first_item_weight {
    return Intl.message(
      '1kg',
      name: 'Frute_first_item_weight',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Button_NavigationBar_Entity_Home {
    return Intl.message(
      'Home',
      name: 'Button_NavigationBar_Entity_Home',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get Button_NavigationBar_Entity_Cart {
    return Intl.message(
      'Cart',
      name: 'Button_NavigationBar_Entity_Cart',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Button_NavigationBar_Entity_Profile {
    return Intl.message(
      'Profile',
      name: 'Button_NavigationBar_Entity_Profile',
      desc: '',
      args: [],
    );
  }

  /// `products`
  String get Button_NavigationBar_Entity_Products {
    return Intl.message(
      'products',
      name: 'Button_NavigationBar_Entity_Products',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get ProfileViewLanguage {
    return Intl.message(
      'Language',
      name: 'ProfileViewLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Profile Image`
  String get ProfileViewProfileImage {
    return Intl.message(
      'Profile Image',
      name: 'ProfileViewProfileImage',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get ProfileViewProfileImage_value {
    return Intl.message(
      'Avatar',
      name: 'ProfileViewProfileImage_value',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Language`
  String get ProfileViewLanguage_value_Item {
    return Intl.message(
      'Arabic Language',
      name: 'ProfileViewLanguage_value_Item',
      desc: '',
      args: [],
    );
  }

  /// `English Language`
  String get ProfileViewLanguage_value_Item2 {
    return Intl.message(
      'English Language',
      name: 'ProfileViewLanguage_value_Item2',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get ProfileViewLanguage_value {
    return Intl.message(
      'English',
      name: 'ProfileViewLanguage_value',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get CartViewHeader {
    return Intl.message('Cart', name: 'CartViewHeader', desc: '', args: []);
  }

  /// `Checkout`
  String get CheckOutView_title {
    return Intl.message(
      'Checkout',
      name: 'CheckOutView_title',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get CheckOutView_address {
    return Intl.message(
      'Address',
      name: 'CheckOutView_address',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get CheckOutView_payment {
    return Intl.message(
      'Payment',
      name: 'CheckOutView_payment',
      desc: '',
      args: [],
    );
  }

  /// `Recheck`
  String get CheckOutView_recheck {
    return Intl.message(
      'Recheck',
      name: 'CheckOutView_recheck',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get CheckOutView_Next {
    return Intl.message('Next', name: 'CheckOutView_Next', desc: '', args: []);
  }

  /// `Pay with PayPal`
  String get CheckOutView_PayWithPayPal {
    return Intl.message(
      'Pay with PayPal',
      name: 'CheckOutView_PayWithPayPal',
      desc: '',
      args: [],
    );
  }

  /// `Cash On Delivery`
  String get CheckOutView_Shipinng_title1 {
    return Intl.message(
      'Cash On Delivery',
      name: 'CheckOutView_Shipinng_title1',
      desc: '',
      args: [],
    );
  }

  /// `Delivery From Location`
  String get CheckOutView_Shipinng_Subtitle1 {
    return Intl.message(
      'Delivery From Location',
      name: 'CheckOutView_Shipinng_Subtitle1',
      desc: '',
      args: [],
    );
  }

  /// `Online Payment`
  String get CheckOutView_Shipinng_title2 {
    return Intl.message(
      'Online Payment',
      name: 'CheckOutView_Shipinng_title2',
      desc: '',
      args: [],
    );
  }

  /// ` EGP`
  String get CheckOutView_Shipinng_price {
    return Intl.message(
      ' EGP',
      name: 'CheckOutView_Shipinng_price',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Payment Method`
  String get CheckOutView_Shipinng_Error {
    return Intl.message(
      'Please Select Payment Method',
      name: 'CheckOutView_Shipinng_Error',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get CheckOutView_Shipinng_Subtitle2 {
    return Intl.message(
      'Select Payment Method',
      name: 'CheckOutView_Shipinng_Subtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary :`
  String get OrderSummaryWidget_title {
    return Intl.message(
      'Order Summary :',
      name: 'OrderSummaryWidget_title',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal :`
  String get OrderSummaryWidget_subtotal {
    return Intl.message(
      'Subtotal :',
      name: 'OrderSummaryWidget_subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Shipping :`
  String get OrderSummaryWidget_shipping {
    return Intl.message(
      'Shipping :',
      name: 'OrderSummaryWidget_shipping',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get OrderSummaryWidget_total {
    return Intl.message(
      'Total',
      name: 'OrderSummaryWidget_total',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address :`
  String get AddressSummaryWidget_title {
    return Intl.message(
      'Delivery Address :',
      name: 'AddressSummaryWidget_title',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get AddressSummaryWidget_change {
    return Intl.message(
      'Change',
      name: 'AddressSummaryWidget_change',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get AddressInputSection_name {
    return Intl.message(
      'Full Name',
      name: 'AddressInputSection_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get AddressInputSection_email {
    return Intl.message(
      'Email',
      name: 'AddressInputSection_email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get AddressInputSection_phone {
    return Intl.message(
      'Phone Number',
      name: 'AddressInputSection_phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get AddressInputSection_address {
    return Intl.message(
      'Address',
      name: 'AddressInputSection_address',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get AddressInputSection_city {
    return Intl.message(
      'City',
      name: 'AddressInputSection_city',
      desc: '',
      args: [],
    );
  }

  /// `Floor Number , Apartment Number ..`
  String get AddressInputSection_floor {
    return Intl.message(
      'Floor Number , Apartment Number ..',
      name: 'AddressInputSection_floor',
      desc: '',
      args: [],
    );
  }

  /// `Order Placed Successfully`
  String get OrderCubitBlocConsumer {
    return Intl.message(
      'Order Placed Successfully',
      name: 'OrderCubitBlocConsumer',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get NotificationHeader_appbar {
    return Intl.message(
      'Notifications',
      name: 'NotificationHeader_appbar',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get NotificationHeader_new {
    return Intl.message(
      'New',
      name: 'NotificationHeader_new',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get NotificationHeader_viewAll {
    return Intl.message(
      'View All',
      name: 'NotificationHeader_viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get ProfileViewFavourites {
    return Intl.message(
      'Favourites',
      name: 'ProfileViewFavourites',
      desc: '',
      args: [],
    );
  }

  /// `No favorites yet`
  String get ProfileViewFavouritesBody1 {
    return Intl.message(
      'No favorites yet',
      name: 'ProfileViewFavouritesBody1',
      desc: '',
      args: [],
    );
  }

  /// `Tap the heart icon on any product to add it to your favorites`
  String get ProfileViewFavouritesBody2 {
    return Intl.message(
      'Tap the heart icon on any product to add it to your favorites',
      name: 'ProfileViewFavouritesBody2',
      desc: '',
      args: [],
    );
  }

  /// `Copon View`
  String get coponView {
    return Intl.message('Copon View', name: 'coponView', desc: '', args: []);
  }

  /// `Copon Discount : `
  String get CoponView_title3 {
    return Intl.message(
      'Copon Discount : ',
      name: 'CoponView_title3',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get ProfileViewLogout {
    return Intl.message(
      'Logout',
      name: 'ProfileViewLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get ProfileViewLogout_text {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'ProfileViewLogout_text',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get ProfileViewLogout_text2 {
    return Intl.message(
      'Logout',
      name: 'ProfileViewLogout_text2',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get ProfileViewLogout_text3 {
    return Intl.message(
      'Cancel',
      name: 'ProfileViewLogout_text3',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
