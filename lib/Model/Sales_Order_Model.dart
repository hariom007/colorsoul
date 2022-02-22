// To parse this JSON data, do
//
//     final salesOrderModel = salesOrderModelFromJson(jsonString);

import 'dart:convert';

List<SalesOrderModel> salesOrderModelFromJson(String str) => List<SalesOrderModel>.from(json.decode(str).map((x) => SalesOrderModel.fromJson(x)));

String salesOrderModelToJson(List<SalesOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalesOrderModel {
  SalesOrderModel({
    this.id,
    this.type,
    this.deliveryId,
    this.invoiceNo,
    this.invoiceDate,
    this.colorId,
    this.purchaseInvoice,
    this.customerId,
    this.customerName,
    this.customerMobile,
    this.customerEmail,
    this.customerAddress,
    this.customerBusiness,
    this.gstNo,
    this.totalQty,
    this.subTotal,
    this.totalCgst,
    this.totalSgst,
    this.totalIgst,
    this.discount,
    this.custState,
    this.totalAmount,
    this.deliveryAssign,
    this.isEditable,
    this.isDelivered,
    this.isDelete,
    this.deliveryNote,
    this.deliveryType,
    this.createAt,
    this.createBy,
    this.updateAt,
    this.updateBy,
    this.isApproved,
    this.isCancle,
    this.items,
    this.paymentDetail,
  });

  String id;
  String type;
  String deliveryId;
  String invoiceNo;
  DateTime invoiceDate;
  String colorId;
  String purchaseInvoice;
  String customerId;
  String customerName;
  String customerMobile;
  String customerEmail;
  String customerAddress;
  String customerBusiness;
  String gstNo;
  String totalQty;
  String subTotal;
  String totalCgst;
  String totalSgst;
  String totalIgst;
  String discount;
  String custState;
  String totalAmount;
  String deliveryAssign;
  String isEditable;
  String isDelivered;
  String isDelete;
  String deliveryNote;
  String deliveryType;
  DateTime createAt;
  String createBy;
  String updateAt;
  String updateBy;
  String isApproved;
  String isCancle;
  List<Item> items;
  List<PaymentDetail> paymentDetail;

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) => SalesOrderModel(
    id: json["id"],
    type: json["type"],
    deliveryId: json["delivery_id"],
    invoiceNo: json["InvoiceNo"],
    invoiceDate: DateTime.parse(json["Invoice_date"]),
    colorId: json["color_id"],
    purchaseInvoice: json["purchase_invoice"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerMobile: json["customer_mobile"],
    customerEmail: json["customer_email"],
    customerAddress: json["customer_address"],
    customerBusiness: json["customer_business"],
    gstNo: json["gst_no"],
    totalQty: json["total_qty"],
    subTotal: json["sub_total"],
    totalCgst: json["total_cgst"],
    totalSgst: json["total_sgst"],
    totalIgst: json["total_igst"],
    discount: json["discount"],
    custState: json["cust_state"],
    totalAmount: json["total_amount"],
    deliveryAssign: json["delivery_assign"],
    isEditable: json["is_editable"],
    isDelivered: json["is_delivered"],
    isDelete: json["is_delete"],
    deliveryNote: json["delivery_note"],
    deliveryType: json["delivery_type"],
    createAt: DateTime.parse(json["create_at"]),
    createBy: json["create_by"],
    updateAt: json["update_at"],
    updateBy: json["update_by"],
    isApproved: json["is_approved"],
    isCancle: json["is_cancle"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    paymentDetail: List<PaymentDetail>.from(json["payment_detail"].map((x) => PaymentDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "delivery_id": deliveryId,
    "InvoiceNo": invoiceNo,
    "Invoice_date": "${invoiceDate.year.toString().padLeft(4, '0')}-${invoiceDate.month.toString().padLeft(2, '0')}-${invoiceDate.day.toString().padLeft(2, '0')}",
    "color_id": colorId,
    "purchase_invoice": purchaseInvoice,
    "customer_id": customerId,
    "customer_name": customerName,
    "customer_mobile": customerMobile,
    "customer_email": customerEmail,
    "customer_address": customerAddress,
    "customer_business": customerBusiness,
    "gst_no": gstNo,
    "total_qty": totalQty,
    "sub_total": subTotal,
    "total_cgst": totalCgst,
    "total_sgst": totalSgst,
    "total_igst": totalIgst,
    "discount": discount,
    "cust_state": custState,
    "total_amount": totalAmount,
    "delivery_assign": deliveryAssign,
    "is_editable": isEditable,
    "is_delivered": isDelivered,
    "is_delete": isDelete,
    "delivery_note": deliveryNote,
    "delivery_type": deliveryType,
    "create_at": createAt.toIso8601String(),
    "create_by": createBy,
    "update_at": updateAt,
    "update_by": updateBy,
    "is_approved": isApproved,
    "is_cancle": isCancle,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "payment_detail": List<dynamic>.from(paymentDetail.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.invoiceId,
    this.orderDate,
    this.orderProductId,
    this.orderProductName,
    this.hsnCode,
    this.orderColorId,
    this.qty,
    this.price,
    this.igst,
    this.sgst,
    this.cgst,
    this.subtotal,
  });

  String invoiceId;
  DateTime orderDate;
  String orderProductId;
  String orderProductName;
  String hsnCode;
  String orderColorId;
  String qty;
  String price;
  String igst;
  String sgst;
  String cgst;
  String subtotal;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    invoiceId: json["invoice_id"],
    orderDate: DateTime.parse(json["order_date"]),
    orderProductId: json["order_product_id"],
    orderProductName: json["order_product_name"],
    hsnCode: json["hsn_code"],
    orderColorId: json["order_color_id"],
    qty: json["qty"],
    price: json["price"],
    igst: json["igst"],
    sgst: json["sgst"],
    cgst: json["cgst"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "invoice_id": invoiceId,
    "order_date": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "order_product_id": orderProductId,
    "order_product_name": orderProductName,
    "hsn_code": hsnCode,
    "order_color_id": orderColorId,
    "qty": qty,
    "price": price,
    "igst": igst,
    "sgst": sgst,
    "cgst": cgst,
    "subtotal": subtotal,
  };
}

class PaymentDetail {
  PaymentDetail({
    this.invoiceId,
    this.paymentType,
    this.amount,
    this.detail,
  });

  String invoiceId;
  String paymentType;
  String amount;
  String detail;

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
    invoiceId: json["invoice_id"],
    paymentType: json["payment_type"],
    amount: json["amount"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "invoice_id": invoiceId,
    "payment_type": paymentType,
    "amount": amount,
    "detail": detail,
  };
}
