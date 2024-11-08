import 'package:hr_solutions/common/widgets/login_signup/form_divider.dart';
import 'package:hr_solutions/common/widgets/login_signup/social_buttons.dart';
import 'package:hr_solutions/features/authentication/controllers/sign_up/employee_form_controller.dart';
import 'package:hr_solutions/features/authentication/models/employeeDO.dart';
import 'package:hr_solutions/features/authentication/screens/signup/verify_email.dart';
import 'package:hr_solutions/features/authentication/screens/signup/widgets/EmployeeFormScreen.dart';
import 'package:hr_solutions/features/authentication/screens/signup/widgets/sign_up_form.dart';
import 'package:hr_solutions/utils/constants/sizes.dart';
import 'package:hr_solutions/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class EmployeeAddEditScreen extends StatelessWidget {
  EmployeeDO? employeeDetails;
  bool? newCustomer;
  EmployeeAddEditScreen( {super.key,required this.employeeDetails, required  this.newCustomer,});


  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: CSizes.defaultSpace,right: CSizes.defaultSpace,bottom: CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              // Text(
              //   CTexts.signUpTitle,
              //   style: Theme.of(context).textTheme.headlineMedium,
              // ),
              // const SizedBox(
              //   height: CSizes.spaceBtwSections,
              // ),

              ///Form
               EmployeeFormScreen(employeeDetails,newCustomer:newCustomer),

              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              // const CFormDivider(dividerText: CTexts.orSignUp),
              //
              // const SizedBox(
              //   height: CSizes.spaceBtwSections,
              // ),
              //
              // const CSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
