import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/features/authentication/controllers/employee/employee_view_controller.dart';
import 'package:hr_solutions/features/authentication/screens/signup/widgets/EmployeeFormScreen.dart';
import 'package:hr_solutions/utils/constants/colors.dart';
import 'package:hr_solutions/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/c_validation.dart';
import '../../controllers/sign_up/employee_form_controller.dart';
import '../../models/employeeDO.dart';
import '../signup/employee_add_edit_screen.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeeViewController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Employees Information'),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.to(EmployeeAddEditScreen(
                          employeeDetails: null, newCustomer: true)),
                      child: Text("Add New Employee"),
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade100),
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
                                Text("Employee Name",style: TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.w400),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(empList.value[index].surName,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w600),)
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
                                Text("Employee Number",style: TextStyle().copyWith(fontSize: 12,),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(empList.value[index].employeeNumber,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w700),)
                              ]),

                          SizedBox(width: CSizes.spaceBtwnInputfields,),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status",style: TextStyle().copyWith(fontSize: 12,),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(empList.value[index].status,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w700,color: CColors.primary),)
                              ]),

                          SizedBox(width: CSizes.spaceBtwnInputfields,),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gender",style: TextStyle().copyWith(fontSize: 12,),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(empList.value[index].gender,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w700),)
                              ]),
                          SizedBox(width: CSizes.spaceBtwnInputfields/2,),

                        ],
                      ),
                      SizedBox(
                        height: CSizes.spaceBtwnInputfields,
                      ),

                      Text("Office",style: TextStyle().copyWith(fontSize: 12,),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(empList.value[index].officeName,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w700),),
                      SizedBox(
                        height: CSizes.spaceBtwnInputfields,
                      ),

                      Text("Department",style: TextStyle().copyWith(fontSize: 12,),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(empList.value[index].departmentName,style: TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w700),),
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
