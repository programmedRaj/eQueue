class AuthenticationApi {
  static const login = "http://91.99.96.87:8080/biz_signin";
  static const forgotPass = "http://91.99.96.87:8080/forgot_passw_biz";
  static const changeForgotPass = "http://91.99.96.87:8080/change_fpassw_biz";
  static const changePassword = "http://91.99.96.87:8080/change_passw_biz";
}

class CompAPi {
  static const getbizdets = "http://91.99.96.87:8080/biz_details";
}

class BranchApi {
  static const createEditBranch = "http://91.99.96.87:8080/create_edit_branch";
  static const getBranch = "http://91.99.96.87:8080/branch_list";
}

class DepartmentApi {
  static const getDept = "http://91.99.96.87:8080/dept_services";
}

class Employee {
  static const createEditDeleteEmp = "http://91.99.96.87:8080/create_employee";
  static const getEmpolyee = "http://91.99.96.87:8080/fetch_employees";
  static const empdet = "http://91.99.96.87:8080/getbr_emp";
}

class BookingApi {
  static const bookingdetails = "http://91.99.96.87:8080/sort_bookings";
  static const viewbookinguserdetails =
      "http://91.99.96.87:8080/viewuser_details_bookings";

  static const status_check = "http://91.99.96.87:8080/status_booking_chng";
}

class TokenApi {
  static const tokendetails = "http://91.99.96.87:8080/all_tokens";
  static const tokenchange = "http://91.99.96.87:8080/status_token_chng";
}
