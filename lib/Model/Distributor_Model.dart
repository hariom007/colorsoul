// To parse this JSON data, do
//
//     final distributorModel = distributorModelFromJson(jsonString);

import 'dart:convert';

List<DistributorModel> distributorModelFromJson(String str) => List<DistributorModel>.from(json.decode(str).map((x) => DistributorModel.fromJson(x)));

String distributorModelToJson(List<DistributorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistributorModel {
  DistributorModel({
    this.id,
    this.parentId,
    this.type,
    this.businessName,
    this.businessType,
    this.gstNo,
    this.address,
    this.homeAddress,
    this.landmark,
    this.pincode,
    this.latitude,
    this.longitude,
    this.name,
    this.mobile,
    this.telephone,
    this.openTime,
    this.closeTime,
    this.image,
    this.isApproved,
    this.parentName,
    this.state,
    this.city
  });

  String id;
  String parentId;
  String type;
  String businessName;
  String businessType;
  String gstNo;
  String address;
  String homeAddress;
  String landmark;
  String pincode;
  String latitude;
  String longitude;
  String name;
  String mobile;
  String telephone;
  String openTime;
  String closeTime;
  List<String> image;
  String isApproved;
  String parentName;
  String state;
  String city;

  factory DistributorModel.fromJson(Map<String, dynamic> json) => DistributorModel(
    id: json["id"],
    parentId: json["parent_id"],
    type: json["type"],
    businessName: json["business_name"],
    businessType: json["business_type"],
    gstNo: json["gst_no"],
    address: json["address"],
    homeAddress: json["home_address"],
    landmark: json["landmark"],
    pincode: json["pincode"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    name: json["name"],
    mobile: json["mobile"],
    telephone: json["telephone"],
    openTime: json["open_time"],
    closeTime: json["close_time"],
    image: json["image"] == "" ? [] : List<String>.from(json["image"].map((x) => x)),
    isApproved: json["isApproved"],
    parentName: json["parent_name"],
    state: json["state"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "type": type,
    "business_name": businessName,
    "business_type": businessType,
    "gst_no": gstNo,
    "address": address,
    "home_address": homeAddress,
    "landmark": landmark,
    "pincode": pincode,
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "mobile": mobile,
    "telephone": telephone,
    "open_time": openTime,
    "close_time": closeTime,
    "image": List<dynamic>.from(image.map((x) => x)),
    "isApproved": isApproved,
    "parent_name": parentName,
    "state":state,
    "city":city
  };
}
