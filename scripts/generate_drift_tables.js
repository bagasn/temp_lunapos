const fs = require('fs');
const path = require('path');

const srcDir = path.resolve(__dirname, '../../../LunaPOS/luna-middle-backend-api/src/models/db-models');
const outDir = path.resolve(__dirname, '../lib/core/database/tables');
const dbFile = path.resolve(__dirname, '../lib/core/database/app_database.dart');

if (!fs.existsSync(outDir)) {
  fs.mkdirSync(outDir, { recursive: true });
}

const tsTypeToDartColumn = (type, field) => {
  if (type.includes('string')) return 'TextColumn';
  if (type.includes('number')) return 'RealColumn';
  if (type.includes('boolean')) return 'BoolColumn';
  if (type.includes('Date')) return 'DateTimeColumn';
  return 'TextColumn';
};

const dartColumnMethod = (colType) => {
  switch(colType) {
    case 'TextColumn': return 'text()';
    case 'RealColumn': return 'real()';
    case 'IntColumn': return 'integer()';
    case 'BoolColumn': return 'boolean()';
    case 'DateTimeColumn': return 'dateTime()';
    default: return 'text()';
  }
};

const tables = [];
const files = fs.readdirSync(srcDir).filter(f => f.endsWith('.ts'));

for (const file of files) {
  const content = fs.readFileSync(path.join(srcDir, file), 'utf-8');
  const interfaceRegex = /export interface (\w+)DBModel[\s\S]*?\{([\s\S]*?)\}/g;
  let match;
  while ((match = interfaceRegex.exec(content)) !== null) {
    const className = match[1];
    const body = match[2];
    
    let dartClassName = 'Table' + className;
    let fileName = file.replace('.dbmodel.ts', '').replace(/-/g, '_');
    
    let dataClassName = className;
    if (className === 'Table') {
        dataClassName = 'PosTable';
    }
    
    // Extract custom table name if present
    const tableRegex = /export const \w+DBTable\s*=\s*\{[\s\S]*?name:\s*'([^']+)'/;
    let customTableName = '';
    const tableMatch = tableRegex.exec(content);
    if (tableMatch) {
      customTableName = tableMatch[1];
    }
    
    let dartCode = `import 'package:drift/drift.dart';\n\n`;
    dartCode += `@DataClassName('${dataClassName}')\n`;
    dartCode += `class ${dartClassName} extends Table {\n`;
    
    if (customTableName !== '') {
      dartCode += `  @override\n  String get tableName => '${customTableName}';\n\n`;
    }
    
    const lines = body.split('\n').map(l => l.trim()).filter(l => l && !l.startsWith('//') && !l.startsWith('/*'));
    let hasId = false;
    
    const reservedWords = ['class', 'default', 'final', 'var', 'const', 'new', 'return', 'switch', 'case', 'break', 'continue', 'if', 'else', 'while', 'do', 'for', 'in', 'try', 'catch', 'finally', 'throw', 'rethrow', 'assert', 'extends', 'with', 'implements', 'super', 'this'];
    const driftMethods = ['text', 'integer', 'real', 'boolean', 'dateTime', 'blob'];

    for (const line of lines) {
      if (line.includes('(') || line.includes(')') || line.startsWith('}')) continue;
      const parts = line.split(':');
      if (parts.length < 2) continue;
      let field = parts[0].replace('?', '').trim();
      let type = parts[1].replace(';', '').trim();
      
      let colType = tsTypeToDartColumn(type, field);
      let colMethod = dartColumnMethod(colType);
      let nullable = line.includes('?') ? '.nullable()' : '';
      
      let dartField = field;
      if (reservedWords.includes(field) || driftMethods.includes(field)) {
          dartField = field + 'Field';
      }
      
      let namedStr = '';
      if (dartField !== field) {
          namedStr = `.named('${field}')`;
      }

      if (field === 'id') {
         hasId = true;
         dartCode += `  ${colType} get id => ${colMethod}${namedStr}${nullable}();\n`;
      } else {
         dartCode += `  ${colType} get ${dartField} => ${colMethod}${namedStr}${nullable}();\n`;
      }
    }
    
    if (content.includes('BaseDBModel')) {
      dartCode += `\n  // Base fields\n`;
      dartCode += `  DateTimeColumn get createdAt => dateTime().nullable()();\n`;
      dartCode += `  DateTimeColumn get updatedAt => dateTime().nullable()();\n`;
      dartCode += `  DateTimeColumn get deletedAt => dateTime().nullable()();\n`;
    }
    
    if (hasId) {
       dartCode += `\n  @override\n  Set<Column> get primaryKey => {id};\n`;
    }
    
    dartCode += `}\n`;
    
    fs.writeFileSync(path.join(outDir, `${fileName}.dart`), dartCode);
    tables.push({ dartClassName, fileName });
  }
}

let appDbCode = `import 'package:drift/drift.dart';\nimport 'connection/connection.dart';\n\n`;
for (const table of tables) {
  appDbCode += `import 'tables/${table.fileName}.dart';\n`;
}

appDbCode += `\npart 'app_database.g.dart';\n\n`;
appDbCode += `@DriftDatabase(tables: [\n`;
for (const table of tables) {
  appDbCode += `  ${table.dartClassName},\n`;
}
appDbCode += `])\n`;
appDbCode += `class AppDatabase extends _$AppDatabase {\n`;
appDbCode += `  AppDatabase(String dbName) : super(connectDatabase(dbName));\n\n`;
appDbCode += `  @override\n  int get schemaVersion => 1;\n`;
appDbCode += `}\n`;

fs.writeFileSync(dbFile, appDbCode);
console.log(`Generated ${tables.length} tables and app_database.dart successfully!`);
