
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/utils/NavigationObserver.dart';
import 'package:hr_solutions/utils/constants/colors.dart';
import 'package:hr_solutions/utils/theme/theme.dart';
import 'package:hr_solutions/routes/app_routes.dart';
import 'bindings/general_bindings.dart';
import 'data/repositories/authentication/authentication_repository.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (true) {
        Get.put(AuthenticationRepository());
        // AuthenticationRepository.instance.screenRedirect();
      }
    });

    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      navigatorObservers: [MyNavigationobserver()],
      home: const Scaffold(
        backgroundColor: CColors.primary,body: Center(child: CircularProgressIndicator(color: Colors.white,),),
      ),
      // home: const SignupScreen(),
    );
  }

}

