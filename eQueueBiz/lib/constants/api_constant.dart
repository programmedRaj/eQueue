class AuthenticationApi {
  static const login = "http://127.0.0.1:5000/biz_signin";
  static const forgotPass = "http://127.0.0.1:5000/forgot_passw_biz";
  static const changeForgotPass = "http://127.0.0.1:5000/change_fpassw_biz";
  static const changePassword = "http://127.0.0.1:5000/change_passw_biz";
}

class BranchApi {
  static const createEditBranch = "http://127.0.0.1:5000/create_edit_branch";
  static const getBranch = "http://127.0.0.1:5000/branch_list";
}

class DepartmentApi {
  static const getDept = "http://127.0.0.1:5000/dept_services";
}

class Employee {
  static const createEditDeleteEmp = "http://127.0.0.1:5000/create_employee";
  static const getEmpolyee = "http://127.0.0.1:5000/fetch_employees";
  static const empdet = "http://127.0.0.1:5000/getbr_emp";
}

class BookingApi {
  static const bookingdetails = "http://127.0.0.1:5000/sort_bookings";
  static const viewbookinguserdetails =
      "http://127.0.0.1:5000/viewuser_details_bookings";
}

class TokenApi {
  static const tokendetails = "http://127.0.0.1:5000/all_tokens";

  static const status_check = "http://127.0.0.1:5000/status_booking_chng";
}
