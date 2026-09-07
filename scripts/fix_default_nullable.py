"""
Fix: Remove .nullable() from columns that already have .withDefault(...)
A column with a default value will never be NULL, so it should NOT be nullable.
"""
import os
import re

drift_dir = 'lib/core/database/tables/main'
files = sorted([f for f in os.listdir(drift_dir) if f.endswith('.dart')])

total_fixed = 0
files_changed = []

for fname in files:
    fpath = os.path.join(drift_dir, fname)
    with open(fpath, 'r') as f:
        original = f.read()
    
    # Pattern: match lines that have both withDefault(...) AND .nullable()
    # We want to remove the .nullable() part when withDefault is present
    # Handle multi-line cases where the column definition spans multiple lines
    
    # Join multi-line column definitions into single lines for processing
    # Dart columns end with ()(); — find all column defs
    
    new_content = original
    
    # Single-line pattern: type().withDefault(const Constant(...)).nullable()();
    # Replace: remove .nullable() when .withDefault(...) is present on same expression
    
    # Pattern to find: .withDefault(const Constant(SOMETHING)).nullable()
    # Replace with:    .withDefault(const Constant(SOMETHING))
    
    pattern = r'(\.withDefault\(const Constant\([^)]+\)\))\.nullable\(\)'
    replacement = r'\1'
    
    new_content = re.sub(pattern, replacement, new_content)
    
    if new_content != original:
        # Count how many fixes were applied
        count = len(re.findall(pattern, original))
        total_fixed += count
        with open(fpath, 'w') as f:
            f.write(new_content)
        files_changed.append(f"{fname}: {count} fix(es)")

print("=== FIX RESULT ===")
for fc in files_changed:
    print(f"  FIXED: {fc}")
print(f"\nTotal: {total_fixed} columns fixed across {len(files_changed)} files")

# Verify no more cases remain
remaining = []
for fname in files:
    fpath = os.path.join(drift_dir, fname)
    with open(fpath, 'r') as f:
        content = f.read()
    matches = re.findall(r'withDefault.*nullable|nullable.*withDefault', content)
    if matches:
        remaining.append(f"{fname}: {matches}")

if remaining:
    print("\n⚠️  Still found withDefault+nullable in:")
    for r in remaining:
        print(f"  {r}")
else:
    print("\n✅ No more withDefault+nullable combinations found!")
