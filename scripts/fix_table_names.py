import os
import re

def to_pascal_case(s):
    if not s: return s
    return s[0].upper() + s[1:]

def to_camel_case(s):
    if not s: return s
    return s[0].lower() + s[1:]

def process_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    # Find @DataClassName('...')
    data_class_match = re.search(r"@DataClassName\('([^']+)'\)", content)
    
    # Find String get tableName => '...';
    table_name_match = re.search(r"String\??\s+get\s+tableName\s*=>\s*'([^']+)';", content)

    if not data_class_match or not table_name_match:
        return False # No match, skip

    current_data_class = data_class_match.group(1)
    current_table_name = table_name_match.group(1)

    # We want DataClassName to be PascalCase and tableName to be camelCase
    # We can derive the base name from either, assuming they just differ by first letter case
    
    base_name = current_data_class # Start with DataClassName
    
    expected_data_class = to_pascal_case(base_name)
    expected_table_name = to_camel_case(base_name)

    # Replace in content
    new_content = re.sub(
        r"@DataClassName\('([^']+)'\)", 
        f"@DataClassName('{expected_data_class}')", 
        content
    )

    new_content = re.sub(
        r"(String\??\s+get\s+tableName\s*=>\s*)'([^']+)';", 
        rf"\1'{expected_table_name}';", 
        new_content
    )

    if new_content != content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        return True
    
    return False

import glob

files = glob.glob('lib/core/database/tables/**/*.dart', recursive=True)
changed_files = []

for f in files:
    if process_file(f):
        changed_files.append(f)

print(f"Processed {len(files)} files. Changed {len(changed_files)} files.")
for f in changed_files:
    print(f" - {f}")
