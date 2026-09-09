import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/sync/data/datasources/sync_data_service.dart';
import 'package:pos/features/sync/data/models/payload/sync_payload.dart';
import 'package:pos/features/sync/data/models/response/initial_data_product_response.dart';
import 'package:pos/features/sync/data/models/response/initial_data_promo_response.dart';
import 'package:pos/features/sync/data/models/response/initial_data_response.dart';
import 'package:pos/features/sync/domain/models/sync_entity.dart';
import 'package:pos/features/sync/domain/repositories/sync_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final SyncDataService _syncService;
  final SessionManager _session;
  final AppDatabaseManager _databaseManager;

  SyncRepositoryImpl(this._syncService, this._session, this._databaseManager);

  Future<Either<Failure, SyncEntity>> getInitialData(
    SyncEntity params, {
    String? serverTime,
  }) async {
    try {
      final outletFuture = _syncService.getInitialData(
        SyncPayload(serverTime: serverTime),
      );
      final productFuture = _syncService.getInitialProduct(
        SyncPayload(serverTime: serverTime),
      );
      final promoFuture = _syncService.getInitialPromo(
        SyncPayload(serverTime: serverTime),
      );

      await Future.wait([
        outletFuture,
        productFuture,
        promoFuture,
      ], eagerError: true);

      final outletResult = await outletFuture;
      final productResult = await productFuture;
      final promoResult = await promoFuture;

      final database = await _databaseManager.mainDb;
      if (database == null) {
        throw DatabaseFailure('No connection to database has found!');
      }

      await _saveSyncOutlet(database, outletResult);
      await _saveSyncProduct(database, productResult);
      await _saveSyncPromo(database, promoResult);

      return right(
        SyncEntity(
          outletId: params.outletId,
          companyId: params.companyId,
          outletSynced: false,
          productSynced: false,
          promoSynced: false,
        ),
      );
    } on DatabaseFailure catch (error) {
      return left(error);
    } catch (error, stackTrace) {
      return left(NetworkFailure.error(error, stackTrace: stackTrace));
    }
  }
}

