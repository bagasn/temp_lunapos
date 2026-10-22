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

  /// Exit button label
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get btn_exit;

  /// Settings sidebar - General menu item
  ///
  /// In id, this message translates to:
  /// **'General'**
  String get lbl_settingGeneral;

  /// Settings sidebar - Order menu item
  ///
  /// In id, this message translates to:
  /// **'Order'**
  String get lbl_settingOrder;

  /// Settings sidebar - Template menu item
  ///
  /// In id, this message translates to:
  /// **'Template'**
  String get lbl_settingTemplate;

  /// Settings sidebar - Printer menu item
  ///
  /// In id, this message translates to:
  /// **'Printer'**
  String get lbl_settingPrinter;

  /// Settings sidebar - System menu item
  ///
  /// In id, this message translates to:
  /// **'System'**
  String get lbl_settingSystem;

  /// Settings sidebar - Account menu item
  ///
  /// In id, this message translates to:
  /// **'Account'**
  String get lbl_settingAccount;

  /// Settings sidebar - Scanner menu item
  ///
  /// In id, this message translates to:
  /// **'Scanner'**
  String get lbl_settingScanner;

  /// Settings sidebar - Dual Display menu item
  ///
  /// In id, this message translates to:
  /// **'Dual Display'**
  String get lbl_settingDualDisplay;

  /// General settings section title
  ///
  /// In id, this message translates to:
  /// **'General Settings'**
  String get title_settingGeneral;

  /// Order settings section title
  ///
  /// In id, this message translates to:
  /// **'Order settings'**
  String get title_settingOrder;

  /// Template settings section title
  ///
  /// In id, this message translates to:
  /// **'Template settings'**
  String get title_settingTemplate;

  /// Printer settings section title
  ///
  /// In id, this message translates to:
  /// **'Printer settings'**
  String get title_settingPrinter;

  /// System settings section title
  ///
  /// In id, this message translates to:
  /// **'System settings'**
  String get title_settingSystem;

  /// Account settings section title
  ///
  /// In id, this message translates to:
  /// **'Account Settings'**
  String get title_settingAccount;

  /// Scanner settings section title
  ///
  /// In id, this message translates to:
  /// **'Scanner settings'**
  String get title_settingScanner;

  /// Dual Display settings section title
  ///
  /// In id, this message translates to:
  /// **'Dual Display'**
  String get title_settingDualDisplay;

  /// App lock checkbox label in General settings
  ///
  /// In id, this message translates to:
  /// **'App lock (After 5 minutes of inactivity)'**
  String get lbl_settingAppLock;

  /// App lock description in General settings
  ///
  /// In id, this message translates to:
  /// **'* Aplikasi akan terkunci jika tidak ada aktivitas selama 5 menit. (Restart diperlukan)'**
  String get desc_settingAppLock;

  /// Select language label in General settings
  ///
  /// In id, this message translates to:
  /// **'Select Language'**
  String get lbl_settingSelectLanguage;

  /// Default view dropdown label in Order settings
  ///
  /// In id, this message translates to:
  /// **'Default View'**
  String get lbl_settingDefaultView;

  /// Customer required checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Customer Required'**
  String get lbl_settingCustomerRequired;

  /// Shift session required checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Shift Session Required Before Creating Order'**
  String get lbl_settingShiftSessionRequired;

  /// Show cash detail checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Show Cash Detail When Ending Shift'**
  String get lbl_settingShowCashDetail;

  /// Round order total checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Round Order Total'**
  String get lbl_settingRoundOrderTotal;

  /// Queue numbering checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Queue Numbering'**
  String get lbl_settingQueueNumbering;

  /// Add custom notes checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Add Custom Notes'**
  String get lbl_settingAddCustomNotes;

  /// Print kitchen separately checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Print Kitchen Printer Separately'**
  String get lbl_settingPrintKitchenSeparately;

  /// Sync open order checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Sync Open Order'**
  String get lbl_settingSyncOpenOrder;

  /// Cash payment checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Cash Payment'**
  String get lbl_settingCashPayment;

  /// Allow saving orders checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Allow Saving Orders'**
  String get lbl_settingAllowSavingOrders;

  /// Ending shift not allowed checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Ending Shift Is Not Allowed with Active Orders'**
  String get lbl_settingEndingShiftNotAllowed;

  /// Table selection required checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Table Selection Required'**
  String get lbl_settingTableSelectionRequired;

  /// Show stock checkbox in Order settings
  ///
  /// In id, this message translates to:
  /// **'Tampilkan Stok'**
  String get lbl_settingShowStock;

  /// Bill sub-header in Template settings
  ///
  /// In id, this message translates to:
  /// **'Bill'**
  String get lbl_settingBill;

  /// Receipt sub-header in Template settings
  ///
  /// In id, this message translates to:
  /// **'Receipt'**
  String get lbl_settingReceipt;

  /// Logo checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Logo'**
  String get lbl_settingLogo;

  /// Order number checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Order Number'**
  String get lbl_settingOrderNumber;

  /// Order date checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Order Date'**
  String get lbl_settingOrderDate;

  /// Address checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Address'**
  String get lbl_settingAddress;

  /// Cashier and user checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Cashier and User'**
  String get lbl_settingCashierAndUser;

  /// Adjusment amount checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Adjusment Amount'**
  String get lbl_settingAdjusmentAmount;

  /// Tax checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Tax'**
  String get lbl_settingTax;

  /// Service charge checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Service Charge'**
  String get lbl_settingServiceCharge;

  /// Product unit price checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Product Unit Price'**
  String get lbl_settingProductUnitPrice;

  /// Modifier unit price checkbox in Template settings
  ///
  /// In id, this message translates to:
  /// **'Modifier Unit Price'**
  String get lbl_settingModifierUnitPrice;

  /// Main printer row label in Printer settings
  ///
  /// In id, this message translates to:
  /// **'Main'**
  String get lbl_settingPrinterMain;

  /// Captain order printer row label in Printer settings
  ///
  /// In id, this message translates to:
  /// **'Captain Order'**
  String get lbl_settingPrinterCaptainOrder;

  /// Label printer row label in Printer settings
  ///
  /// In id, this message translates to:
  /// **'Label'**
  String get lbl_settingPrinterLabel;

  /// Test print button in Printer settings
  ///
  /// In id, this message translates to:
  /// **'Test Print'**
  String get btn_settingTestPrint;

  /// Add printer area button in Printer settings
  ///
  /// In id, this message translates to:
  /// **'Add Printer Area'**
  String get btn_settingAddPrinterArea;

  /// Outlet label in System settings
  ///
  /// In id, this message translates to:
  /// **'Outlet'**
  String get lbl_settingOutlet;

  /// Change outlet button in System settings
  ///
  /// In id, this message translates to:
  /// **'Change outlet'**
  String get btn_settingChangeOutlet;

  /// Connection mode label in System settings
  ///
  /// In id, this message translates to:
  /// **'Connection mode'**
  String get lbl_settingConnectionMode;

  /// Switch to client button in System settings
  ///
  /// In id, this message translates to:
  /// **'Switch to Client'**
  String get btn_settingSwitchToClient;

  /// Sync label in System settings
  ///
  /// In id, this message translates to:
  /// **'Sync'**
  String get lbl_settingSync;

  /// Last synchronized label in System settings
  ///
  /// In id, this message translates to:
  /// **'Last synchronized:'**
  String get lbl_settingLastSynchronized;

  /// Sync button in System settings
  ///
  /// In id, this message translates to:
  /// **'Sync'**
  String get btn_settingSync;

  /// Backup and restore label in System settings
  ///
  /// In id, this message translates to:
  /// **'Backup & Restore'**
  String get lbl_settingBackupRestore;

  /// Backup data label in System settings
  ///
  /// In id, this message translates to:
  /// **'Backup Data'**
  String get lbl_settingBackupData;

  /// Backup data offline button in System settings
  ///
  /// In id, this message translates to:
  /// **'Backup Data Offline'**
  String get btn_settingBackupDataOffline;

  /// Restore data label in System settings
  ///
  /// In id, this message translates to:
  /// **'Restore Data'**
  String get lbl_settingRestoreData;

  /// Restore data button in System settings
  ///
  /// In id, this message translates to:
  /// **'Restore Data'**
  String get btn_settingRestoreData;

  /// IP address label in System settings
  ///
  /// In id, this message translates to:
  /// **'IP Address'**
  String get lbl_settingIpAddress;

  /// Name label in Account settings
  ///
  /// In id, this message translates to:
  /// **'Name'**
  String get lbl_settingName;

  /// Change pin button in Account settings
  ///
  /// In id, this message translates to:
  /// **'Change Pin'**
  String get btn_settingChangePin;

  /// HID scanner mode in Scanner settings
  ///
  /// In id, this message translates to:
  /// **'HID'**
  String get lbl_settingScannerHid;

  /// SPP scanner mode in Scanner settings
  ///
  /// In id, this message translates to:
  /// **'SPP'**
  String get lbl_settingScannerSpp;

  /// Activate dual display toggle label in Dual Display settings
  ///
  /// In id, this message translates to:
  /// **'Activate Dual Display'**
  String get lbl_settingActivateDualDisplay;

  /// Customer display label in Dual Display settings
  ///
  /// In id, this message translates to:
  /// **'Customer Display'**
  String get lbl_settingCustomerDisplay;

  /// Generic save button
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get btn_save;

  /// Rounding type dropdown label in Order settings
  ///
  /// In id, this message translates to:
  /// **'Tipe Pembulatan'**
  String get lbl_settingRoundingType;

  /// Rounding type option: round up (0)
  ///
  /// In id, this message translates to:
  /// **'Pembulatan Keatas'**
  String get lbl_settingRoundingUp;

  /// Rounding type option: round down (1)
  ///
  /// In id, this message translates to:
  /// **'Pembulatan Kebawah'**
  String get lbl_settingRoundingDown;

  /// Rounding type option: round to nearest (2)
  ///
  /// In id, this message translates to:
  /// **'Pembulatan Terdekat'**
  String get lbl_settingRoundingNearest;

  /// Rounding base value input label in Order settings
  ///
  /// In id, this message translates to:
  /// **'Nilai Pembulatan'**
  String get lbl_settingRoundingBase;

  /// Max queue number input label in Order settings
  ///
  /// In id, this message translates to:
  /// **'Max nomor antrian'**
  String get lbl_settingMaxQueueNumber;

  /// Snackbar message after a setting is saved
  ///
  /// In id, this message translates to:
  /// **'Pengaturan berhasil disimpan'**
  String get msg_settingSaved;

  /// Title of the select printer dialog
  ///
  /// In id, this message translates to:
  /// **'Pilih Printer'**
  String get title_settingSelectPrinter;

  /// Printer type dropdown label
  ///
  /// In id, this message translates to:
  /// **'Tipe Printer'**
  String get lbl_settingPrinterType;

  /// Printer module dropdown label
  ///
  /// In id, this message translates to:
  /// **'Modul Printer'**
  String get lbl_settingPrinterModule;

  /// Printer item dropdown label
  ///
  /// In id, this message translates to:
  /// **'Printer'**
  String get lbl_settingPrinterItem;

  /// Dropdown placeholder
  ///
  /// In id, this message translates to:
  /// **'Pilih item'**
  String get lbl_settingSelectItem;

  /// Paper size dropdown label
  ///
  /// In id, this message translates to:
  /// **'Ukuran Kertas'**
  String get lbl_settingPaperSize;

  /// Feed after print input label
  ///
  /// In id, this message translates to:
  /// **'Feed Setelah Cetak'**
  String get lbl_settingFeedAfterPrint;

  /// Auto cut type dropdown label
  ///
  /// In id, this message translates to:
  /// **'Tipe Auto Cut'**
  String get lbl_settingAutoCutType;

  /// Disconnect after print checkbox
  ///
  /// In id, this message translates to:
  /// **'Putuskan Koneksi Setelah Cetak'**
  String get lbl_settingDisconnectAfterPrint;

  /// Number of copies label
  ///
  /// In id, this message translates to:
  /// **'Jumlah Salinan Main yang dicetak'**
  String get lbl_settingNumberOfCopies;

  /// Auto print receipt checkbox
  ///
  /// In id, this message translates to:
  /// **'Cetak struk otomatis saat pembayaran'**
  String get lbl_settingAutoPrintReceipt;

  /// Generic cancel button
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get btn_cancel;

  /// Generic Yes button
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get btn_yes;

  /// Generic No button
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get btn_no;

  /// Old PIN input label in Change PIN dialog
  ///
  /// In id, this message translates to:
  /// **'PIN Lama'**
  String get lbl_settingOldPin;

  /// New PIN input label in Change PIN dialog
  ///
  /// In id, this message translates to:
  /// **'PIN Baru'**
  String get lbl_settingNewPin;

  /// Confirm new PIN input label in Change PIN dialog
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi PIN Baru'**
  String get lbl_settingConfirmNewPin;

  /// New PIN and confirmation do not match
  ///
  /// In id, this message translates to:
  /// **'PIN tidak sama'**
  String get err_pinNotMatch;

  /// PIN length validation error
  ///
  /// In id, this message translates to:
  /// **'PIN harus 4 digit'**
  String get err_pinLength;

  /// Old PIN does not match the stored PIN
  ///
  /// In id, this message translates to:
  /// **'PIN lama tidak sesuai'**
  String get err_oldPinInvalid;

  /// Active user could not be found
  ///
  /// In id, this message translates to:
  /// **'User tidak ditemukan'**
  String get err_userNotFound;

  /// Message after PIN is changed
  ///
  /// In id, this message translates to:
  /// **'PIN berhasil diubah'**
  String get msg_pinChangedSuccess;

  /// POS order source tab label
  ///
  /// In id, this message translates to:
  /// **'POS'**
  String get lbl_pos;

  /// Online Order source tab label
  ///
  /// In id, this message translates to:
  /// **'Online Order'**
  String get lbl_onlineOrder;

  /// Search order input placeholder
  ///
  /// In id, this message translates to:
  /// **'Cari Order'**
  String get hint_searchOrder;

  /// Date range separator text
  ///
  /// In id, this message translates to:
  /// **'To'**
  String get txt_to;

  /// Order status filter label
  ///
  /// In id, this message translates to:
  /// **'Status'**
  String get lbl_status;

  /// Completed order status filter button
  ///
  /// In id, this message translates to:
  /// **'Completed'**
  String get btn_statusCompleted;

  /// Cancelled order status filter button
  ///
  /// In id, this message translates to:
  /// **'Cancel'**
  String get btn_statusCancel;

  /// Active order status filter button
  ///
  /// In id, this message translates to:
  /// **'Active'**
  String get btn_statusActive;

  /// Reset filter button
  ///
  /// In id, this message translates to:
  /// **'Reset Filter'**
  String get btn_resetFilter;

  /// Order number prefix on transaction card
  ///
  /// In id, this message translates to:
  /// **'NO. ORDER:'**
  String get lbl_orderNoPrefix;

  /// Synced status text
  ///
  /// In id, this message translates to:
  /// **'Synced'**
  String get txt_synced;

  /// Not synced status text
  ///
  /// In id, this message translates to:
  /// **'Not Synced'**
  String get txt_notSynced;

  /// Empty state text when no transactions match filter
  ///
  /// In id, this message translates to:
  /// **'Order tidak ditemukan. Silahkan ubah pencarian anda'**
  String get txt_orderNotFound;

  /// Order date label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Order Date'**
  String get lbl_orderDate;

  /// Closing date label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Closing Date'**
  String get lbl_closingDate;

  /// Queue number label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Queue Number'**
  String get lbl_queueNumber;

  /// Server label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Server'**
  String get lbl_server;

  /// Cashier label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Cashier'**
  String get lbl_cashier;

  /// Table label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Meja'**
  String get lbl_table;

  /// Pax or guests label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Pax/Guests'**
  String get lbl_paxGuests;

  /// Customer label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Customer'**
  String get lbl_customer;

  /// Email label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get lbl_email;

  /// Phone number label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'No. Phone'**
  String get lbl_phoneNumber;

  /// Order type label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Order Type'**
  String get lbl_orderType;

  /// Sales type label in transaction detail
  ///
  /// In id, this message translates to:
  /// **'Sales Type'**
  String get lbl_salesType;

  /// Gift badge label on free promo order line
  ///
  /// In id, this message translates to:
  /// **'Gift'**
  String get lbl_gift;

  /// Payment section title in transaction detail footer
  ///
  /// In id, this message translates to:
  /// **'Payment'**
  String get title_payment;

  /// Total payment label in transaction detail footer
  ///
  /// In id, this message translates to:
  /// **'Total Payment'**
  String get lbl_totalPayment;

  /// Change amount label in transaction detail footer
  ///
  /// In id, this message translates to:
  /// **'Change'**
  String get lbl_change;

  /// Text shown when order has no payment records
  ///
  /// In id, this message translates to:
  /// **'Tidak ada pembayaran'**
  String get txt_noPayment;

  /// Subtotal label in accounting summary
  ///
  /// In id, this message translates to:
  /// **'Subtotal'**
  String get lbl_subtotal;

  /// Discount label in accounting summary
  ///
  /// In id, this message translates to:
  /// **'Discount'**
  String get lbl_discount;

  /// Service charge label in accounting summary
  ///
  /// In id, this message translates to:
  /// **'Svc Charge'**
  String get lbl_serviceCharge;

  /// Tax label in accounting summary
  ///
  /// In id, this message translates to:
  /// **'Tax'**
  String get lbl_tax;

  /// Adjustment label in accounting summary
  ///
  /// In id, this message translates to:
  /// **'Adjustment'**
  String get lbl_adjustment;

  /// Total items label in accounting summary
  ///
  /// In id, this message translates to:
  /// **'Total ({count} items)'**
  String lbl_totalItems(int count);

  /// Button to show transaction log history
  ///
  /// In id, this message translates to:
  /// **'Show History'**
  String get btn_showHistory;

  /// Button to hide transaction log history
  ///
  /// In id, this message translates to:
  /// **'Hide History'**
  String get btn_hideHistory;

  /// Menu option to send PDF receipt
  ///
  /// In id, this message translates to:
  /// **'Kirim Struk PDF'**
  String get btn_sendPdfReceipt;

  /// Button to void or cancel an order
  ///
  /// In id, this message translates to:
  /// **'Batalkan'**
  String get btn_voidOrder;

  /// Button to continue an active open order
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan'**
  String get btn_continueOrder;

  /// Transaction log table header: User Name
  ///
  /// In id, this message translates to:
  /// **'Nama User'**
  String get lbl_logUserName;

  /// Transaction log table header: Date
  ///
  /// In id, this message translates to:
  /// **'Tanggal'**
  String get lbl_logDate;

  /// Transaction log table header: Description
  ///
  /// In id, this message translates to:
  /// **'Deskripsi'**
  String get lbl_logDescription;
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
