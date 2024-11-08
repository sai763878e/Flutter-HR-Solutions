import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hr_solutions/features/authentication/models/employeeDO.dart';
import 'package:hr_solutions/utils/constants/calender_utils.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/repositories/local/database/app_database.dart';

class EmployeeFormController extends GetxController {
  EmployeeDO? employeeDetails;

  EmployeeFormController({required this.employeeDetails});

  static EmployeeFormController get instance => Get.find();

  final TextEditingController surNameController = TextEditingController();
  final TextEditingController yourNameController = TextEditingController();
  final TextEditingController shortNameController = TextEditingController();
  final TextEditingController employeeNumberController =
  TextEditingController();
  final TextEditingController teluguNameController = TextEditingController();
  final TextEditingController officeEmailController = TextEditingController();
  final TextEditingController officePhoneController = TextEditingController();
  final TextEditingController workMobileController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController testScoreController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  final TextEditingController dobController = TextEditingController();
  final TextEditingController dojController = TextEditingController();
  final TextEditingController domController = TextEditingController();
  final TextEditingController joiningDate = TextEditingController();
  final TextEditingController officeTime = TextEditingController();

  // Variables for dropdowns and other selections
  final status = "New".obs;
  DateTime? birthDate;
  DateTime? marriageDate;

  GlobalKey<FormState> employeeFormKey = GlobalKey<FormState>();

  final titleList = ["Others"].obs;
  final title = "Others".obs;

  final supervisorList = [""].obs;
  final supervisor = "".obs;

  final managerList = [""].obs;
  final manager = "".obs;

  final officeList = [""].obs;
  final office = "".obs;

  final departmentList = [""].obs;
  final department = "".obs;

  final employmentTypeList = [""].obs;
  final employmentType = "".obs;

  final genderList = [""].obs;
  final gender = "".obs;

  final skillsList = [].obs;

  final weekendList = [].obs;

  final employeeTileLabel = "EmployeeTitle";
  final employeeTypeLabel = "EmployeeType";
  final genderLabel = "Gender";
  final skillsLabel = "Skills";
  final weekendLabel = "Weekend";

  final editAccess = true.obs;
  bool newCustomer = true;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  late Database appDatabase;


  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();

