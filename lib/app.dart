import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/features/authentication/controllers/language/change_language_controller.dart';
import 'package:hr_solutions/features/authentication/screens/splash/splash_screen.dart';
import 'package:hr_solutions/utils/NavigationObserver.dart';
import 'package:hr_solutions/utils/constants/colors.dart';
import 'package:hr_solutions/utils/constants/prefernece_constants.dart';
import 'package:hr_solutions/utils/language/app_language_utils.dart';
import 'package:hr_solutions/utils/local_storage/storage_utility.dart';
import 'package:hr_solutions/utils/theme/theme.dart';
import 'package:hr_solutions/routes/app_routes.dart';
import 'bindings/general_bindings.dart';
import 'data/repositories/authentication/authentication_repository.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<String> preferenceLanguageCode = AppLanguageUtils.getPreferenceLanguage();
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      navigatorObservers: [MyNavigationobserver()],
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale(AppLanguageUtils.getPreferenceLanguage()),
      // set Arabic for testing; later, make this dynamic
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null && supportedLocales.contains(locale)) {
          return locale;
        }
        return supportedLocales.first; // Default to first locale if none match
      },
      home: SplashScreen(),
      // home: const SignupScreen(),
    );
    ;
  }
}
