import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_solutions/features/authentication/controllers/employee/employee_view_controller.dart';

import '../routes/CRoutes.dart';

class MyNavigationobserver extends NavigatorObserver{
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    // Check if we are returning to A-screen
    if (previousRoute?.settings.name == "/EmployeesView") {
      // Find the controller for A-screen and refresh data
      final EmployeeViewController controller = Get.find<EmployeeViewController>();
      controller.fetchEmployees(); // Refresh data
    }
  }
}