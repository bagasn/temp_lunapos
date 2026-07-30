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
  String get selamatDatangSahabatLuna;

  /// Sign in button label
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get masuk;

  /// Email field label
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get email;

  /// Email placeholder
  ///
  /// In id, this message translates to:
  /// **'Cth: joe@mail.com'**
  String get cthEmail;

  /// Password field label
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get kataSandi;

  /// Password placeholder
  ///
  /// In id, this message translates to:
  /// **'Masukkan kata sandi'**
  String get masukkanKataSandi;

  /// Auth key toggle label
  ///
  /// In id, this message translates to:
  /// **'Authentication Key'**
  String get authenticationKey;

  /// Forgot password link
  ///
  /// In id, this message translates to:
  /// **'Lupa Password?'**
  String get lupaPassword;

  /// No account label
  ///
  /// In id, this message translates to:
  /// **'Belum punya Akun?'**
  String get belumPunyaAkun;

  /// Create account button
  ///
  /// In id, this message translates to:
  /// **'Buat Akun Sekarang!'**
  String get buatAkunSekarang;

  /// Need help button
  ///
  /// In id, this message translates to:
  /// **'Butuh Bantuan?'**
  String get butuhBantuan;

  /// Client mode button
  ///
  /// In id, this message translates to:
  /// **'Client'**
  String get client;

  /// App tagline
  ///
  /// In id, this message translates to:
  /// **'Satu Aplikasi Kasir untuk Semua Jenis Usaha'**
  String get satuAplikasiKasir;

  /// Brand hashtag
  ///
  /// In id, this message translates to:
  /// **'#UntungadaLUNA'**
  String get untungadaLuna;

  /// Copyright text
  ///
  /// In id, this message translates to:
  /// **'© 2022 - PT LUNA Aplikasi Indonesia. All rights reserved.'**
  String get copyright;

  /// Select outlet title
  ///
  /// In id, this message translates to:
  /// **'PILIH OUTLET'**
  String get pilihOutlet;

  /// Search outlet placeholder
  ///
  /// In id, this message translates to:
  /// **'Cari Outlet'**
  String get cariOutlet;

  /// Log out button
  ///
  /// In id, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// Logout confirmation message
  ///
  /// In id, this message translates to:
  /// **'Anda akan keluar. Lanjutkan?'**
  String get konfirmasiLogout;

  /// No outlet found message
  ///
  /// In id, this message translates to:
  /// **'Outlet tidak ditemukan'**
  String get outletTidakDitemukan;

  /// Order list title
  ///
  /// In id, this message translates to:
  /// **'Daftar Order'**
  String get daftarOrder;

  /// Sales type label
  ///
  /// In id, this message translates to:
  /// **'Tipe Penjualan'**
  String get tipePenjualan;

  /// All category filter
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get semua;

  /// Favorites category filter
  ///
  /// In id, this message translates to:
  /// **'Favorit'**
  String get favorit;

  /// Promo & Discount category filter
  ///
  /// In id, this message translates to:
  /// **'Promo & Diskon'**
  String get promoDiskon;

  /// Print bill button
  ///
  /// In id, this message translates to:
  /// **'Print Tagihan'**
  String get printTagihan;

  /// Save button
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get simpan;

  /// Pay button
  ///
  /// In id, this message translates to:
  /// **'Bayar'**
  String get bayar;

  /// Delete button
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get hapus;

  /// Discount label
  ///
  /// In id, this message translates to:
  /// **'Diskon'**
  String get diskon;

  /// Notes label
  ///
  /// In id, this message translates to:
  /// **'Catatan'**
  String get catatan;

  /// Total label
  ///
  /// In id, this message translates to:
  /// **'Total'**
  String get total;

  /// Total with item count
  ///
  /// In id, this message translates to:
  /// **'Total ({count} items)'**
  String totalItem(int count);

  /// Remaining stock label
  ///
  /// In id, this message translates to:
  /// **'Sisa Stok: {count} Pcs'**
  String sisaStok(int count);

  /// Out of stock label
  ///
  /// In id, this message translates to:
  /// **'STOK HABIS'**
  String get stokHabis;

  /// Product search placeholder
  ///
  /// In id, this message translates to:
  /// **'Cari Nama/SKU Produk'**
  String get cariNamaSKUProduk;

  /// Syncing data message
  ///
  /// In id, this message translates to:
  /// **'Sinkronisasi Data...'**
  String get sinkronisasiData;

  /// Sync complete message
  ///
  /// In id, this message translates to:
  /// **'Sinkronisasi selesai'**
  String get sinkronisasiSelesai;

  /// Sync failed message
  ///
  /// In id, this message translates to:
  /// **'Gagal sinkronisasi. Coba lagi.'**
  String get gagalSinkronisasi;

  /// Yes
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get ya;

  /// Cancel
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get batal;

  /// Continue
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan'**
  String get lanjutkan;

  /// Invalid credential error
  ///
  /// In id, this message translates to:
  /// **'Email atau password tidak valid'**
  String get emailAtauPasswordTidakValid;

  /// Generic error message
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan. Silakan coba lagi.'**
  String get terjadi_kesalahan;
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
