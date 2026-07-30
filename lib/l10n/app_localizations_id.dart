// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Luna POS';

  @override
  String get selamatDatangSahabatLuna => 'Selamat Datang Sahabat LUNA!';

  @override
  String get masuk => 'Masuk';

  @override
  String get email => 'Email';

  @override
  String get cthEmail => 'Cth: joe@mail.com';

  @override
  String get kataSandi => 'Kata Sandi';

  @override
  String get masukkanKataSandi => 'Masukkan kata sandi';

  @override
  String get authenticationKey => 'Authentication Key';

  @override
  String get lupaPassword => 'Lupa Password?';

  @override
  String get belumPunyaAkun => 'Belum punya Akun?';

  @override
  String get buatAkunSekarang => 'Buat Akun Sekarang!';

  @override
  String get butuhBantuan => 'Butuh Bantuan?';

  @override
  String get client => 'Client';

  @override
  String get satuAplikasiKasir => 'Satu Aplikasi Kasir untuk Semua Jenis Usaha';

  @override
  String get untungadaLuna => '#UntungadaLUNA';

  @override
  String get copyright =>
      '© 2022 - PT LUNA Aplikasi Indonesia. All rights reserved.';

  @override
  String get pilihOutlet => 'PILIH OUTLET';

  @override
  String get cariOutlet => 'Cari Outlet';

  @override
  String get logOut => 'Log Out';

  @override
  String get konfirmasiLogout => 'Anda akan keluar. Lanjutkan?';

  @override
  String get outletTidakDitemukan => 'Outlet tidak ditemukan';

  @override
  String get daftarOrder => 'Daftar Order';

  @override
  String get tipePenjualan => 'Tipe Penjualan';

  @override
  String get semua => 'Semua';

  @override
  String get favorit => 'Favorit';

  @override
  String get promoDiskon => 'Promo & Diskon';

  @override
  String get printTagihan => 'Print Tagihan';

  @override
  String get simpan => 'Simpan';

  @override
  String get bayar => 'Bayar';

  @override
  String get hapus => 'Hapus';

  @override
  String get diskon => 'Diskon';

  @override
  String get catatan => 'Catatan';

  @override
  String get total => 'Total';

  @override
  String totalItem(int count) {
    return 'Total ($count items)';
  }

  @override
  String sisaStok(int count) {
    return 'Sisa Stok: $count Pcs';
  }

  @override
  String get stokHabis => 'STOK HABIS';

  @override
  String get cariNamaSKUProduk => 'Cari Nama/SKU Produk';

  @override
  String get sinkronisasiData => 'Sinkronisasi Data...';

  @override
  String get sinkronisasiSelesai => 'Sinkronisasi selesai';

  @override
  String get gagalSinkronisasi => 'Gagal sinkronisasi. Coba lagi.';

  @override
  String get ya => 'Ya';

  @override
  String get batal => 'Batal';

  @override
  String get lanjutkan => 'Lanjutkan';

  @override
  String get emailAtauPasswordTidakValid => 'Email atau password tidak valid';

  @override
  String get terjadi_kesalahan => 'Terjadi kesalahan. Silakan coba lagi.';
}
