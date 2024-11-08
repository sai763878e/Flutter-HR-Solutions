import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/features/authentication/models/employeeDO.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../data/repositories/local/database/app_database.dart';

class EmployeeViewController extends GetxController {
  static EmployeeViewController get instance => Get.find();

  final empList = <EmployeeDO>[].obs;

  late Database appDatabase;

  @override
  void onInit() {
    // TODO: implement onInit
      super.onInit();

  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();

    try {
      appDatabase = await AppDatabase.instance;

      await fetchEmployees();
    } catch (e) {}
  }

  Future<bool> fetchEmployees() async {
    empList.value=[];
    try {
      final results = await appDatabase.rawQuery('''
      select * from empform_view
      ''');

      if (results != null) {
        for (var row in results) {
          try{
            EmployeeDO employeeDO = EmployeeDO.fromJson(row);
            empList.value.add(employeeDO);

          }catch(e){
            if (kDebugMode) {
              print(e);
            }
          }
        }
      }

      empList.refresh();

      return true;
    } catch (e) {
      return false;
    }
  }
}
