import json
import os
import re

# ─── Load Sequelize schema ───
with open('sequelize_schema.json', 'r') as f:
    schema = json.load(f)

# ─── Map Drift DataClassName (plural) -> Sequelize model key (singular) ───
DATA_CLASS_TO_SEQ_KEY = {
    'addresses':                     'address',
    'areaToUserRels':                'areaToUserRel',
    'areas':                         'area',
    'categories':                    'category',
    'commissionToOrderLineRels':     'commissionToOrderLineRel',
    'couponOrders':                  'couponOrder',
    'customers':                     'customer',
    'deliveries':                    'delivery',
    'deliveryAddresses':             'deliveryAddress',
    'discounts':                     'discount',
    'employeeToProductCommissionRels': 'employeeToProductCommissionRel',
    'employees':                     'employee',
    'linkedOrders':                  'linkedOrder',
    'modifierItems':                 'modifierItem',
    'modifiers':                     'modifier',
    'orderLineModifiers':            'orderLineModifier',
    'orderLines':                    'orderLine',
    'orderLogs':                     'orderLog',
    'orderMergeds':                  'orderMerged',
    'orderPayments':                 'orderPayment',
    'orderTaxes':                    'orderTax',
    'orders':                        'order',
    'outletSettings':                'outletSetting',
    'paymentMethods':                'paymentMethod',
    'priceLevelPricelists':          'priceLevelPricelist',
    'priceLevels':                   'priceLevel',
    'priceTierOrderLines':           'priceTierOrderLine',
    'priceTiers':                    'priceTier',
    'pricelists':                    'pricelist',
    'printerAreaRels':               'printerAreaRel',
    'printerAreas':                  'printerArea',
    'printers':                      'printer',
    'printoutTemplates':             'printoutTemplate',
    'productCategoryRelations':      'productCategoryRelation',
    'productModifierRelations':      'productModifierRelation',
    'productToUserRels':             'productToUserRel',
    'productVariants':               'productVariant',
    'products':                      'product',
    'promoExtensions':               'promoExtension',
    'promoOrders':                   'promoOrder',
    'promoProductRewards':           'promoProductReward',
    'promoProductTerms':             'promoProductTerm',
    'promoProductVariantRewards':    'promoProductVariantReward',
    'promoProductVariantTerms':      'promoProductVariantTerm',
    'promoToPaymentMethodRels':      'promoToPaymentMethodRel',
    'promoToSalesTypeRels':          'promoToSalesTypeRel',
    'promos':                        'promo',
    'qponOrders':                    'qponOrder',
    'qrisBankAcquirers':             'qrisBankAcquirer',
    'qrisHistories':                 'qrisHistory',
    'qrisPaymentMethods':            'qrisPaymentMethod',
    'salesTypes':                    'salesType',
    'scanners':                      'scanner',
    'shiftSessions':                 'shiftSession',
    'tables':                        'table',
    'TableManagement':               'tableManagement',
    'taxes':                         'tax',
    'transactionLogs':               'transactionLog',
    'users':                         'user',
}

# ─── Type mapping ───
def seq_type_to_drift(seq_type):
    """Map a Sequelize DataType string to a Drift column type string."""
    seq_type = str(seq_type).upper()
    if 'DATE' in seq_type:
        return 'dateTime'
    if 'BOOLEAN' in seq_type:
        return 'boolean'
    if 'DECIMAL' in seq_type or 'FLOAT' in seq_type or 'DOUBLE' in seq_type or 'NUMERIC' in seq_type or 'REAL' in seq_type:
        return 'real'
    if 'INTEGER' in seq_type or 'BIGINT' in seq_type or 'INT' in seq_type:
        return 'integer'
    if 'UUID' in seq_type or 'STRING' in seq_type or 'TEXT' in seq_type or 'CHAR' in seq_type or 'JSON' in seq_type:
        return 'text'
    return 'text'  # fallback

# ─── Drift column type name ───
DRIFT_COL_TYPE = {
    'text':     'TextColumn',
    'integer':  'IntColumn',
    'real':     'RealColumn',
    'boolean':  'BoolColumn',
    'dateTime': 'DateTimeColumn',
}

