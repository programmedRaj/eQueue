import 'dart:convert';
import 'dart:io';

class Register {
  String? name;
  String? address1;
  String? address2;
  String? postalcode;
  String? province;
  String? city;
  String? phone;
  String? code;
  File? image;
  Register({
    this.name,
    this.address1,
    this.address2,
    this.postalcode,
    this.province,
    this.city,
    this.phone,
    this.code,
    this.image,
  });
}
