import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/features/authentication/controllers/employee/employee_view_controller.dart';
import 'package:hr_solutions/features/authentication/controllers/language/change_language_controller.dart';
import 'package:hr_solutions/utils/constants/colors.dart';
import 'package:hr_solutions/utils/constants/sizes.dart';
import 'package:hr_solutions/utils/helpers/helper_functions.dart';
import 'package:hr_solutions/utils/language/app_language_utils.dart';

import '../../../../common/styles/spacing_styles.dart';

import '../../models/employeeDO.dart';
import '../signup/employee_add_edit_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeeViewController());
    // final languageController = Get.find<ChangeLanguageController>();


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           // MyApp.setLocale(context, Locale('en'));
              //           AppLanguageUtils.setAppLocalization('en');
              //
              //           // languageController.setLanguage('en');
              //         }, child: Text('English'),
              //       ),
              //     ),
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           // MyApp.setLocale(context, Locale('ar'));
              //           AppLanguageUtils.setAppLocalization('ar');
              //
              //           // Get.updateLocale(Locale('ar'));
              //           // languageController.setLanguage('ar');
              //         }, child: Text('Arabic'),
              //       ),
              //     ),
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           // MyApp.setLocale(context, Locale('hi'));
              //           AppLanguageUtils.setAppLocalization('hi');
              //           // Get.updateLocale(Locale('hi'));
              //
              //           // languageController.setLanguage('hi');
              //         }, child: Text('Hindi'),
              //       ),
              //     ),
              //   ],
              // ),

              Row(
                children: [
                  Expanded(
                    child: Text(AppLanguageUtils.instance.onBoardingTitle1),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.to(EmployeeAddEditScreen(
                          employeeDetails: null, newCustomer: true)),
                      child: Text(AppLanguageUtils.instance.addNewEmployee),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: CSizes.spaceBtwnInputfields,
              ),

              // EmployeeFormScreen(),
              // EmployeeFormScreen(),

              EmployeeListView(empList: controller.empList)
              // ListView.builder(
              //   itemCount: 4, // Total items in the list
              //   itemBuilder: (BuildContext context, int index) {
              //     return Text('sai'); // Build the widget for each item here
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class Employee {
  final String name;
  final String role;

  Employee(this.name, this.role);
}

class EmployeeListView extends StatelessWidget {
  RxList<EmployeeDO> empList;

  EmployeeListView({super.key, required this.empList});

  @override
  Widget build(BuildContext context) {

    final isDarkMode = CHelperFunction.isDarkMode(context);
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: empList.value.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              EmployeeDO employeeDO = await Get.to(() => EmployeeAddEditScreen(
                  employeeDetails: empList.value[index], newCustomer: false));
              empList.value[index] = employeeDO;
            },
            child: Obx(
              () => Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade100),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLanguageUtils.instance.employeeName,style: TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.w400),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('${empList.value[index].surName} ${empList.value[index].givenName}',style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600),)
                              ]),
                        ],
                      ),
                      SizedBox(
                        height: CSizes.spaceBtwnInputfields,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLanguageUtils.instance.employeeNumber,style: TextStyle().copyWith(fontSize: 12,),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(empList.value[index].employeeNumber,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600),)
                              ]),

                          SizedBox(width: CSizes.spaceBtwnInputfields,),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLanguageUtils.instance.status,style: TextStyle().copyWith(fontSize: 12,),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(empList.value[index].status,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600,color: CColors.primary),)
                              ]),

                          SizedBox(width: CSizes.spaceBtwnInputfields,),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLanguageUtils.instance.gender,style: TextStyle().copyWith(fontSize: 12,),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(empList.value[index].gender,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600),)
                              ]),
                          SizedBox(width: CSizes.spaceBtwnInputfields/2,),

                        ],
                      ),
                      SizedBox(
                        height: CSizes.spaceBtwnInputfields,
                      ),

                      Text(AppLanguageUtils.instance.office,style: TextStyle().copyWith(fontSize: 12,),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(empList.value[index].officeName,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: CSizes.spaceBtwnInputfields,
                      ),

                      Text(AppLanguageUtils.instance.department,style: TextStyle().copyWith(fontSize: 12,),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(empList.value[index].departmentName,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: CSizes.spaceBtwnInputfields,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15,);
        },
      ),
    );
  }
}
