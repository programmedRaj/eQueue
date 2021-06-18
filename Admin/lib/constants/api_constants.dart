class LoginApi {
  static const String loginUrl = "http://91.99.96.87:5000/adminsign_in";
}

class CompanyApi {
  static const create = "http://91.99.96.87:5000/create_company";
  static const edit = "http://91.99.96.87:5000/edit_company";
  static const compfullDets = "http://91.99.96.87:5000/companies";
  static const disableComp = "http://91.99.96.87:5000/disable_company";
  static const deleteComp = "http://91.99.96.87:5000/delete_company";
}

class BranchApi {
  static const getBranches = "http://91.99.96.87:5000/showbranches";
}

class EmployeeApi {
  static const getEmployees = "http://91.99.96.87:5000/showempsforcomps";
}

class UsersApi {
  static const getUsers = "http://91.99.96.87:5000/showusers";
  static const deleteUser = "http://91.99.96.87:5000/delete_user";
}
