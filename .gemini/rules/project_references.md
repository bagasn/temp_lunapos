# Luna POS Migration & Reference Guidelines

This project is a Flutter rewrite of a legacy React Native POS application. When working on this project, you must refer to the legacy repositories for business logic and database structures.

## Reference Repositories
1. **OldProject (Business Logic)**:
   - **Path**: `/Users/jhonhell/Workspace/LunaProject/LunaPOS/lunapos-mobile`
   - **Stack**: React Native
   - **Usage**: Whenever you need to implement a feature, check this repository to understand the existing business logic and application flow.

2. **MiddleBackend (Database Schema)**:
   - **Path**: `/Users/jhonhell/Workspace/LunaProject/LunaPOS/luna-middle-backend-api`
   - **Stack**: Next.js / Node.js
   - **Usage**: Whenever you need to understand the local database schema, tables, or queries, refer to this repository.

## Architecture Paradigm Shift (CRITICAL)
In the legacy architecture, `OldProject` communicated with the local database via `MiddleBackend` (Client-Server mode on local network).

**In this new Flutter project, the MiddleBackend layer is ELIMINATED.**
- **NO LOCAL BACKEND**: Do NOT create or use any local backend services to manage the local database.
- **DIRECT CONNECTION**: The Flutter application must manage and connect to the local database directly. All database logic previously handled by MiddleBackend must now be integrated directly into the Flutter app's Data layer.
