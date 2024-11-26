import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hr_solutions/utils/constants/prefernece_constants.dart';

import '../local_storage/storage_utility.dart';

class AppLanguageUtils {
  static AppLocalizations? _appLocalization;

  static AppLocalizations get instance =>
      /*_appLocalization ??=*/ AppLocalizations.of(Get.context!)!;

  static setAppLocalization(String code) async {
    await Get.updateLocale(Locale(code));
    await GetStorage().write(PreferenceConstants.selectedLanguageCode, code);
    // _appLocalization = AppLocalizations.of(Get.context!)!;
  }

  static String getPreferenceLanguage(){
    return CLocalStorage().readData(PreferenceConstants.selectedLanguageCode) ?? 'en';
  }
}
