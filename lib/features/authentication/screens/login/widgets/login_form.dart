
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/c_validation.dart';
import '../../../controllers/login/login_controller.dart';
import '../../forgotpassword/forgot_password.dart';
import '../../signup/employee_add_edit_screen.dart';
import '../../signup/widgets/EmployeeFormScreen.dart';
import '../../signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllerLogin = Get.put(LoginController());
    return Form(
        key: controllerLogin.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
          child: Column(
            children: [
              ///Email
              TextFormField(
                controller: controllerLogin.email,
                validator: (value) => CValidation.validateEmptyText('email',value),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.direct_right,
                    ),
                    labelText: CTexts.eMail),
              ),
              const SizedBox(
                height: CSizes.spaceBtwnInputfields,
              ),

              ///Password
              Obx(
                () => TextFormField(
                  controller: controllerLogin.password,
                  validator: (value) => CValidation.validateEmptyText('Password',value),
                  obscureText: controllerLogin.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Iconsax.password_check,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controllerLogin.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                        onPressed: () => controllerLogin.hidePassword.value =
                            !controllerLogin.hidePassword.value,
                      ),
                      labelText: CTexts.password),
                ),
              ),
              const SizedBox(
                height: CSizes.spaceBtwnInputfields / 2,
              ),

              ///Remember me & Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                            value: controllerLogin.rememberPassword.value,
                            onChanged: (value) =>
                                controllerLogin.rememberPassword.value =
                                    !controllerLogin.rememberPassword.value),
                      ),
                      const Text(CTexts.rememberMe),
                    ],
                  ),
                  TextButton(
                      onPressed: () => Get.to(const ForgotPasswordScreen()),
                      child: const Text(CTexts.forgotPassword)),
                ],
              ),

              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              ///signIn Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controllerLogin.loginWithEmailAndPassword(),
                      child: const Text(CTexts.signIn))),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      // onPressed: () => Get.to(SignupScreen()),
                      onPressed: () {}/*=> Get.to(EmployeeAddEditScreen())*/,
                      child: const Text(CTexts.createAccount))),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),
            ],
          ),
        ));
  }
}
