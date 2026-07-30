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
  String get selamatDatangSahabatLuna => 'Welcome, LUNA Friend!';

  @override
  String get masuk => 'Sign In';

  @override
  String get email => 'Email';

  @override
  String get cthEmail => 'e.g. joe@mail.com';

  @override
  String get kataSandi => 'Password';

  @override
  String get masukkanKataSandi => 'Enter your password';

  @override
  String get authenticationKey => 'Authentication Key';

  @override
  String get lupaPassword => 'Forgot Password?';

  @override
  String get belumPunyaAkun => 'Don\'t have an account?';

  @override
  String get buatAkunSekarang => 'Create Account Now!';

  @override
  String get butuhBantuan => 'Need Help?';

  @override
  String get client => 'Client';

  @override
  String get satuAplikasiKasir => 'One Cashier App for All Business Types';

  @override
  String get untungadaLuna => '#UntungadaLUNA';

  @override
  String get copyright =>
      '© 2022 - PT LUNA Aplikasi Indonesia. All rights reserved.';

  @override
  String get pilihOutlet => 'SELECT OUTLET';

  @override
  String get cariOutlet => 'Search Outlet';

  @override
  String get logOut => 'Log Out';

  @override
  String get konfirmasiLogout => 'You are about to log out. Continue?';

  @override
  String get outletTidakDitemukan => 'Outlet not found';

  @override
  String get daftarOrder => 'Order List';

  @override
  String get tipePenjualan => 'Sales Type';

  @override
  String get semua => 'All';

  @override
  String get favorit => 'Favorites';

  @override
  String get promoDiskon => 'Promo & Discounts';

  @override
  String get printTagihan => 'Print Bill';

  @override
  String get simpan => 'Save';

  @override
  String get bayar => 'Pay';

  @override
  String get hapus => 'Delete';

  @override
  String get diskon => 'Discount';

  @override
  String get catatan => 'Notes';

  @override
  String get total => 'Total';

  @override
  String totalItem(int count) {
    return 'Total ($count items)';
  }

  @override
  String sisaStok(int count) {
    return 'Stock Left: $count Pcs';
  }

  @override
  String get stokHabis => 'OUT OF STOCK';

  @override
  String get cariNamaSKUProduk => 'Search Product Name/SKU';

  @override
  String get sinkronisasiData => 'Syncing Data...';

  @override
  String get sinkronisasiSelesai => 'Sync complete';

  @override
  String get gagalSinkronisasi => 'Sync failed. Try again.';

  @override
  String get ya => 'Yes';

  @override
  String get batal => 'Cancel';

  @override
  String get lanjutkan => 'Continue';

  @override
  String get emailAtauPasswordTidakValid => 'Email or password is invalid';

  @override
  String get terjadi_kesalahan => 'An error occurred. Please try again.';
}
