import 'package:hr_solutions/features/authentication/controllers/login/forgot_password_controller.dart';
import 'package:hr_solutions/utils/constants/sizes.dart';
import 'package:hr_solutions/utils/constants/text_strings.dart';
import 'package:hr_solutions/utils/validators/c_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Text(
                CTexts.forgotPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              Text(
                CTexts.forgotPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections * 2,
              ),
        
              ///TextField
              SizedBox(
                width: double.infinity,
                child: Form(
                  key: controller.forgotPasswordFormKey,
                  child: TextFormField(
                    controller: controller.email,
                    validator: (value) => CValidation.validateEmail(value),
                    decoration: const InputDecoration(

                        labelText: CTexts.eMail,
                        prefixIcon: Icon(Iconsax.direct_right)),
                  ),
                ),
              ),
        
              const SizedBox(
                height: CSizes.spaceBtwSections ,
              ),
        
              ///submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: const Text(
                      CTexts.submit,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
