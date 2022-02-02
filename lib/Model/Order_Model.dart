// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.id,
    this.uid,
    this.retailerId,
    this.address,
    this.orderDate,
    this.items,
    this.subTotal,
    this.discount,
    this.total,
    this.note,
    this.status,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.retailerName,
    this.retailerBusinessName,
    this.retailerAddress,
    this.retailerMobile,
  });

  String id;
  String uid;
  String retailerId;
  String address;
  DateTime orderDate;
  List<Item> items;
  String subTotal;
  String discount;
  String total;
  String note;
  String status;
  DateTime createdDate;
  String createdBy;
  String updatedDate;
  String updatedBy;
  String retailerName;
  String retailerBusinessName;
  String retailerAddress;
  String retailerMobile;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    uid: json["uid"],
    retailerId: json["retailer_id"],
    address: json["address"],
    orderDate: DateTime.parse(json["order_date"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    subTotal: json["sub_total"],
    discount: json["discount"],
    total: json["total"],
    note: json["note"],
    status: json["status"],
    createdDate: DateTime.parse(json["created_date"]),
    createdBy: json["created_by"],
    updatedDate: json["updated_date"],
    updatedBy: json["updated_by"],
    retailerName: json["retailer_name"],
    retailerBusinessName: json["retailer_business_name"],
    retailerAddress: json["retailer_address"],
    retailerMobile: json["retailer_mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "retailer_id": retailerId,
    "address": address,
    "order_date": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "sub_total": subTotal,
    "discount": discount,
    "total": total,
    "note": note,
    "status": status,
    "created_date": createdDate.toIso8601String(),
    "created_by": createdBy,
    "updated_date": updatedDate,
    "updated_by": updatedBy,
    "retailer_name": retailerName,
    "retailer_business_name": retailerBusinessName,
    "retailer_address": retailerAddress,
    "retailer_mobile": retailerMobile,
  };
}

class Item {
  Item({
    this.pid,
    this.colorId,
    this.colorCode,
    this.sku,
    this.amount,
    this.qty,
  });

  String pid;
  String colorId;
  String colorCode;
  String sku;
  String amount;
  String qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    pid: json["pid"],
    colorId: json["color_id"],
    colorCode: json["color_code"],
    sku: json["sku"],
    amount: json["amount"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "color_id": colorId,
    "color_code": colorCode,
    "sku": sku,
    "amount": amount,
    "qty": qty,
  };
}
