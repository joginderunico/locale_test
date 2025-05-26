import 'package:flutter/material.dart';
import 'package:flutter_base/core/service/language_service.dart'
    show LocalizationService;
import 'package:flutter_base/flutter_base.dart'
    show AppLanguage, AppLanguageExtension;
import 'package:flutter_base/generated/locales.g.dart' show LocaleKeys;
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localizationService = LocalizationService.instance;
  await localizationService.loadTranslations();
  final savedLocale = await localizationService.loadSavedLocale();
  runApp(
    MyApp(savedLocale: savedLocale, localizationService: localizationService),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.savedLocale,
    required this.localizationService,
  });
  final Locale savedLocale;
  final LocalizationService localizationService;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Locale Demo',
      translations: localizationService,
      locale: savedLocale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LocalizationView(),
    );
  }
}

class LocalizationView extends StatelessWidget {
  const LocalizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = LocalizationService.instance;
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.myClasses.tr),
          Text(LocaleKeys.allClasses.tr),
          ElevatedButton(
            onPressed: () async {
              await localizationService.changeLocale(
                AppLanguage.english.languageCode,
              );
            },
            child: const Text('Switch to english'),
          ),
          ElevatedButton(
            onPressed: () async {
              await localizationService.changeLocale(
                AppLanguage.spanish.languageCode,
              );
            },
            child: const Text('Switch to Spanish'),
          ),
          ElevatedButton(
            onPressed: () async {
              await localizationService.changeLocale(
                AppLanguage.arabic.languageCode,
              );
            },
            child: const Text('Switch to Arabic'),
          ),
          DropdownButton<String>(
            value: Get.locale?.languageCode,
            items:
                LocalizationService.supportedLocales
                    .map(
                      (locale) => DropdownMenuItem(
                        value: locale.languageCode,
                        child: Text(locale.languageCode.toUpperCase()),
                      ),
                    )
                    .toList(),
            onChanged: (languageCode) async {
              if (languageCode != null) {
                final localizationService = LocalizationService.instance;
                await localizationService.changeLocale(languageCode);
              }
            },
          ),
        ],
      ),
    );
  }
}
