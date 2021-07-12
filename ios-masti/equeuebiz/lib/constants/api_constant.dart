class AuthenticationApi {
  static const login = "http://91.99.96.87:5000/biz_signin";
  static const forgotPass = "http://91.99.96.87:5000/forgot_passw_biz";
  static const changeForgotPass = "http://91.99.96.87:5000/change_fpassw_biz";
  static const changePassword = "http://91.99.96.87:5000/change_passw_biz";
}

class CompAPi {
  static const getbizdets = "http://91.99.96.87:5000/biz_details";
  static const biztrans = "http://91.99.96.87:5000/my_biztransactions";
}

class BranchApi {
  static const createEditBranch = "http://91.99.96.87:5000/create_edit_branch";
  static const getBranch = "http://91.99.96.87:5000/branch_list";
}

//thanks for helping. I added this 2 lines to server and its now working perfectly header('Access-Control-Allow-Origin: *'); header('Access-Control-Allow-Credentials: true'); Thanks again 

class DepartmentApi {
  static const getDept = "http://91.99.96.87:5000/dept_services";
}

class Employee {
  static const createEditDeleteEmp = "http://91.99.96.87:5000/create_employee";
  static const getEmpolyee = "http://91.99.96.87:5000/fetch_employees";
  static const empdet = "http://91.99.96.87:5000/getbr_emp";
}

class BookingApi {
  static const bookingdetails = "http://91.99.96.87:5000/sort_bookings";
  static const viewbookinguserdetails =
      "http://91.99.96.87:5000/viewuser_details_bookings";

  static const status_check = "http://91.99.96.87:5000/status_booking_chng";
}

class TokenApi {
  static const tokendetails = "http://91.99.96.87:5000/all_tokens";
  static const tokenchange = "http://91.99.96.87:5000/status_token_chng";
}

class MutliTokenApi {
  static const allmulti = 'http://91.99.96.87:5000/allmulti_tokens';
  static const callmulti = 'http://91.99.96.87:5000/status_mtoken_chng';
}
