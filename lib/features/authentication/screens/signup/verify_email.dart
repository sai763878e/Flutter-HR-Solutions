import 'package:hr_solutions/common/widgets/success_screen/success_screen.dart';
import 'package:hr_solutions/data/repositories/authentication/authentication_repository.dart';
import 'package:hr_solutions/features/authentication/controllers/sign_up/verify_email_controller.dart';
import 'package:hr_solutions/features/authentication/screens/login/login_screen.dart';
import 'package:hr_solutions/utils/constants/image_strings.dart';
import 'package:hr_solutions/utils/constants/sizes.dart';
import 'package:hr_solutions/utils/constants/text_strings.dart';
import 'package:hr_solutions/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controllerEmail = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //       onPressed: () => AuthenticationRepository.instance.logOut(),
        //       icon: const Icon(CupertinoIcons.clear))
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                  width: CHelperFunction.screenWidth() * 0.6,
                  height: CHelperFunction.screenHeight() * 0.4,
                  image: const AssetImage(CImages.emailVerify)),

              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              ///Title & SubTitles
              Text(
                CTexts.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              Text(
                CTexts.verifyEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controllerEmail.checkEmailVerificationStatus,
                  child: const Text(CTexts.continue_),
                ),
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controllerEmail.sendEmailVerification,
                  child: const Text(CTexts.resendEmail),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
