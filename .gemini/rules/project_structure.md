# Luna POS Clean Architecture - Feature First

This project strictly follows the **Clean Architecture - Feature First** pattern. You MUST adhere to this directory structure when creating or modifying features:

## Global Directory Structure
- `lib/features/`: Contains all app features. Features may be grouped by domain and contain sub-features (e.g., `lib/features/auth/login`).
- `lib/core/`: Contains generic app-level infrastructure (e.g., `di`, `firebase`, `navigation`, `network`, `theme`).
- `lib/shared/`: Contains shared `widgets`, `utilities`, `services`, and `domain` models used across multiple features.

## Feature Layer Structure
Inside every specific feature or sub-feature (e.g., `lib/features/auth/login/`), you MUST maintain three core layers:

1. **`data/` Layer**
   - `datasources/`: Remote (API/Firebase) or local data sources.
   - `models/`: Data models (JSON serializable/Freezed) that map external data to domain entities.
   - `repositories/`: Concrete implementations of the domain repository interfaces.

2. **`domain/` Layer**
   - `entities/`: Pure Dart objects representing core business models.
   - `repositories/`: Abstract interfaces defining data operations.
   - `usecases/`: Business logic operations. They must execute specific tasks and typically expose a single `call()` method returning `dartz` (e.g., `Future<Either<Failure, Result>>`).

3. **`presentation/` Layer**
   - `bloc/`: State management (Events, States, and Blocs) using `flutter_bloc`.
   - `widgets/`: UI components specific to this feature.
   - `[feature]_page.dart`: The main UI screen/entrypoint for the feature.

**CRITICAL RULES:** 
- **Do NOT bypass layers.** The Presentation layer must only communicate with the Domain layer (via Use Cases).
- The Data layer implements Domain interfaces but the Domain layer must remain independent of Data and Presentation.
