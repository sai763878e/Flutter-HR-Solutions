import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/app.dart';
import 'package:hr_solutions/features/language/models/language.dart';
import 'package:hr_solutions/utils/constants/prefernece_constants.dart';
import 'package:hr_solutions/utils/language/app_language_utils.dart';
import 'package:hr_solutions/utils/local_storage/storage_utility.dart';

class ChangeLanguageController extends GetxController {
  static ChangeLanguageController get instance => Get.find();

  final locale = Locale('en').obs;
  final languageList = <Language>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    languageList.value = Language.getLanguageList();
    // languageList.value.map((e) => {
    //       if (e.languageCode.isCaseInsensitiveContains(CLocalStorage()
    //           .readData(PreferenceConstants.selectedLanguageCode)))
    //         {e.isSelected = true}
    //     });

    languageList.value?.forEach((e) {
      if (e.languageCode.isCaseInsensitiveContains(
          CLocalStorage().readData(PreferenceConstants.selectedLanguageCode))) {
        e.isSelected = true;
      }
    });
  }

  changeLanguageSelection(RxList<Language> languages, int index) async {
    for (var row in languages) {
      row.isSelected = false;
    }
    languages[index].isSelected = true;

    //update Locale
    await AppLanguageUtils.setAppLocalization(languages[index].languageCode);
    languages.refresh();
  }
}
