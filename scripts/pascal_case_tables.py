import os
import re

def to_pascal_case(s):
    if not s:
        return s
    # Just capitalize the first letter, since it's already camelCase
    return s[0].upper() + s[1:]

directory = 'lib/core/database/tables'
files_to_check = []

for root, _, files in os.walk(directory):
    for f in files:
        if f.endswith('.dart'):
            files_to_check.append(os.path.join(root, f))

changed_files = 0

for file_path in files_to_check:
    with open(file_path, 'r') as f:
        content = f.read()

    # Find @DataClassName('something')
    data_class_match = re.search(r"@DataClassName\('([^']+)'\)", content)
    if not data_class_match:
        continue
    
    old_name = data_class_match.group(1)
    new_name = to_pascal_case(old_name)

    if old_name == new_name:
        continue

    # We need to replace @DataClassName('old_name') with @DataClassName('new_name')
    new_content = re.sub(
        r"@DataClassName\('{}'\)".format(re.escape(old_name)),
        r"@DataClassName('{}')".format(new_name),
        content
    )

    # We also need to replace `tableName => 'old_name';` with `tableName => 'new_name';`
    new_content = re.sub(
        r"String get tableName => '{}';".format(re.escape(old_name)),
        r"String get tableName => '{}';".format(new_name),
        new_content
    )
    
    # Just in case there is `String? get tableName => 'old_name';`
    new_content = re.sub(
        r"String\? get tableName => '{}';".format(re.escape(old_name)),
        r"String? get tableName => '{}';".format(new_name),
        new_content
    )


    if new_content != content:
        with open(file_path, 'w') as f:
            f.write(new_content)
        print(f"Updated {file_path}: {old_name} -> {new_name}")
        changed_files += 1

print(f"Total files updated: {changed_files}")
