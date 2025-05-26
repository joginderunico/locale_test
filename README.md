# locale_test

# Flutter Localization Example with GetX

This project demonstrates how to implement **internationalization (i18n)** in a Flutter application using **GetX** for state management and localization.

## ✨ Features

* Switch languages dynamically at runtime
* Persist selected language across app launches
* Supports multiple languages using `LocaleKeys` (auto-generated keys from translations)
* Dropdown and buttons to switch between English, Spanish, and Arabic
* Clean separation of localization logic via `LocalizationService`

## 🏗️ Project Structure

```bash
lib/
├── main.dart                          # Entry point
└── flutter_base/
    ├── flutter_base.dart              # AppLanguage and extension
    ├── core/
    │   └── service/
    │       └── language_service.dart  # Localization service (singleton)
    └── generated/
        └── locales.g.dart             # Generated file with translation keys
```

## 🚀 Getting Started

* 1. Initialize localization service before runApp:

```
WidgetsFlutterBinding.ensureInitialized();
final localizationService = LocalizationService.instance;
await localizationService.loadTranslations();
final savedLocale = await localizationService.loadSavedLocale();
```

* 2. Usage:

```
return GetMaterialApp(
    title: 'Flutter Locale Demo',
    translations: localizationService,
    locale: savedLocale,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    home: const YourWidget(),
);
```
