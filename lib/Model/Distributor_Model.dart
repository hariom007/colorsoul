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
    this.latitude,
    this.longitude,
    this.pincode,
    this.name,
    this.mobile,
    this.telephone,
    this.openTime,
    this.closeTime,
    this.image,
    this.isApproved,
    this.parentName,
  });

  String id;
  String parentId;
  String type;
  String businessName;
  String businessType;
  String gstNo;
  String address;
  String pincode;
  String latitude;
  String longitude;
  String name;
  String mobile;
  String telephone;
  String openTime;
  String closeTime;
  String image;
  String isApproved;
  String parentName;

  factory DistributorModel.fromJson(Map<String, dynamic> json) => DistributorModel(
    id: json["id"],
    parentId: json["parent_id"],
    type: json["type"],
    businessName: json["business_name"],
    businessType: json["business_type"],
    gstNo: json["gst_no"],
    address: json["address"],
    pincode: json["pincode"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    name: json["name"],
    mobile: json["mobile"],
    telephone: json["telephone"],
    openTime: json["open_time"],
    closeTime: json["close_time"],
    image: json["image"],
    isApproved: json["isApproved"],
    parentName: json["parent_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "type": type,
    "business_name": businessName,
    "business_type": businessType,
    "gst_no": gstNo,
    "address": address,
    "pincode": pincode,
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "mobile": mobile,
    "telephone": telephone,
    "open_time": openTime,
    "close_time": closeTime,
    "image": image,
    "isApproved": isApproved,
    "parent_name": parentName,
  };
}
