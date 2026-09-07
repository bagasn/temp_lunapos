const fs = require('fs');
const path = require('path');

const dir = '/Users/jhonhell/Workspace/LunaProject/LunaPOS/luna-middle-backend-api/src/sequelize/tables/db-main';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.js'));

const DataTypes = new Proxy({}, {
    get: function(target, prop) {
        if (prop === 'UUIDV4') return 'UUIDV4';
        return prop;
    }
});

const models = {};

const sequelize = {
    define: function(modelName, attributes, options) {
        models[modelName] = attributes;
        return {};
    }
};

for (const file of files) {
    try {
        const defineModel = require(path.join(dir, file));
        defineModel(sequelize, DataTypes);
    } catch (e) {
        console.error(`Error loading ${file}:`, e.message);
    }
}

// Write the parsed models to a JSON file
fs.writeFileSync('sequelize_schema.json', JSON.stringify(models, null, 2));
console.log('Schema extracted to sequelize_schema.json');
