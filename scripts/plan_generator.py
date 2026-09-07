import json
import os
import re

# Load sequelize schema
with open('sequelize_schema.json', 'r') as f:
    schema = json.load(f)

drift_dir = 'lib/core/database/tables/main'
drift_files = [f for f in os.listdir(drift_dir) if f.endswith('.dart')]

# Map snake_case to camelCase
def to_camel_case(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

# Known type mappings
def map_type(seq_type):
    seq_type = str(seq_type).upper()
    if 'UUID' in seq_type or 'STRING' in seq_type or 'TEXT' in seq_type or 'CHAR' in seq_type:
        return 'text'
    if 'INTEGER' in seq_type or 'BIGINT' in seq_type:
        return 'integer'
    if 'FLOAT' in seq_type or 'DOUBLE' in seq_type or 'DECIMAL' in seq_type:
        return 'real'
    if 'BOOLEAN' in seq_type:
        return 'boolean'
    if 'DATE' in seq_type:
        return 'dateTime'
    return 'text'

# Try to match dart files with sequelize schema keys
changes = []
for f in drift_files:
    # derive the sequelize key
    # Sometimes it's direct camelCase of the filename, e.g., area_user_relation.dart -> areaUserRelation
    # But looking at sequelize_schema.json, the keys are exactly the model names from `sequelize.define`
    
    # Read the file
    with open(os.path.join(drift_dir, f), 'r') as dart_file:
        content = dart_file.read()
    
    # Get table name from DataClassName or tableName override
    table_name_match = re.search(r"String get tableName => '([^']+)';", content)
    if not table_name_match:
        table_name_match = re.search(r"@DataClassName\('([^']+)'\)", content)
        
    if not table_name_match:
        continue
    table_name = table_name_match.group(1)
    
    # Find matching key in schema. The schema keys are the model names used in define().
    # Let's map file name to model name based on common patterns
    base_name = f.replace('.dart', '')
    # MiddleBackend names are kebab case, e.g. 'area-user-relation.js'. The model name in that file might be 'areaToUserRel'.
    # I should find the corresponding JS file for this Dart file...
    # It's better to just search the schema for a matching model name, or build a manual map.