    try {
      await AppDatabase.instance.then((value) {
        appDatabase = value;
      });


      await fetchTitles(employeeTileLabel, titleList, title);
      await fetchTitles(genderLabel, genderList, gender);
      await fetchTitles(employeeTypeLabel, employmentTypeList, employmentType);
      await fetchMultiSelectionList(skillsLabel, skillsList);
      await fetchMultiSelectionList(weekendLabel, weekendList);

      await getAllEmployees("", supervisorList, supervisor);
      await getAllEmployees("", managerList, manager);

      await getAllOffices("", officeList, office);
      await getAllDepartments("", departmentList, department);

      if (employeeDetails != null) {
        editAccess.value = false;
        newCustomer=false;

        title.value = employeeDetails!.title;
        surNameController.text = employeeDetails!.surName;
        yourNameController.text = employeeDetails!.givenName;
        shortNameController.text = employeeDetails!.shortName;
        teluguNameController.text = employeeDetails!.teluguName;

        gender.value = employeeDetails!.gender;
        employeeNumberController.text =
            employeeDetails!.employeeNumber;

        status.value = employeeDetails!.status;
        dobController.text =
        employeeDetails!.birthDate.isEmpty ? "" : DateFormat(
            CalenderUtils.previewDDMMMYYYYDP).format(
            DateFormat(CalenderUtils.standardYYYYMMDDDP).parse(
                employeeDetails!.birthDate));
        dojController.text =
        employeeDetails!.joiningDate.isEmpty ? "" : DateFormat(
            CalenderUtils.previewDDMMMYYYYDP).format(
            DateFormat(CalenderUtils.standardYYYYMMDDDP).parse(
                employeeDetails!.joiningDate));
        domController.text =
        employeeDetails!.marriageDate.isEmpty ? "" : DateFormat(
            CalenderUtils.previewDDMMMYYYYDP).format(
            DateFormat(CalenderUtils.standardYYYYMMDDDP).parse(
                employeeDetails!.marriageDate));

        officeEmailController.text = employeeDetails!.officeEmail;
        officePhoneController.text = employeeDetails!.officePhone;
        workMobileController.text = employeeDetails!.workMobile;

        supervisor.value =
        '${employeeDetails!.supervisorName} | ${employeeDetails!
            .supervisorFkEmployeeTuid}';
        manager.value =
        '${employeeDetails!.managerName} | ${employeeDetails!
            .managerFkEmployeeTuid}';
        office.value =
        '${employeeDetails!.officeCode} - ${employeeDetails!
            .officeName} | ${employeeDetails!.fkOfficeTuid}';
        department.value =
        '${employeeDetails!.departmentCode} - ${employeeDetails!
            .departmentName} | ${employeeDetails!.fkDepartmentTuid}';

        if (supervisor.value.isEmpty ||
            employeeDetails!.supervisorFkEmployeeTuid.isEmpty) {
          supervisor.value = "";
          // supervisorList.value = [""];
        }

        if (manager.value.isEmpty ||
            employeeDetails!.managerFkEmployeeTuid.isEmpty) {
          manager.value = "";
          // managerList.value = [""];
        }

        if (office.value.isEmpty ||
            employeeDetails!.fkOfficeTuid.isEmpty) {
          office.value = "";
          // officeList.value = [""];
        }

        if (department.value.isEmpty ||
            employeeDetails!.fkDepartmentTuid.isEmpty) {
          department.value = "";
          // departmentList.value = [""];
        }


        employmentType.value = employeeDetails!.employmentType;
        testScoreController.text = employeeDetails!.testScore.toString();
        salaryController.text = employeeDetails!.salary.toString();
        linkedinController.text = employeeDetails!.linkedin.toString();
        remarksController.text = employeeDetails!.remarks.toString();


        joiningDate.text = employeeDetails!.joiningDatetime ?? "";
        officeTime.text = employeeDetails!.officeTime ?? "";

        if (skillsList.value != null && skillsList.value.isNotEmpty) {
          final list = employeeDetails!.skills.split(',');
          for (var ele in list) {
            for (int i = 0; i < skillsList.value.length; i++) {
              if (skillsList.value[i]['id'].contains(ele)) {
                skillsList.value[i]['selected'] = true;
              }
            }
          }
        }

        if (weekendList.value != null && weekendList.value.isNotEmpty) {
          final list = employeeDetails!.weekend.split(',');
          for (var ele in list) {
            for (int i = 0; i < weekendList.value.length; i++) {
              if (weekendList.value[i]['id'].contains(ele)) {
                weekendList.value[i]['selected'] = true;
              }
            }
          }
        }

        skillsList.refresh();
        weekendList.refresh();
      } else {

      }

      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> fetchTitles(String type, RxList<String> list,
      RxString title) async {
    try {
      final results = await appDatabase.rawQuery('''
      SELECT value as id,description as label FROM list_item 
WHERE fk_list_name_tuid = (select tuid from list_name where list_name = ?) order by serial_number
      ''', [type]);

      if (results != null) {
        list.value = [];
        title.value = "";

        for (var row in results) {
          if (row['id'] != null) {
            list.value.add(row['label'] as String);
          }
        }

        if (list != null && list.isNotEmpty) {
          title.value = list.value[0];
        }

        list.refresh();
        title.refresh();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> fetchMultiSelectionList(String type, RxList skillsList,) async {
    try {
      List<Map<String, dynamic>> results = await appDatabase.rawQuery('''
      SELECT value as id,description as label FROM list_item 
WHERE fk_list_name_tuid = (select tuid from list_name where list_name = ?) order by serial_number
      ''', [type]);

      if (results != null) {
        skillsList.value = [];


        for (var row in results) {
          var data = {
            'label': row['label'] as String,
            'selected': false,
            'id': row['id'] as String
          };
          skillsList.value.add(data);
        }


        skillsList.refresh();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllEmployees(String type, RxList<String> list,
      RxString title) async {
    try {
      final results = await appDatabase.rawQuery('''
      select * from empform_view
      ''');

      if (results != null) {
        list.value = [""];
        title.value = "";

        for (var row in results) {
          if (row['employee_number'] != null) {
            list.value.add(
                '${row['employee_number'] as String} - ${row['sur_name'] as String} ${row['given_name'] as String} | ${row['tuid'] as String}');
          }
        }

        if (list != null && list.isNotEmpty) {
          title.value = list.value[0];
        }

        list.refresh();
        title.refresh();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllOffices(String type, RxList<String> list,
      RxString title) async {
    try {
      final results = await appDatabase.rawQuery('''
      select * from office
      ''');

      if (results != null) {
        list.value = [""];
        title.value = "";

        for (var row in results) {
          if (row['code'] != null) {
            list.value.add(
                '${row['code'] as String} - ${row['name'] as String} | ${row['tuid'] as String}');
          }
        }

        if (list != null && list.isNotEmpty) {
          title.value = list.value[0];
        }

        list.refresh();
        title.refresh();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllDepartments(String type, RxList<String> list,
      RxString title) async {
    try {
      final results = await appDatabase.rawQuery('''
      select * from department
      ''');

      if (results != null) {
        list.value = [""];
        title.value = "";

        for (var row in results) {
          if (row['code'] != null) {
            list.value.add(
                '${row['code'] as String} - ${row['name'] as String} | ${row['tuid'] as String}');
          }
        }

        if (list != null && list.isNotEmpty) {
          title.value = list.value[0];
        }

        list.refresh();
        title.refresh();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  void createAccount() async {
    try {
      // Form Validation
      // if (!employeeFormKey.currentState!.validate()) {
      //   return;
      // }

      List<String> selectedSkills = [];
      List<String> selectedWeekends = [];

      for (var skill in skillsList) {
        if (skill['selected']) {
          selectedSkills.add(skill['id']);
        }
      }

      for (var weekend in weekendList) {
        if (weekend['selected']) {
          selectedWeekends.add(weekend['id']);
        }
      }

      String tuid = const Uuid().v4();
      if (employeeDetails != null) tuid = employeeDetails!.tuid;

      int insertedStatus = await insertEmployee(tuid: tuid,
          status: status.value,
          rss: "1",
          fkOrgTuid: "548f5ebe-5d62-47a9-be87-1d7ebcdc20ad",
          //TODO no idea
          title: title.value,
          surName: surNameController.text.trim(),
          givenName: yourNameController.text.trim(),
          shortName: shortNameController.text.trim(),
          employeeNumber: employeeNumberController.text.trim(),
          teluguName: teluguNameController.text.trim(),
          gender: gender.value,
          employmentType: employmentType.value,
          birthDate: dobController.text.isEmpty ? "" : DateFormat(
              CalenderUtils.standardYYYYMMDDDP).format(
              DateFormat(CalenderUtils.previewDDMMMYYYYDP).parse(
                  dobController.text.trim())),
          joiningDate: dojController.text.isEmpty ? "" : DateFormat(
              CalenderUtils.standardYYYYMMDDDP).format(
              DateFormat(CalenderUtils.previewDDMMMYYYYDP).parse(
                  dojController.text.trim())),
          marriageDate: domController.text.isEmpty ? "" : DateFormat(
              CalenderUtils.standardYYYYMMDDDP).format(
              DateFormat(CalenderUtils.previewDDMMMYYYYDP).parse(
                  domController.text.trim())),
          officeEmail: officeEmailController.text.trim(),
          officePhone: officePhoneController.text.trim(),
          workMobile: workMobileController.text.trim(),
          supervisorFkEmployeeTuid: supervisor.value.isEmpty ? "" : supervisor
              .value.split('|')[1].trim(),
          //TODO need to chanfe ro uuid
          managerFkEmployeeTuid: manager.value.isEmpty ? "" : manager.value
              .split('|')[1].trim(),
          fkOfficeTuid: office.value.isEmpty ? "" : office.value.split('|')[1]
              .trim(),
          fkDepartmentTuid: department.value.isEmpty ? "" : department.value
              .split('|')[1].trim(),
          remarks: remarksController.text.trim(),
          linkedin: linkedinController.text.trim(),
          skills: selectedSkills.isEmpty ? "" : selectedSkills.toList().join(
              ', '),
          weekend: selectedWeekends.isEmpty ? "" : selectedWeekends.toList()
              .join(', '),
          lct: DateFormat(CalenderUtils.previewDDMMMYYYYHHMMSSDP).format(
              DateTime.now()),
          lmt: DateFormat(CalenderUtils.previewDDMMMYYYYHHMMSSDP).format(
              DateTime.now()),
          sct: "null",
          smt: "null",
          testScore: testScoreController.text.isEmpty ? 0 :double.tryParse(testScoreController.text.trim()),
          salary: salaryController.text.isEmpty ? 0 :double.tryParse(salaryController.text.trim()),
          officeTime: officeTime.text,
          joiningDatetime: joiningDate.text);

      showCustomDialog();
    } catch (e) {}
  }

  Future<int> insertEmployee({
    required String tuid,
    required String status,
    required String rss,
    required String fkOrgTuid,
    required String title,
    required String surName,
    required String givenName,
    required String shortName,
    required String employeeNumber,
    required String teluguName,
    required String gender,
    required String employmentType,
    required String birthDate,
    required String joiningDate,
    required String marriageDate,
    required String officeEmail,
    required String officePhone,
    required String workMobile,
    required String supervisorFkEmployeeTuid,
    required String managerFkEmployeeTuid,
    required String fkOfficeTuid,
    required String fkDepartmentTuid,
    required String remarks,
    required String linkedin,
    required String skills,
    required String weekend,
    required String lct,
    required String lmt,
    required String sct,
    required String smt,
    required double? testScore,
    required double? salary,
    required String officeTime,
    required String joiningDatetime,
  }) async {
    final data = {
      'tuid': tuid,
      'status': status,
      'rss': rss,
      'fk_org_tuid': fkOrgTuid,
      'title': title,
      'sur_name': surName,
      'given_name': givenName,
      'short_name': shortName,
      'employee_number': employeeNumber,
      'telugu_name': teluguName,
      'gender': gender,
      'employment_type': employmentType,
      'birth_date': birthDate,
      'joining_date': joiningDate,
      'marriage_date': marriageDate,
      'office_email': officeEmail,
      'office_phone': officePhone,
      'work_mobile': workMobile,
      'supervisor_fk_employee_tuid': supervisorFkEmployeeTuid,
      'manager_fk_employee_tuid': managerFkEmployeeTuid,
      'fk_office_tuid': fkOfficeTuid,
      'fk_department_tuid': fkDepartmentTuid,
      'remarks': remarks,
      'linkedin_linkedin': linkedin,
      'skills': skills,
      'weekend': weekend,
      'lct': lct,
      'lmt': lmt,
      'sct': sct,
      'smt': smt,
      'test_score': testScore,
      'salary': salary,
      'office_time': officeTime,
      'joining_datetime': joiningDatetime,
    };
    return await AppDatabase.insertOrUpdateRow(
        appDatabase, data, 'tuid', 'empform');
  }

  void showCustomDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(

        title: Text("Success"),
        content: Text(newCustomer ? "Employee Data Added Successfully" : "Employee Data Updated Successfully"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();// Close dialog
            },
            child: Text("Done"),
          ),
        ],
      ),
    );
  }
}
