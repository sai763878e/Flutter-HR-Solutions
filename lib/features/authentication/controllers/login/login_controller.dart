
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/prefernece_constants.dart';
import '../../../../utils/device/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //Variables
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final hidePassword = true.obs;
  final rememberPassword = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      //Start Loader
      CFullScreenLoader.openLoadingDialog(
          "Logging you in....", CImages.processing);

      //Check Internet COnnection
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {

        return;
      }

      //form validate
      if (!loginFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      if (rememberPassword.value) {
        localStorage.write(PreferenceConstants.rememberMe, true);
        localStorage.write(
            PreferenceConstants.rememberEmail, email.text.trim());
        localStorage.write(
            PreferenceConstants.rememberPassword, password.text.trim());
      }else{
        localStorage.write(PreferenceConstants.rememberMe, false);

      }

      //login user using
      // final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader
      CFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      //remove loader
      CFullScreenLoader.stopLoading();
      //SHow some generic error to the user
      CLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
