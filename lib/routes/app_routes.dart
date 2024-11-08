
import 'package:get/get.dart';

import '../features/authentication/screens/employee/employees_view.dart';
import '../features/authentication/screens/forgotpassword/forgot_password.dart';
import '../features/authentication/screens/login/login_screen.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import 'CRoutes.dart';

class AppRoutes{
  static final pages = [
    GetPage(name: CRoutes.login, page: () => LoginScreen()),
    // GetPage(name: CRoutes.home, page: () => HomeScreen()),
    GetPage(name: CRoutes.signUp, page: () => SignupScreen()),
    GetPage(name: CRoutes.verifyEmail, page: () => VerifyEmailScreen()),
    GetPage(name: CRoutes.forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: CRoutes.onBoarding, page: () => OnBoardingScreen()),
    GetPage(name: CRoutes.employeeView, page: () => EmployeesView()),

  ];
}