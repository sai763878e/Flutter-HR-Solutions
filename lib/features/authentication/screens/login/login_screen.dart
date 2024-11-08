import 'package:hr_solutions/common/styles/spacing_styles.dart';
import 'package:hr_solutions/common/widgets/login_signup/form_divider.dart';
import 'package:hr_solutions/common/widgets/login_signup/social_buttons.dart';
import 'package:hr_solutions/features/authentication/controllers/login/login_controller.dart';
import 'package:hr_solutions/features/authentication/screens/login/widgets/login_form.dart';
import 'package:hr_solutions/features/authentication/screens/login/widgets/login_header.dart';
import 'package:hr_solutions/utils/constants/sizes.dart';
import 'package:hr_solutions/utils/constants/text_strings.dart';
import 'package:hr_solutions/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final isDark = CHelperFunction.isDarkMode(context);
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Header
              LoginHeader(),

              ///Form
              LoginForm(),

              ///Divider
              CFormDivider(
                dividerText: CTexts.orSignIn,
              ),

              SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              ///Footer
              CSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
