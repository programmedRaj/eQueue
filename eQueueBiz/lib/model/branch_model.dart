class BranchModel {
  String branchName;
  String phoneNo;
  String addr1;
  String addr2;
  String city;
  String postalCode;
  String geoLoaction;
  String province;
  Map<dynamic, dynamic> workingHrs;
  Map<dynamic, dynamic> services;
  String timeZone;
  String notify;
  List<String> bookingPerday;
  List<String> bookingPerDayhrs;
  String reqType;
  String threshold;
  Map<String, dynamic> department;
  String branchId;
  String counter;

  BranchModel(
      {this.addr1,
      this.addr2,
      this.bookingPerday,
      this.bookingPerDayhrs,
      this.branchId,
      this.branchName,
      this.city,
      this.department,
      this.geoLoaction,
      this.notify,
      this.phoneNo,
      this.postalCode,
      this.province,
      this.reqType,
      this.services,
      this.threshold,
      this.timeZone,
      this.workingHrs,
      this.counter});
}
