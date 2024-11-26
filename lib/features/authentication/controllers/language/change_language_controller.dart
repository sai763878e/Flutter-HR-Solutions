import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/app.dart';
import 'package:hr_solutions/features/language/models/language.dart';
import 'package:hr_solutions/utils/language/app_language_utils.dart';

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
  }

   changeLanguageSelection(RxList<Language> languages,int index) async{
    for (var row in languages) {
      row.isSelected = false;
    }
    languages[index].isSelected = true;

    //update Locale
    await AppLanguageUtils.setAppLocalization(languages[index].languageCode);
    languages.refresh();

  }

}
