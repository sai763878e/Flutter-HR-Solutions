class EmployeeDO {
  String tuid;
  String status;
  String rss;
  String title;
  String surName;
  String givenName;
  String shortName;
  String employeeNumber;
  String teluguName;
  String gender;
  String employmentType;
  String birthDate;
  String joiningDate;
  String marriageDate;
  String officeEmail;
  String officePhone;
  String workMobile;
  String supervisorFkEmployeeTuid;
  String managerFkEmployeeTuid;
  String fkOfficeTuid;
  String fkDepartmentTuid;
  String remarks;
  String linkedin;
  String skills;
  String weekend;
  String lct;
  String lmt;
  String sct;
  String smt;
  double? testScore;
  double? salary;
  String officeTime;
  String joiningDatetime;

  String officeCode;
  String officeName;
  String departmentCode;
  String departmentName;
  String supervisorName;
  String managerName;


  EmployeeDO({
    required this.tuid,
    required this.status,
    required this.rss,
    required this.title,
    required this.surName,
    required this.givenName,
    required this.shortName,
    required this.employeeNumber,
    required this.teluguName,
    required this.gender,
    required this.employmentType,
    required this.birthDate,
    required this.joiningDate,
    required this.marriageDate,
    required this.officeEmail,
    required this.officePhone,
    required this.workMobile,
    required this.supervisorFkEmployeeTuid,
    required this.managerFkEmployeeTuid,
    required this.fkOfficeTuid,
    required this.fkDepartmentTuid,
    required this.remarks,
    required this.linkedin,
    required this.skills,
    required this.weekend,
    required this.lct,
    required this.lmt,
    required this.sct,
    required this.smt,
    required this.testScore,
    required this.salary,
    required this.officeTime,
    required this.joiningDatetime,

    required this.officeCode,
    required this.officeName,
    required this.departmentCode,
    required this.departmentName,
    required this.supervisorName,
    required this.managerName,
  });

// Example of a method that converts the object to a Map (for serialization)
  Map<String, dynamic> toJson() {
    return {
      'tuid': tuid,
      'status': status,
      'rss': rss,
      'title': title,
      'sur_name': surName,
      'given_name': givenName,
      'short_name': shortName,
      'employee_number': employeeNumber,
      'telugu_name': teluguName,
      'gender': gender,
      'employment_type': employmentType,
      'birth_date': birthDate,
      'joining_date': joiningDate,
      'marriage_date': marriageDate,
      'office_email': officeEmail,
      'office_phone': officePhone,
      'work_mobile': workMobile,
      'supervisor_fk_employee_tuid': supervisorFkEmployeeTuid,
      'manager_fk_employee_tuid': managerFkEmployeeTuid,
      'fk_office_tuid': fkOfficeTuid,
      'fk_department_tuid': fkDepartmentTuid,
      'remarks': remarks,
      'linkedin_linkedin': linkedin,
      'skills': skills,
      'weekend': weekend,
      'lct': lct,
      'lmt': lmt,
      'sct': sct,
      'smt': smt,
      'test_score': testScore,
      'salary': salary,
      'office_time': officeTime,
      'joining_datetime': joiningDatetime,

      'office_code': officeCode,
      'office_name': officeName,
      'department_code': departmentCode,
      'department_name': departmentName,
      'supervisor_name': supervisorName,
      'manager_name': managerName,
    };
  }

  // Example of a method that creates an object from a Map (for deserialization)
  factory EmployeeDO.fromJson(Map<String, dynamic> json) {
    return EmployeeDO(
      tuid: json['tuid'] ?? '',
      status: json['status'] ?? '',
      rss: json['rss'] ?? '',
      title: json['title'] ?? '',
      surName: json['sur_name'] ?? '',
      givenName: json['given_name'] ?? '',
      shortName: json['short_name'] ?? '',
      employeeNumber: json['employee_number'] ?? '',
      teluguName: json['telugu_name'] ?? '',
      gender: json['gender'] ?? '',
      employmentType: json['employment_type'] ?? '',
      birthDate: json['birth_date'] ?? '',
      joiningDate: json['joining_date'] ?? '',
      marriageDate: json['marriage_date'] ?? '',
      officeEmail: json['office_email'] ?? '',
      officePhone: json['office_phone'] ?? '',
      workMobile: json['work_mobile'] ?? '',
      supervisorFkEmployeeTuid: json['supervisor_fk_employee_tuid'] ?? '',
      managerFkEmployeeTuid: json['manager_fk_employee_tuid'] ?? '',
      fkOfficeTuid: json['fk_office_tuid'] ?? '',
      fkDepartmentTuid: json['fk_department_tuid'] ?? '',
      remarks: json['remarks'] ?? '',
      linkedin: json['linkedin_linkedin'] ?? '',
      skills: json['skills'] ?? '',
      weekend: json['weekend'] ?? '',
      lct: json['lct'] ?? '',
      lmt: json['lmt'] ?? '',
      sct: json['sct'] ?? '',
      smt: json['smt'] ?? '',
      testScore: double.tryParse(json['test_score'].toString()) ?? 0,
      salary: double.tryParse(json['salary'].toString()) ?? 0,
      officeTime: json['office_time'] ?? '',
      joiningDatetime: json['joining_datetime'] ?? '',

      officeCode: json['office_code'] ?? '',
      officeName: json['office_name'],
      departmentCode: json['department_code'] ?? '',
      departmentName: json['department_name'] ?? '',
      supervisorName: json['supervisor_name']  ?? '',
      managerName: json['manager_name']  ?? '',
    );
  }
}
