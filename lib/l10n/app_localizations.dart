import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
    Locale('en'),
    Locale('id'),
  ];

  /// Application name
  ///
  /// In id, this message translates to:
  /// **'Luna POS'**
  String get appName;

  /// Welcome greeting on login
  ///
  /// In id, this message translates to:
  /// **'Selamat Datang Sahabat LUNA!'**
  String get txt_welcomeToLuna;

  /// Sign in button label
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get txt_login;

  /// Email field label
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get txt_email;

  /// Email placeholder
  ///
  /// In id, this message translates to:
  /// **'Cth: joe@mail.com'**
  String get hint_email;

  /// Password field label
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get txt_password;

  /// Password placeholder
  ///
  /// In id, this message translates to:
  /// **'Masukkan kata sandi'**
  String get hint_inputPassword;

  /// Auth key toggle label
  ///
  /// In id, this message translates to:
  /// **'Authentication Key'**
  String get lbl_authenticationKey;

  /// Forgot password Button
  ///
  /// In id, this message translates to:
  /// **'Lupa Password?'**
  String get btn_forgetPassword;

  /// No account label
  ///
  /// In id, this message translates to:
  /// **'Belum punya Akun?'**
  String get lbl_notHaveAccountYet;

  /// Create account button
  ///
  /// In id, this message translates to:
  /// **'Buat Akun Sekarang!'**
  String get btn_createAnAccount;

  /// Need help button
  ///
  /// In id, this message translates to:
  /// **'Butuh Bantuan?'**
  String get btn_needHelp;

  /// Client mode button
  ///
  /// In id, this message translates to:
  /// **'Client'**
  String get btn_client;

  /// App tagline
  ///
  /// In id, this message translates to:
  /// **'Satu Aplikasi Kasir untuk Semua Jenis Usaha'**
  String get txt_lunaBrandMoto;

  /// Brand hashtag
  ///
  /// In id, this message translates to:
  /// **'#UntungadaLUNA'**
  String get txt_lunaHashtag;

  /// Copyright text
  ///
  /// In id, this message translates to:
  /// **'© 2022 - PT LUNA Aplikasi Indonesia. All rights reserved.'**
  String get copyright;

  /// Select outlet title
  ///
  /// In id, this message translates to:
  /// **'PILIH OUTLET'**
  String get title_chooseOutlet;

  /// Search outlet placeholder
  ///
  /// In id, this message translates to:
  /// **'Cari Outlet'**
  String get hint_findOutlet;

  /// Log out button
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get txt_logout;

  /// Logout confirmation message
  ///
  /// In id, this message translates to:
  /// **'Anda akan keluar. Lanjutkan?'**
  String get txt_logoutConfirmation;

  /// No outlet found message
  ///
  /// In id, this message translates to:
  /// **'Outlet tidak ditemukan'**
  String get err_outletNotFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
