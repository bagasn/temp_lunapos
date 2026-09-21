import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/shared/utilities/log_util.dart';

@singleton
class PrevillageService {
  final SessionManager session;
  final AppDatabaseManager databaseManager;

  Users? _currentUser;

  PrevillageService({required this.session, required this.databaseManager});

  Future<bool> haveAccess(UserPrevillage previllage) async {
    final userId = await session.posUser.getUserId();
    if (userId == null) return false;

    final database = await databaseManager.mainDb;
    if (database == null) return false;

    if (_currentUser != null && _currentUser?.id == userId) {
      return _checkAccess(_currentUser!, previllage);
    }

    try {
      final query = database.tableUser.select()
        ..where((user) => user.id.equals(userId));

      final result = await query.getSingle();
      _currentUser = result;

      return _checkAccess(result, previllage);
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), error: error, stackTrace: stackTrace);
      return false;
    }
  }

  bool _checkAccess(Users user, UserPrevillage previllage) {
    switch (previllage) {
      case UserPrevillage.pay:
        return user.permissionPay;
      case UserPrevillage.edit:
        return user.permissionEdit;
      case UserPrevillage.voidOrder:
        return user.permissionVoidOrder;
      case UserPrevillage.voidItem:
        return user.permissionVoidItem;
      case UserPrevillage.discount:
        return user.permissionDiscount;
      case UserPrevillage.report:
        return user.permissionReport;
      case UserPrevillage.customPrice:
        return user.permissionCustomPrice;
      case UserPrevillage.customItem:
        return user.permissionCustomItem;
      case UserPrevillage.admin:
        return user.permissionAdmin;
      case UserPrevillage.printBill:
        return user.permissionPrintBill;
      case UserPrevillage.seeAllUserTransactions:
        return user.permissionSeeAllUserTransactions;
    }
  }
}

enum UserPrevillage {
  pay,
  edit,
  voidOrder,
  voidItem,
  discount,
  report,
  customPrice,
  customItem,
  admin,
  printBill,
  seeAllUserTransactions,
}
