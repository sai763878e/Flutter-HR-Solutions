import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/authentication/screens/employee/employees_view.dart';
import '../../../features/authentication/screens/login/login_screen.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../../../utils/exceptions/platform_exception.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onReady() {
    // FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    //Local Storage
    if (kDebugMode) {
      print('============GET STORAGE ============');
      print(deviceStorage.read("IsFirstTime"));
    }
    deviceStorage.writeIfNull("IsFirstTime", true);
    deviceStorage.read("IsFirstTime") != true
        ? Get.offAll(() => const EmployeesView())
        : Get.offAll(() => const OnBoardingScreen());
  }

/*--------------------------------- Email & Password Sign In ---------------------------------*/
}
