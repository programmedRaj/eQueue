class BranchModel {
  String? branchName;
  String? phoneNo;
  String? addr1;
  String? addr2;
  String? city;
  String? postalCode;
  String? geoLoaction;
  String? province;
  String? workingHrs;
  String? services;
  String? timeZone;
  String? notify;
  String? bookingPerday;
  String? bookingPerhrs;
  String? reqType;
  String? threshold;
  Map<String, dynamic>? department;
  String? branchId;

  BranchModel(
      {this.addr1,
      this.addr2,
      this.bookingPerday,
      this.bookingPerhrs,
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
      this.workingHrs});
}
