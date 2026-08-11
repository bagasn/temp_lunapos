// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Luna POS';

  @override
  String get txt_welcomeToLuna => 'Selamat Datang Sahabat LUNA!';

  @override
  String get txt_login => 'Masuk';

  @override
  String get txt_email => 'Email';

  @override
  String get hint_email => 'Cth: joe@mail.com';

  @override
  String get txt_password => 'Kata Sandi';

  @override
  String get hint_inputPassword => 'Masukkan kata sandi';

  @override
  String get lbl_authenticationKey => 'Authentication Key';

  @override
  String get btn_forgetPassword => 'Lupa Password?';

  @override
  String get lbl_notHaveAccountYet => 'Belum punya Akun?';

  @override
  String get btn_createAnAccount => 'Buat Akun Sekarang!';

  @override
  String get btn_needHelp => 'Butuh Bantuan?';

  @override
  String get btn_client => 'Client';

  @override
  String get txt_lunaBrandMoto => 'Satu Aplikasi Kasir untuk Semua Jenis Usaha';

  @override
  String get txt_lunaHashtag => '#UntungadaLUNA';

  @override
  String get copyright =>
      '© 2022 - PT LUNA Aplikasi Indonesia. All rights reserved.';

  @override
  String get title_chooseOutlet => 'PILIH OUTLET';

  @override
  String get hint_findOutlet => 'Cari Outlet';

  @override
  String get txt_logout => 'Keluar';

  @override
  String get txt_logoutConfirmation => 'Anda akan keluar. Lanjutkan?';

  @override
  String get err_outletNotFound => 'Outlet tidak ditemukan';
}
