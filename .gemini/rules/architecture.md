# Luna POS Architecture Rules

When writing code for the Luna POS project, adhere to the following library constraints:
1. **State Management**: Use `flutter_bloc` exclusively. Do not use Riverpod, Provider, or GetX.
2. **Dependency Injection**: Use `get_it` and `injectable`. Use the `@injectable` and `@singleton` annotations.
3. **Networking**: Use `dio` along with `retrofit` for generating API clients.
4. **Navigation**: Use `go_router` for routing.
5. **Functional Programming**: Use `dartz` (e.g., `Either`, `Option`) for error handling and return types where appropriate.
6. **Data Models**: Use `equatable` for state and model value equality, and `json_serializable` for JSON parsing.
7. **Code Generation**: All generated files must follow the `.g.dart` or `.freezed.dart` conventions.