Future<void> _saveSyncOutlet(
  MainDatabase database,
  InitialDataResponse data,
) async {
  await database.transaction(() async {
    await database.batch((batch) {
      final s = data.outletSetting;

      // ── 1. Outlet Setting ────────────────────────────────────────────────
      batch.insert(
        database.tableOutletSetting,
        TableOutletSettingCompanion(
          id: const Value(1),
          lastLoginUser: const Value(''),
          lastLoginUserId: const Value(''),
          serviceChargeTax: const Value(''),
          defaultSalesTaxId: Value(s.defaultSalesTaxId),
          serviceCharged: Value(s.serviceCharged),
          serviceChargeRate: Value(s.serviceChargeRate.toDouble()),
          serviceChargeTaxId: Value(s.serviceChargeTaxId),
          serviceChargeTaxRate: Value(s.serviceChargeTaxRate?.toDouble()),
          serviceChargeBeforeDiscount: Value(s.serviceChargeBeforeDiscount),
          taxed: Value(s.taxed),
          taxInclusive: Value(s.taxInclusive),
          taxOnDiscount: Value(s.taxOnDiscount),
          address: Value(s.address),
          email: Value(s.email),
          phone: Value(s.phone),
          fax: Value(s.fax),
          facebook: Value(s.facebook),
          instagram: Value(s.instagram),
          twitter: Value(s.twitter),
          website: Value(s.website),
          billNotes: Value(s.note),
          closingTime: Value(s.closingTime),
          pictureUrl: Value(s.pictureUrl),
          allowCustomPriceOrDiscount: Value(s.allowCustomPriceOrDiscount),
          defaultWarehouseId: Value(s.defaultWarehouseId),
          subscriptionDueDateUtc: Value(
            DateTime.tryParse(s.subscriptionDueDateUtc),
          ),
        ),
        mode: InsertMode.insertOrReplace,
      );

      // ── 2. Taxes ─────────────────────────────────────────────────────────
      for (final t in data.taxes) {
        batch.insert(
          database.tableTax,
          TableTaxCompanion(
            id: Value(t.id),
            code: Value(t.code),
            name: Value(t.name),
            rate: Value(t.rate.toDouble()),
            deleted: Value(t.deleted),
            products: const Value('[]'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 3. Users ──────────────────────────────────────────────────────────
      for (final u in data.users) {
        batch.insert(
          database.tableUser,
          TableUserCompanion(
            id: Value(u.id),
            firstName: Value(u.firstName),
            lastName: Value(u.lastName),
            fullName: Value(u.fullName),
            pinNumber: Value(u.pinNumber),
            pictureUrl: Value(u.pictureUrl),
            deleted: Value(u.deleted),
            permissionPay: Value(u.permissionPay),
            permissionEdit: Value(u.permissionEdit),
            permissionVoidOrder: Value(u.permissionVoidOrder),
            permissionVoidItem: Value(u.permissionVoidItem),
            permissionDiscount: Value(u.permissionDiscount),
            permissionReport: Value(u.permissionReport),
            permissionCustomPrice: Value(u.permissionCustomPrice),
            permissionAdmin: Value(u.permissionAdmin),
            permissionCustomItem: Value(u.permissionCustomItem),
            permissionPrintBill: Value(u.permissionPrintBill),
            permissionSeeAllUserTransactions: Value(
              u.permissionSeeAllUserTransactions,
            ),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 4. Areas ──────────────────────────────────────────────────────────
      for (final a in data.areas) {
        batch.insert(
          database.tableArea,
          TableAreaCompanion(
            id: Value(a.id),
            name: Value(a.name),
            absisMaximumGrid: Value(a.absisMaximumGrid),
            ordinatMaximumGrid: Value(a.ordinatMaximumGrid),
            sortOrder: Value(a.sortOrder),
            deleted: Value(a.deleted),
            availableForAllPosUsers: Value(a.availableForAllPosUsers),
            tables: const Value('[]'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 5. Area ↔ User relations ──────────────────────────────────────────
      for (final rel in data.areaToUsers) {
        batch.insert(
          database.tableAreaToUserRel,
          TableAreaToUserRelCompanion(
            posAreaId: Value(rel.posAreaId),
            userId: Value(rel.userId),
            sortOrder: Value(rel.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 6. Tables (POS tables / meja) ─────────────────────────────────────
      for (final t in data.tables) {
        batch.insert(
          database.tableTable,
          TableTableCompanion(
            id: Value(t.id),
            name: Value(t.name),
            absisStartingGrid: Value(t.absisStartingGrid),
            ordinatStartingGrid: Value(t.ordinatStartingGrid),
            absisAmountOfGrid: Value(t.absisAmountOfGrid),
            ordinatAmountOfGrid: Value(t.ordinatAmountOfGrid),
            areaId: Value(t.areaId),
            tableType: Value(t.tableType),
            deleted: Value(t.deleted),
            hasMaxOrderDuration: Value(t.hasMaxOrderDuration),
            maxOrderDurationMinutes: Value(t.maxOrderDurationMinutes),
            hasMinOrderAmount: Value(t.hasMinOrderAmount),
            minOrderAmount: Value(t.minOrderAmount?.toDouble()),
            minOrderAmountType: Value(t.minOrderAmountType),
            area: const Value('{}'),
            order: const Value('{}'),
            session: const Value('{}'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 7. Sales Types ────────────────────────────────────────────────────
      for (final st in data.salesTypes) {
        batch.insert(
          database.tableSalesType,
          TableSalesTypeCompanion(
            id: Value(st.id),
            name: Value(st.name),
            isMaster: Value(st.isMaster),
            serviceCharged: Value(st.serviceCharged),
            taxed: Value(st.taxed),
            deleted: Value(st.deleted),
            priceLevelId: Value(st.priceLevelId),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 8. Discounts ──────────────────────────────────────────────────────
      for (final d in data.discounts) {
        batch.insert(
          database.tableDiscount,
          TableDiscountCompanion(
            id: Value(d.id),
            name: Value(d.name),
            discountMode: Value(d.discountMode),
            discountValue: Value(d.discountValue.toDouble()),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 9. Payment Methods ────────────────────────────────────────────────
      for (final pm in data.paymentMethods) {
        batch.insert(
          database.tablePaymentMethod,
          TablePaymentMethodCompanion(
            paymentMethodId: Value(pm.paymentMethodId),
            paymentMethodName: Value(pm.paymentMethodName),
            paymentMethodType: Value(pm.paymentMethodType),
            paymentAccountId: Value(pm.paymentAccountId),
            isDefaultCash: Value(pm.isDefaultCash),
            sortOrder: Value(pm.sortOrder),
            deleted: Value(pm.deleted),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 10. Customers & Addresses ─────────────────────────────────────────
      for (final c in data.customers) {
        batch.insert(
          database.tableCustomer,
          TableCustomerCompanion(
            id: Value(c.id),
            displayName: Value(c.displayName),
            firstName: Value(c.firstName),
            lastName: Value(c.lastName),
            company: Value(c.company),
            phone: Value(c.phone),
            email: Value(c.email),
            gender: Value(c.gender),
            dateOfBirth: Value(
              c.dateOfBirth != null ? DateTime.tryParse(c.dateOfBirth!) : null,
            ),
            address: Value(c.address),
            deleted: Value(c.isDeleted),
            bankAccountId: Value(c.bankAccountId),
            bankId: Value(c.bankId),
            bankName: Value(c.bankName),
            bankAccountNumber: Value(c.bankAccountNumber),
            bankAccountName: Value(c.bankAccountName),
            pricingCategoryId: Value(c.defaultSalesPriceLevelId),
          ),
          mode: InsertMode.insertOrReplace,
        );

        // Parse & insert addresses from JSON-string `address` field.
        // May be a JSON array "[{...}]" or JSON object "{...}".
        if (c.address.isNotEmpty) {
          dynamic decoded;
          try {
            decoded = jsonDecode(c.address);
          } catch (_) {
            // Not valid JSON – skip address parsing for this customer.
          }

          if (decoded is List) {
            for (final item in decoded) {
              if (item is Map<String, dynamic>) {
                _insertAddressFromMap(batch, database, item, c.id);
              }
            }
          } else if (decoded is Map<String, dynamic>) {
            _insertAddressFromMap(batch, database, decoded, c.id);
          }
        }
      }
    });
  });
}

/// Maps a decoded address [map] (from customer's `address` JSON string)
/// and inserts it into the [database.tableAddress] via [batch].
///
/// The `address` field may arrive as a JSON **object** `{}` or **array** `[{}]`.
/// Call this helper once per address object.
void _insertAddressFromMap(
  Batch batch,
  MainDatabase database,
  Map<String, dynamic> map,
  String customerId,
) {
  // Prefer the server-provided AddressId; generate a UUID if missing.
  final id = (map['AddressId'] as String?)?.isNotEmpty == true
      ? map['AddressId'] as String
      : const Uuid().v4();

  batch.insert(
    database.tableAddress,
    TableAddressCompanion(
      id: Value(id),
      customerId: Value(customerId),
      label: Value(map['Label'] as String?),
      address: Value(map['Address'] as String?),
      street: Value(map['Street1'] as String?),
      villageId: Value(map['VillageId'] as int?),
      village: Value(map['Village'] as String?),
      districtId: Value(map['DistrictId'] as int?),
      district: Value(map['District'] as String?),
      cityId: Value(map['CityId'] as int?),
      city: Value(map['City'] as String?),
      provinceId: Value(map['ProvinceId'] as int?),
      province: Value(map['StateProvince'] as String?),
      countryId: Value(map['CountryId'] as String?),
      countryName: Value(map['CountryName'] as String?),
      postalCode: Value(map['PostalCode'] as String?),
      recipientName: Value(map['RecipientName'] as String?),
      recipientPhone: Value(map['RecipientPhone'] as String?),
      source: Value(map['DataSource'] as String?),
    ),
    mode: InsertMode.insertOrReplace,
  );
}

Future<void> _saveSyncProduct(
  MainDatabase database,
  InitialDataProductResponse data,
) async {
  await database.transaction(() async {
    await database.batch((batch) {
      // ── 1. Categories ────────────────────────────────────────────────────
      for (final c in data.categories) {
        batch.insert(
          database.tableCategory,
          TableCategoryCompanion(
            id: Value(c.id),
            name: Value(c.name),
            sortOrder: Value(c.sortOrder),
            deleted: Value(c.deleted),
            isCustom: Value(c.isCustom),
            startDate: Value(
              c.startDate != null ? DateTime.tryParse(c.startDate!) : null,
            ),
            startTime: Value(c.startTime),
            endDate: Value(
              c.endDate != null ? DateTime.tryParse(c.endDate!) : null,
            ),
            endTime: Value(c.endTime),
            monday: Value(c.monday),
            tuesday: Value(c.tuesday),
            wednesday: Value(c.wednesday),
            thursday: Value(c.thursday),
            friday: Value(c.friday),
            saturday: Value(c.saturday),
            sunday: Value(c.sunday),
            products: const Value('[]'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 2. Modifiers ──────────────────────────────────────────────────────
      for (final m in data.modifiers) {
        batch.insert(
          database.tableModifier,
          TableModifierCompanion(
            id: Value(m.id),
            name: Value(m.name),
            required: Value(m.required),
            allowMultiple: Value(m.allowMultiple),
            maximumAllowed: Value(m.maximumAllowed?.toInt()),
            haveMaximumItemAllowed: Value(m.haveMaximumItemAllowed),
            maximumItemAllowed: Value(m.maximumItemAllowed?.toInt()),
            sortOrder: const Value(0.0), // Not provided in API
            deleted: Value(m.deleted),
            items: const Value('[]'),
            products: const Value('[]'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 3. Modifier Items ─────────────────────────────────────────────────
      for (final mi in data.modifierItems) {
        batch.insert(
          database.tableModifierItem,
          TableModifierItemCompanion(
            id: Value(mi.id),
            modifierId: Value(mi.modifierId),
            name: Value(mi.name),
            productId: Value(mi.productId),
            productVariantId: Value(mi.productVariantId),
            useCustomPrice: Value(mi.useCustomPrice),
            price: Value(mi.price?.toDouble()),
            sortOrder: Value(mi.sortOrder),
            modifier: const Value('{}'),
            product: const Value('{}'),
            productVariant: const Value('{}'),
            prices: const Value('[]'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 4. Products ───────────────────────────────────────────────────────
      for (final p in data.products) {
        batch.insert(
          database.tableProduct,
          TableProductCompanion(
            id: Value(p.id),
            sku: Value(p.sku),
            name: Value(p.name),
            detailDescription: Value(p.detailDescription),
            serviceCharged: Value(p.serviceCharged),
            salesTaxId: Value(p.salesTaxId),
            uom: Value(p.uom),
            modifierCount: Value(p.modifierCount),
            hasVariants: Value(p.hasVariants),
            variantCount: Value(p.variantCount),
            variantAttribute1: Value(p.variantAttribute1),
            variantAttribute2: Value(p.variantAttribute2),
            variantAttribute3: Value(p.variantAttribute3),
            masterVariantId: Value(p.masterVariantId),
            pictureUrl: Value(p.pictureUrl),
            availableForAllPosUsers: Value(p.availableForAllPosUsers),
            isDiscountDisabled: Value(p.isDiscountDisabled),
            deleted: Value(p.deleted),
            salesTax: const Value('{}'),
            categories: const Value('[]'),
            modifiers: const Value('[]'),
            productVariants: const Value('[]'),
            printerArea: const Value('{}'),
            printerItemArea: const Value('{}'),
            priceTiers: const Value('[]'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 5. Product Variants ───────────────────────────────────────────────
      for (final v in data.variants) {
        batch.insert(
          database.tableProductVariant,
          TableProductVariantCompanion(
            id: Value(v.id),
            productId: Value(v.productId),
            sku: Value(v.sku),
            name: Value(v.name),
            variantName: Value(v.variantName),
            unitPrice: Value(v.unitPrice.toDouble()),
            isMaster: Value(v.isMaster),
            attribute1Value: Value(v.attribute1Value),
            attribute2Value: Value(v.attribute2Value),
            attribute3Value: Value(v.attribute3Value),
            sortOrder: Value(v.sortOrder),
            deleted: Value(v.deleted),
            product: const Value('{}'),
            prices: const Value('[]'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 6. Product → Category Relations ───────────────────────────────────
      for (final rel in data.productToCategories) {
        batch.insert(
          database.tableProductCategoryRelation,
          TableProductCategoryRelationCompanion(
            productId: Value(rel.productId),
            categoryId: Value(rel.categoryId),
            deleted: Value(rel.deleted),
            product: const Value('{}'),
            category: const Value('{}'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 7. Product → User Relations ───────────────────────────────────────
      for (final rel in data.productToUsers) {
        batch.insert(
          database.tableproductToUserRel,
          TableproductToUserRelCompanion(
            productId: Value(rel.productId),
            userId: Value(rel.userId),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 8. Product → Modifier Relations ──────────────────────────────────
      for (final rel in data.productToModifiers) {
        batch.insert(
          database.tableProductModifierRelation,
          TableProductModifierRelationCompanion(
            productId: Value(rel.productId),
            modifierId: Value(rel.modifierId),
            sortOrder: Value(rel.sortOrder),
            deleted: Value(rel.deleted),
            product: const Value('{}'),
            modifier: const Value('{}'),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 9. Price Lists ────────────────────────────────────────────────────
      for (final pl in data.priceList) {
        batch.insert(
          database.tableProductPricelist,
          TableProductPricelistCompanion(
            productId: Value(pl.productId),
            productVariantId: Value(pl.productVariantId),
            salesTypeId: Value(pl.salesTypeId),
            salesTypeName: Value(pl.salesTypeName),
            price: Value(pl.price.toDouble()),
            isMaster: Value(pl.isMaster),
            deleted: Value(pl.deleted),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 10. Price Levels ──────────────────────────────────────────────────
      for (final pl in data.priceLevels) {
        batch.insert(
          database.tablePriceLevel,
          TablePriceLevelCompanion(
            id: Value(pl.id),
            name: Value(pl.name),
            isMaster: Value(pl.isMaster),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 11. Price Level Items ─────────────────────────────────────────────
      for (final pli in data.priceLevelItems) {
        batch.insert(
          database.tablePriceLevelPriceList,
          TablePriceLevelPriceListCompanion(
            productId: Value(pli.productId),
            productVariantId: Value(pli.productVariantId),
            priceLevelId: Value(pli.priceLevelId),
            priceLevelName: Value(pli.priceLevelName),
            price: Value(pli.price.toDouble()),
            isMaster: Value(pli.isMaster),
            deleted: Value(pli.deleted),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 12. Employees ─────────────────────────────────────────────────────
      for (final e in data.employees) {
        batch.insert(
          database.tableEmployee,
          TableEmployeeCompanion(
            id: Value(e.employeeId),
            name: Value(e.employeeName),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 13. Commission Product → Employee Relations ────────────────────────
      for (final rel in data.commisionProductToEmployeeRels) {
        batch.insert(
          database.tableEmployeeToProductCommissionRelation,
          TableEmployeeToProductCommissionRelationCompanion(
            id: Value(
              const Uuid().v4(),
            ), // No id provided in API — generate UUID
            productId: Value(rel.productId),
            employeeId: Value(rel.employeeId),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 14. Product Tiered Prices ─────────────────────────────────────────
      for (final pt in data.productTieredPrices) {
        batch.insert(
          database.tablePriceTier,
          TablePriceTierCompanion(
            id: Value(pt.id),
            productId: Value(pt.productId),
            name: Value(pt.name),
            minimumQty: Value(pt.minimumQty.toDouble()),
            price: Value(pt.price.toDouble()),
            sortOrder: Value(pt.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  });
}

Future<void> _saveSyncPromo(
  MainDatabase database,
  InitialDataPromoResponse data,
) async {
  await database.transaction(() async {
    await database.batch((batch) {
      // ── 1. Promos ──────────────────────────────────────────────────────────
      for (final p in data.promos) {
        batch.insert(
          database.tablePromo,
          TablePromoCompanion(
            id: Value(p.id),
            name: Value(p.name),
            type: Value(p.type),
            appliesMultiple: Value(p.appliesMultiple),
            canBeCombined: Value(p.canBeCombined),
            startDateTime: Value(DateTime.tryParse(p.startDateTime)),
            endDateTime: Value(DateTime.tryParse(p.endDateTime)),
            startDate: Value(DateTime.tryParse(p.startDate)),
            endDate: Value(DateTime.tryParse(p.endDate)),
            useTimespan: Value(p.useTimespan),
            startTime: Value(p.startTime),
            endTime: Value(p.endTime),
            monday: Value(p.monday),
            tuesday: Value(p.tuesday),
            wednesday: Value(p.wednesday),
            thursday: Value(p.thursday),
            friday: Value(p.friday),
            saturday: Value(p.saturday),
            sunday: Value(p.sunday),
            allSalesType: Value(p.allSalesType),
            allPaymentMethod: Value(p.allPayment),
            inactive: Value(p.inactive == 1),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 2. Promo Extensions ───────────────────────────────────────────────
      for (final pe in data.promoExtensions) {
        batch.insert(
          database.tablePromoExtension,
          TablePromoExtensionCompanion(
            id: Value(pe.id),
            promoId: Value(pe.promoId),
            operatorTerm: Value(pe.operatorTerm),
            operatorReward: Value(pe.operatorReward),
            termVariantLength: Value(pe.termVariantLength),
            discountType: Value(pe.discountType),
            discountPercentage: Value(pe.discountPercentage.toDouble()),
            discountAmount: Value(pe.discountAmount.toDouble()),
            maxDiscountAmount: Value(pe.maxDiscountAmount.toDouble()),
            sortOrder: Value(pe.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 3. Promo → Payment Method Relations ───────────────────────────────
      for (final rel in data.promoToPaymentMethodRels) {
        batch.insert(
          database.tablePromoToPaymentMethodRel,
          TablePromoToPaymentMethodRelCompanion(
            id: Value(rel.id),
            promoId: Value(rel.promoId),
            paymentMethodId: Value(rel.paymentMethodId),
            sortOrder: Value(rel.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 4. Promo → Sales Type Relations ──────────────────────────────────
      for (final rel in data.promoToSalesTypeRels) {
        batch.insert(
          database.tablePromoToSalesTypeRel,
          TablePromoToSalesTypeRelCompanion(
            id: Value(rel.id),
            promoId: Value(rel.promoId),
            salesTypeId: Value(rel.salesTypeId),
            sortOrder: Value(rel.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 5. Promo Product Terms ────────────────────────────────────────────
      for (final pt in data.promoProductTerms) {
        batch.insert(
          database.tablePromoProductTerm,
          TablePromoProductTermCompanion(
            id: Value(pt.id),
            promoId: Value(pt.promoId),
            productId: Value(pt.productId),
            allVariants: Value(pt.allVariants),
            sortOrder: Value(pt.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 6. Promo Product Variant Terms ────────────────────────────────────
      for (final pvt in data.promoProductVariantTerms) {
        batch.insert(
          database.tablePromoProductVariantTerm,
          TablePromoProductVariantTermCompanion(
            id: Value(pvt.id),
            promoId: Value(pvt.promoId),
            promoProductTermId: Value(pvt.promoProductTermId),
            productId: Value(pvt.productId),
            productVariantId: Value(pvt.productVariantId),
            qty: Value(pvt.qty),
            sortOrder: Value(pvt.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 7. Promo Product Rewards ──────────────────────────────────────────
      for (final pr in data.promoProductRewards) {
        batch.insert(
          database.tablePromoProductReward,
          TablePromoProductRewardCompanion(
            id: Value(pr.id),
            promoId: Value(pr.promoId),
            productId: Value(pr.productId),
            allVariants: Value(pr.allVariants),
            sortOrder: Value(pr.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }

      // ── 8. Promo Product Variant Rewards ─────────────────────────────────
      for (final pvr in data.promoProductVariantRewards) {
        batch.insert(
          database.tablePromoProductVariantReward,
          TablePromoProductVariantRewardCompanion(
            id: Value(pvr.id),
            promoId: Value(pvr.promoId),
            // Note: Drift table column has a typo `promoProductTRewardId`
            promoProductTRewardId: Value(pvr.promoProductRewardId),
            productId: Value(pvr.productId),
            productVariantId: Value(pvr.productVariantId),
            qty: Value(pvr.qty),
            sortOrder: Value(pvr.sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  });
}
