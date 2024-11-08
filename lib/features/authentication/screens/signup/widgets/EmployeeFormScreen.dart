import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hr_solutions/features/authentication/controllers/sign_up/employee_form_controller.dart';
import 'package:hr_solutions/features/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:hr_solutions/features/authentication/models/employeeDO.dart';
import 'package:hr_solutions/utils/validators/c_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/calender_utils.dart';

class EmployeeFormScreen extends StatelessWidget {
  EmployeeDO? employeeDetails;
  bool? newCustomer;

  EmployeeFormScreen(
    this.employeeDetails, {
    required this.newCustomer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunction.isDarkMode(context);
    final FocusNode _focusNode = FocusNode();

    final controller =
        Get.put(EmployeeFormController(employeeDetails: employeeDetails));
    final GlobalKey<FormFieldState<String>> _testScoreKey =
        GlobalKey<FormFieldState<String>>();
    final GlobalKey<FormFieldState<String>> _salaryKey =
        GlobalKey<FormFieldState<String>>();

    void hideKeyboard() {
      _focusNode.unfocus();
    }

    return Form(
        key: controller.employeeFormKey,
        child: Column(
          children: [
            Row(children: [
              Expanded(child: Text("")),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  controller.editAccess.value = true;
                },
                child: Text("Edit"),
              ))
            ]),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Obx(
                      () => DropdownButtonFormField(
                        onTap: () {},
                        validator: (value) => CValidation.validateDropDownText(
                            CTexts.empTitle, value),
                        decoration: InputDecoration(
                          enabled: true,
                          labelText: CTexts.empTitle,
                          // Set the label here
                          border: OutlineInputBorder(),
                        ),
                        value: controller.title.value,
                        items: controller.titleList.map((uom) {
                          return DropdownMenuItem(value: uom, child: Text(uom));
                        }).toList(),
                        onChanged: controller.editAccess.value
                            ? (value) {
                                controller.title.value = value as String;
                              }
                            : null,
                      ),
                    )),
                SizedBox(
                  width: CSizes.spaceBtwnInputfields,
                ),
                Expanded(
                  flex: 5,
                  child: Obx(
                    () => TextFormField(
                      // enabled: controller.editAccess.value,
                      readOnly: !controller.editAccess.value,
                      validator: (value) => CValidation.validateInputText(
                          fieldName: CTexts.surName,
                          value: value,
                          minRange: 3,
                          maxRange: 100),
                      controller: controller.surNameController,
                      decoration: InputDecoration(
                          hintText: "Enter your ${CTexts.surName}",
                          hintStyle: TextStyle().copyWith(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 10),
                          prefixIcon: Icon(
                            Iconsax.user,
                            size: 18,
                          ),
                          labelText: CTexts.surName),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            ///username
            Obx(
              () => TextFormField(
                readOnly: !controller.editAccess.value,
                controller: controller.yourNameController,
                validator: (value) => CValidation.validateInputText(
                    fieldName: CTexts.yourName,
                    value: value,
                    minRange: 3,
                    maxRange: 100),
                expands: false,
                decoration: InputDecoration(
                    hintText: "Enter your ${CTexts.yourName}",
                    hintStyle: const TextStyle().copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 10),
                    labelText: CTexts.yourName,
                    prefixIcon: Icon(
                      Iconsax.user,
                      size: 18,
                    )),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            ///first & last name
            Row(
              children: [
                Expanded(
                    child: Obx(
                  () => TextFormField(
                    readOnly: !controller.editAccess.value,
                    controller: controller.shortNameController,
                    validator: (value) => CValidation.validateInputText(
                        fieldName: CTexts.shortName,
                        value: value,
                        minRange: 3,
                        maxRange: 10),
                    expands: false,
                    decoration: InputDecoration(
                        hintText: "Enter your ${CTexts.shortName}",
                        hintStyle: const TextStyle().copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                        labelText: CTexts.shortName,
                        // prefix: Icon(
                        //   Iconsax.user,
                        //   size: 18,
                        // ),
                        prefixIcon: Icon(
                          Iconsax.user,
                          size: 18,
                        )),
                  ),
                )),
                const SizedBox(
                  width: CSizes.spaceBtwnInputfields,
                ),
                Expanded(
                    child: Obx(
                  () => TextFormField(
                    readOnly: !controller.editAccess.value,
                    controller: controller.teluguNameController,
                    validator: (value) => CValidation.validateInputText(
                        fieldName: CTexts.teluguName,
                        value: value,
                        minRange: 3,
                        maxRange: 10,
                        specialCharacters: false),
                    expands: false,
                    decoration: InputDecoration(
                        hintText: "Enter your ${CTexts.teluguName}",
                        hintStyle: const TextStyle().copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                        labelText: CTexts.teluguName,
                        prefixIcon: Icon(
                          Iconsax.user,
                          size: 18,
                        )),
                  ),
                )),
              ],
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: CTexts.gender, // Set the label here
                  border: OutlineInputBorder(),
                ),
                value: controller.gender.value,
                items: controller.genderList.map((uom) {
                  return DropdownMenuItem(value: uom, child: Text(uom));
                }).toList(),
                onChanged: controller.editAccess.value
                    ? (value) {
                        controller.gender.value = value! as String;
                      }
                    : null,
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            ///username
            Obx(
              () => TextFormField(
                enabled: newCustomer,
                readOnly: !controller.editAccess.value,
                controller: controller.employeeNumberController,
                validator: (value) => CValidation.validateInputText(
                    fieldName: CTexts.empNumber,
                    value: value,
                    minRange: 3,
                    maxRange: 10,
                    specialCharacters: false,
                    spaces: false,
                    utfCharacters: false),
                expands: false,
                decoration: InputDecoration(
                    hintText: "Enter your ${CTexts.empNumber}",
                    hintStyle: const TextStyle().copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 10),
                    labelText: CTexts.empNumber,
                    prefixIcon: Icon(Iconsax.user_edit, size: 18)),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Row(children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 20, top: 0, right: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CTexts.empStatus,
                      style: const TextStyle().copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    Obx(
                      () => Text(
                        controller.status.value,
                        style: const TextStyle().copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(
                width: CSizes.spaceBtwnInputfields,
              ),
              Expanded(
                child: DatePickerWidget(
                  label: CTexts.dateOfBirth,
                  onDateSelected: (date) => (),
                  textController: controller.dobController,
                  controller: controller,
                ),
              ),
            ]),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Row(children: [
              Expanded(
                child: DatePickerWidget(
                  label: CTexts.dateOfJoining,
                  onDateSelected: (date) => (),
                  textController: controller.dojController,
                  controller: controller,
                ),
              ),
              SizedBox(
                width: CSizes.spaceBtwnInputfields,
              ),
              Expanded(
                child: DatePickerWidget(
                  label: CTexts.dateOfMarriage,
                  onDateSelected: (date) => (),
                  textController: controller.domController,
                  controller: controller,
                ),
              ),
            ]),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => TextFormField(
                readOnly: !controller.editAccess.value,
                controller: controller.officeEmailController,
                validator: (value) => CValidation.validateEmail(value),
                expands: false,
                decoration: InputDecoration(
                    hintText: "Enter your ${CTexts.officeMail}",
                    hintStyle: const TextStyle().copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 10),
                    labelText: CTexts.officeMail,
                    prefixIcon: Icon(
                      Iconsax.user_edit,
                      size: 18,
                    )),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Row(
              children: [
                Expanded(
                    child: Obx(
                  () => TextFormField(
                    readOnly: !controller.editAccess.value,
                    controller: controller.officePhoneController,
                    validator: (value) =>
                        CValidation.validatePhoneNumber(value),
                    expands: false,
                    decoration: InputDecoration(
                        hintText: "Enter your ${CTexts.officePhone}",
                        hintStyle: const TextStyle().copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                        labelText: CTexts.officePhone,
                        prefixIcon: Icon(
                          Iconsax.user,
                          size: 18,
                        )),
                  ),
                )),
                const SizedBox(
                  width: CSizes.spaceBtwnInputfields,
                ),
                Expanded(
                    child: Obx(
                  () => TextFormField(
                    readOnly: !controller.editAccess.value,
                    controller: controller.workMobileController,
                    validator: (value) =>
                        CValidation.validatePhoneNumber(value),
                    expands: false,
                    decoration: InputDecoration(
                        hintText: "Enter your ${CTexts.workMobile}",
                        hintStyle: const TextStyle().copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                        labelText: CTexts.workMobile,
                        prefixIcon: Icon(
                          Iconsax.user,
                          size: 18,
                        )),
                  ),
                )),
              ],
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: CTexts.supervisor, // Set the label here
                  border: OutlineInputBorder(),
                ),
                value: controller.supervisor.value,
                items: controller.supervisorList.map((uom) {
                  return DropdownMenuItem(
                      value: uom,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        uom.split('|')[0],
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .labelMedium!
                        //     .apply(
                        //         overflow: TextOverflow.ellipsis,
                        //         color: Colors.black),
                      ));
                }).toList(),
                onChanged: !controller.editAccess.value
                    ? null
                    : (value) {
                        controller.supervisor.value = value! as String;
                      },
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: CTexts.manager, // Set the label here
                  border: OutlineInputBorder(),
                ),
                value: controller.manager.value,
                items: controller.managerList.map((uom) {
                  return DropdownMenuItem(
                      value: uom,
                      child: Text(
                        uom.split('|')[0],
                        overflow: TextOverflow.ellipsis,
                      ));
                }).toList(),
                onChanged: !controller.editAccess.value
                    ? null
                    : (value) {
                        controller.manager.value = value! as String;
                      },
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: CTexts.office, // Set the label here
                  border: OutlineInputBorder(),
                ),
                value: controller.office.value,
                items: controller.officeList.map((uom) {
                  return DropdownMenuItem(
                      value: uom,
                      child: Text(
                        uom.split('|')[0],
                        overflow: TextOverflow.ellipsis,
                      ));
                }).toList(),
                onChanged: !controller.editAccess.value
                    ? null
                    : (value) {
                        controller.office.value = value! as String;
                      },
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: CTexts.department, // Set the label here
                  border: OutlineInputBorder(),
                ),
                value: controller.department.value,
                items: controller.departmentList.map((uom) {
                  return DropdownMenuItem(
                      value: uom,
                      child: Text(
                        uom.split('|')[0],
                        overflow: TextOverflow.ellipsis,
                      ));
                }).toList(),
                onChanged: !controller.editAccess.value
                    ? null
                    : (value) {
                        controller.department.value = value! as String;
                      },
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: CTexts.employmentType, // Set the label here
                  border: OutlineInputBorder(),
                ),
                value: controller.employmentType.value,
                items: controller.employmentTypeList.map((uom) {
                  return DropdownMenuItem(value: uom, child: Text(uom));
                }).toList(),
                onChanged: !controller.editAccess.value
                    ? null
                    : (value) {
                        controller.employmentType.value = value! as String;
                      },
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Row(
              children: [
                Expanded(
                    child: Obx(
                  () => TextFormField(
                    readOnly: !controller.editAccess.value,
                    key: _testScoreKey,
                    keyboardType: TextInputType.number,
                    controller: controller.testScoreController,
                    validator: (value) =>
                        CValidation.validateTestScore(CTexts.testScore, value),
                    onChanged: (value) {
                      _testScoreKey.currentState!.validate();
                    },
                    expands: false,
                    decoration: InputDecoration(
                        hintText: "Enter your ${CTexts.testScore}",
                        hintStyle: const TextStyle().copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                        labelText: CTexts.testScore,
                        prefixIcon: Icon(
                          Iconsax.user,
                          size: 18,
                        )),
                  ),
                )),
                const SizedBox(
                  width: CSizes.spaceBtwnInputfields,
                ),
                Expanded(
                    child: Obx(
                  () => TextFormField(
                    readOnly: !controller.editAccess.value,
                    key: _salaryKey,
                    keyboardType: TextInputType.number,
                    controller: controller.salaryController,
                    validator: (value) =>
                        CValidation.validateSalary(CTexts.salary, value),
                    onChanged: (value) {
                      _salaryKey.currentState!.validate();
                    },
                    expands: false,
                    decoration: InputDecoration(
                        hintText: "Enter your ${CTexts.salary}",
                        hintStyle: const TextStyle().copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                        labelText: CTexts.salary,
                        prefixIcon: Icon(
                          Iconsax.user,
                          size: 18,
                        )),
                  ),
                )),
              ],
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => TextFormField(
                readOnly: !controller.editAccess.value,
                controller: controller.linkedinController,
                validator: (value) =>
                    CValidation.validateUrl(CTexts.linkedin, value),
                expands: false,
                decoration: InputDecoration(
                    hintText: "Enter your ${CTexts.linkedin}",
                    hintStyle: const TextStyle().copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 10),
                    labelText: CTexts.linkedin,
                    prefixIcon: Icon(
                      Iconsax.user,
                      size: 18,
                    )),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => TextFormField(
                readOnly: !controller.editAccess.value,
                controller: controller.remarksController,
                validator: (value) =>
                    CValidation.validateRemarks(CTexts.remarks, value),
                // expands: true,
                maxLines: 20,
                minLines: 5,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    // filled: true,
                    // fillColor: Colors.grey.shade200,
                    labelText: CTexts.remarks,
                    labelStyle: TextStyle().copyWith()),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            //Skills
            Obx(
              () => ExpansionTile(
                title: Text('Skills'),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                    child: Wrap(
                      spacing: 10,
                      verticalDirection: VerticalDirection.down,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List.generate(
                          controller.skillsList.value.length, (index) {
                        return InputChip(
                          label: Text(
                              controller.skillsList.value[index]['label'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.black, fontSize: 14)),
                          onPressed: () {
                            controller.skillsList.value[index]['selected'] =
                                !controller.skillsList.value[index]['selected'];
                            controller.skillsList.refresh();
                          },
                          selected: controller.skillsList.value[index]
                              ['selected'],
                          selectedColor: Colors.indigo.withOpacity(0.3),
                          disabledColor: Colors.grey.shade100,

                          isEnabled: controller.editAccess.value,

                          // onDeleted: (){
                          //
                          // },
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            //Weekends
            Obx(
              () => ExpansionTile(
                title: Text('Weekends'),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                    child: Wrap(
                      spacing: 10,
                      verticalDirection: VerticalDirection.down,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List.generate(
                          controller.weekendList.value.length, (index) {
                        return InputChip(
                          label: Text(
                              controller.weekendList.value[index]['label'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.black, fontSize: 14)),
                          onPressed: () {
                            controller.weekendList.value[index]['selected'] =
                                !controller.weekendList.value[index]
                                    ['selected'];
                            controller.weekendList.refresh();
                          },
                          selected: controller.weekendList.value[index]
                              ['selected'],
                          selectedColor: Colors.indigo.withOpacity(0.3),
                          isEnabled: controller.editAccess.value,
                          disabledColor: Colors.grey.shade100,

                          // onDeleted: (){
                          //
                          // },
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            DateTimePickerWidget(
              label: CTexts.joiningDateTime,
              onDateSelected: (date) => (),
              textController: controller.joiningDate,
              controller: controller,
            ),
            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            Obx(
              () => TextFormField(
                readOnly: !controller.editAccess.value,
                focusNode: _focusNode,
                controller: controller.officeTime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${CTexts.officeTime} is mandatory';
                  }

                  return null;
                },
                onTap: !controller.editAccess.value
                    ? () {}
                    : () async {
                        hideKeyboard();

                        final time = await showTimePicker(
                            context: context,
                            builder: (context, child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              );
                            },
                            initialTime: controller.officeTime.text.isEmpty
                                ? TimeOfDay.fromDateTime(DateTime.now())
                                : CalenderUtils.getTime(
                                    CalenderUtils.timeHHMMSS,
                                    controller.officeTime.text));

                        if (time == null) return;

                        controller.officeTime.text =
                            '${time.hour}:${time.minute}:00';
                      },
                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  alignLabelWithHint: true,
                  // filled: true,
                  // fillColor: Colors.grey.shade200,
                  labelText: CTexts.officeTime,
                  // labelStyle: TextStyle().copyWith()
                ),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),

            //SignInButton
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.createAccount,
                child: Text("Create Employee",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600)),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtwnInputfields,
            ),
          ],
        ));
  }
}

// Additional widgets for date picker, time picker, radio group, etc.
class DatePickerWidget extends StatelessWidget {
  final String label;
  final Function(DateTime) onDateSelected;
  final TextEditingController textController;
  final EmployeeFormController controller;

  DatePickerWidget({
    super.key,
    required this.label,
    required this.onDateSelected,
    required this.textController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();

    void _hideKeyboard() {
      // Unfocus the FocusNode to hide the keyboard
      _focusNode.unfocus();
    }

    String? validate(String value) {
      switch (label) {
        case CTexts.dateOfBirth:
          return CValidation.validateEmptyText(
            CTexts.dateOfBirth,
            value,
          );
        case CTexts.dateOfJoining:
          return CValidation.validateJoiningDate(CTexts.dateOfJoining, value!,
              controller.dojController.text, CalenderUtils.previewDDMMMYYYYDP);
        case CTexts.dateOfMarriage:
          return CValidation.validateJoiningDate(CTexts.dateOfMarriage, value!,
              controller.domController.text, CalenderUtils.previewDDMMMYYYYDP);
      }
    }

    DateTime getDate(String pattern, String date) {
      return DateFormat(pattern).parse(date);
    }

    return Obx(
      () => TextFormField(
        readOnly: !controller.editAccess.value,
        focusNode: _focusNode,
        controller: textController,
        validator: (value) => validate(value!),
        onTap: !controller.editAccess.value
            ? () {}
            : () async {
                _hideKeyboard();
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: textController.text.isEmpty
                      ? DateTime.now()
                      : getDate(CalenderUtils.previewDDMMMYYYYDP,
                          textController.text),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  selectableDayPredicate: (DateTime day) {
                    if (label == CTexts.dateOfJoining ||
                        label == CTexts.dateOfMarriage) {
                      // Ensure that the days before 05-11-2024 are not selectable
                      if (day.isBefore(
                          DateFormat(CalenderUtils.previewDDMMMYYYYDP)
                              .parse(controller.dobController.text!))) {
                        return false; // Block dates before 05-11-2024
                      }
                      return true;
                    }

                    return true; // Allow dates on or after 05-11-2024
                  },
                );
                if (date != null) {
                  // onDateSelected(date);
                  // textController.text = date as String;
                  textController.text =
                      DateFormat(CalenderUtils.previewDDMMMYYYYDP).format(date);
                }
              },
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          alignLabelWithHint: true,
          // filled: true,
          // fillColor: Colors.grey.shade200,
          labelText: label,
          // labelStyle: TextStyle().copyWith()
        ),
      ),
    );
  }
}

class DateTimePickerWidget extends StatelessWidget {
  final String label;
  final Function(DateTime) onDateSelected;
  final TextEditingController textController;
  final EmployeeFormController controller;

  DateTimePickerWidget({
    super.key,
    required this.label,
    required this.onDateSelected,
    required this.textController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();

    void _hideKeyboard() {
      // Unfocus the FocusNode to hide the keyboard
      _focusNode.unfocus();
    }

    String? validate(String value) {
      return null;
    }

    DateTime getDate(String pattern, String date) {
      return DateFormat(pattern).parse(date);
    }

    return Obx(
      () => TextFormField(
        readOnly: !controller.editAccess.value,
        focusNode: _focusNode,
        controller: textController,
        validator: (value) => validate(value!),
        onTap: !controller.editAccess.value
            ? () {}
            : () async {
                _hideKeyboard();
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: textController.text.isEmpty
                      ? DateTime.now()
                      : getDate(CalenderUtils.previewDDMMMYYYYHHMMSSDP,
                          textController.text),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  // selectableDayPredicate: (DateTime day) {
                  //   if (day.isBefore(DateTime(DateTime.now().year,
                  //       DateTime.now().month, DateTime.now().day - 1))) {
                  //     return false; // Block dates before 05-11-2024
                  //   }
                  //   return true;
                  // },
                );

                final time = await showTimePicker(
                    context: context,
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                    initialTime: TimeOfDay.fromDateTime(getDate(
                        CalenderUtils.previewDDMMMYYYYHHMMSSDP,
                        textController.text)));

                if (date == null) return;
                if (time == null) return;

                final date1 = DateTime(
                    date.year, date.month, date.day, time.hour, time.minute);

                textController.text =
                    DateFormat(CalenderUtils.previewDDMMMYYYYHHMMSSDP)
                        .format(date1);
              },
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          alignLabelWithHint: true,
          // filled: true,
          // fillColor: Colors.grey.shade200,
          labelText: label,
          // labelStyle: TextStyle().copyWith()
        ),
      ),
    );
  }
}
