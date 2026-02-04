# Documentation

All documentation in the project must be in English language to provide more value for AI.

Style:

Add a space after `//`, for example `// Comment`:

Comments are required in the following cases:

1. Complex or non-obvious solutions that need explanation
2. Class-level documentation describing high-level responsibility
3. Constructor documentation explaining differences between constructors
4. Field documentation when usage or valid values are not obvious
5. Documentation of complex logic sections

Key principles:

- Write self-documenting code where possible
- Avoid documenting implementation details that may change
- Focus on explaining "why" rather than "what" or "how"
- Keep comments concise and clear
- Comments should provide value, not state the obvious
- Update comments when code changes

## Tips

### Avoid duplicating doc strings

If you need to reuse doc strings, e.g. class and default constructor documentation are same, use templates and macros. Macro will insert doc string from template to doc string.

Example:

```dart
/// {@template sentry_error_reporter}
/// An implementation of [ErrorReporter] that reports errors to AppMetrica.
/// {@endtemplate}
class AppMetricaErrorReporter implements ErrorReporter {
  /// {@macro sentry_error_reporter}
  AppMetricaErrorReporter({
    required AppMetricaService appMetricaService,
  }) : _appMetricaService = appMetricaService;
}
```
