import 'package:hr_solutions/common/widgets/loaders/loaders.dart';
import 'package:hr_solutions/data/repositories/authentication/authentication_repository.dart';

import 'package:hr_solutions/features/authentication/screens/signup/verify_email.dart';
import 'package:hr_solutions/utils/constants/image_strings.dart';
import 'package:hr_solutions/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/device/network_manager.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  ///Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController(); //Conroller for email input
  final lastName = TextEditingController(); //Conroller for last name input
  final userName = TextEditingController(); //Conroller for username input
  final password = TextEditingController(); //Conroller for password input
  final firstName = TextEditingController(); //Conroller for first name input
  final phoneNumber =
      TextEditingController(); //Conroller for phone number input

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  ///--SIgnUp

  void signUp() async {
    try {
      //CHeck Intenet COnnectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (isConnected) {
      } else {

        return;
      }
      // //FOrm Validation
      if (!signUpFormKey.currentState!.validate()) {
        return;
      }

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        CLoader.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create account, you must have to read and accept the Privacy Policy & Terms of Use");
        return;
      }

      //Start Loader
      CFullScreenLoader.openLoadingDialog(
          "We are presenting your information...", CImages.processing);

      //Register user in the Firebase Authentication & save user data in Firebase
      // final userCredentials = await AuthenticationRepository.instance
      //     .registerWithEmailAndPassword(
      //         email.text.trim(), password.text.trim());
      // //Save Authetication user data in Firebase Firestore
      //
      // final newUser = UserModel(
      //     id: userCredentials!.user!.uid,
      //     firstName: firstName.text.trim(),
      //     lastName: lastName.text.trim(),
      //     userName: userName.text.trim(),
      //     email: email.text.trim(),
      //     phoneNumber: phoneNumber.text.trim(),
      //     profilePicture: "");
      //
      // final userRepository = Get.put(UserRepository());
      // await userRepository.saveUserRecord(newUser);

      //remove loader
      CFullScreenLoader.stopLoading();

      //show success message
      CLoader.successSnackBar(
          title: 'Congratulations!',
          message: 'Your account has been created! Verify email to continue.');

      //move to verify email screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      //remove loader
      CFullScreenLoader.stopLoading();
      //SHow some generic error to the user
      CLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
    // finally {
    //
    // }
  }
}