BASE_FIELDS = {'createdAt', 'updatedAt', 'deletedAt'}

def parse_seq_field(field_def):
    """Returns (drift_type, is_nullable, default_value_or_None)"""
    if isinstance(field_def, str):
        # Simple type, no explicit allowNull → nullable by default in Sequelize
        return seq_type_to_drift(field_def), True, None
    
    # dict form
    seq_type = str(field_def.get('type', 'STRING'))
    drift_type = seq_type_to_drift(seq_type)
    allow_null = field_def.get('allowNull', True)
    is_pk = field_def.get('primaryKey', False)
    is_fk = field_def.get('foreignKey', False)
    default_val = field_def.get('defaultValue', None)
    
    # Non-nullable if allowNull=False or primaryKey=True
    is_nullable = not (allow_null == False or is_pk)
    
    # Skip UUIDV4 as default (handled in repo layer)
    if default_val == 'UUIDV4':
        default_val = None
    
    return drift_type, is_nullable, default_val

def build_dart_column_def(col_name, drift_type, is_nullable, default_val):
    """Build the full Dart column definition string."""
    col_class = DRIFT_COL_TYPE[drift_type]
    
    chain = f'{drift_type}()'
    
    if default_val is not None and not callable(default_val) and default_val != 'UUIDV4':
        if isinstance(default_val, str):
            chain += f".withDefault(const Constant('{default_val}'))"
        elif isinstance(default_val, bool):
            chain += f".withDefault(const Constant({str(default_val).lower()}))"
        elif isinstance(default_val, (int, float)):
            chain += f".withDefault(const Constant({default_val}))"
    
    if is_nullable:
        chain += '.nullable()'
    
    return f'  {col_class} get {col_name} => {chain}();'

# ─── Process each dart file ───
drift_dir = 'lib/core/database/tables/main'
files = sorted([f for f in os.listdir(drift_dir) if f.endswith('.dart')])

summary = []

for fname in files:
    fpath = os.path.join(drift_dir, fname)
    with open(fpath, 'r') as f:
        original = f.read()
    
    # Get DataClassName
    dc_match = re.search(r"@DataClassName\('([^']+)'\)", original)
    if not dc_match:
        summary.append(f"SKIP (no DataClassName): {fname}")
        continue
    
    data_class_name = dc_match.group(1)
    seq_key = DATA_CLASS_TO_SEQ_KEY.get(data_class_name)
    if not seq_key or seq_key not in schema:
        summary.append(f"SKIP (no Sequelize schema found): {fname} -> {seq_key}")
        continue
    
    seq_model = schema[seq_key]
    
    new_lines = []
    changes_count = 0
    
    for line in original.split('\n'):
        # Match column definitions: optional_spaces TYPE_Column get name => something;
        col_match = re.match(r'^  (TextColumn|IntColumn|RealColumn|BoolColumn|DateTimeColumn|BooleanColumn|IntegerColumn)\s+get\s+(\w+)\s*=>', line)
        
        if col_match:
            col_name = col_match.group(2)
            
            # Skip base fields
            if col_name in BASE_FIELDS:
                new_lines.append(line)
                continue
            
            # Find field in Sequelize schema
            if col_name not in seq_model:
                # Column not in Sequelize schema — keep as-is
                new_lines.append(line)
                continue
            
            field_def = seq_model[col_name]
            drift_type, is_nullable, default_val = parse_seq_field(field_def)
            new_line = build_dart_column_def(col_name, drift_type, is_nullable, default_val)
            
            if new_line.strip() != line.strip():
                changes_count += 1
            
            new_lines.append(new_line)
        else:
            new_lines.append(line)
    
    new_content = '\n'.join(new_lines)
    
    if new_content != original:
        with open(fpath, 'w') as f:
            f.write(new_content)
        summary.append(f"UPDATED ({changes_count} cols): {fname}")
    else:
        summary.append(f"NO CHANGE: {fname}")

print("=== SCHEMA SYNC RESULT ===")
for s in summary:
    print(s)

updated = [s for s in summary if s.startswith("UPDATED")]
print(f"\nTotal updated: {len(updated)}/{len(files)} files")
