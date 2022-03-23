// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.clProductId,
    this.clProductBrandId,
    this.clProductCatId,
    this.clProductSubCatId,
    this.clProductSupplierId,
    this.clProductName,
    this.clProductShortname,
    this.clProductSortDesc,
    this.clProductDesc,
    this.clProductUnitPrice,
    this.clProductSalePrice,
    this.clProductPckSize,
    this.clProductWeight,
    this.clProductHeight,
    this.clProductHsnCode,
    this.clProductSkuCode,
    this.clProductAsin,
    this.clProductIsbn,
    this.clProductImg,
    this.clProductImgUrl,
    this.clProductRadioBtn,
    this.pattributes,
    this.pvariation,
    this.clProductGrpColor,
    this.clProductColorCode,
    this.clProductStatus,
    this.clProductCreatedBy,
    this.clProductUpdatedBy,
    this.clProductCreatedDate,
    this.clProductUpdatedDate,
    this.isDeleted,
    this.hsnCode,
    this.hsnIgst,
    this.hsnCgst,
    this.hsnSgst,
    this.clCategoryName,
    this.clSubcategoryName,
    this.colors,
    this.available_stock,
    this.rate
  });

  String clProductId;
  String clProductBrandId;
  String clProductCatId;
  String clProductSubCatId;
  String clProductSupplierId;
  String clProductName;
  String clProductShortname;
  String clProductSortDesc;
  String clProductDesc;
  String clProductUnitPrice;
  String clProductSalePrice;
  String clProductPckSize;
  String clProductWeight;
  String clProductHeight;
  String clProductHsnCode;
  String clProductSkuCode;
  String clProductAsin;
  String clProductIsbn;
  List<ClProductImg> clProductImg;
  String clProductImgUrl;
  String clProductRadioBtn;
  List<Pattribute> pattributes;
  String pvariation;
  String clProductGrpColor;
  String clProductColorCode;
  String clProductStatus;
  String clProductCreatedBy;
  String clProductUpdatedBy;
  DateTime clProductCreatedDate;
  String clProductUpdatedDate;
  String isDeleted;
  String hsnCode;
  String hsnIgst;
  String hsnCgst;
  String hsnSgst;
  String clCategoryName;
  String clSubcategoryName;
  List<ApiColor> colors;
  String available_stock;
  String rate;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    clProductId: json["cl_product_id"],
    clProductBrandId: json["cl_product_brand_id"],
    clProductCatId: json["cl_product_cat_id"],
    clProductSubCatId: json["cl_product_sub_cat_id"],
    clProductSupplierId: json["cl_product_supplier_id"],
    clProductName: json["cl_product_name"],
    clProductShortname: json["cl_product_shortname"],
    clProductSortDesc: json["cl_product_sort_desc"],
    clProductDesc: json["cl_product_desc"],
    clProductUnitPrice: json["cl_product_unit_price"],
    clProductSalePrice: json["cl_product_sale_price"],
    clProductPckSize: json["cl_product_pck_size"],
    clProductWeight: json["cl_product_weight"],
    clProductHeight: json["cl_product_height"],
    clProductHsnCode: json["cl_product_hsn_code"],
    clProductSkuCode: json["cl_product_sku_code"],
    clProductAsin: json["cl_product_asin"],
    clProductIsbn: json["cl_product_isbn"],
    clProductImg: List<ClProductImg>.from(json["cl_product_img"].map((x) => ClProductImg.fromJson(x))),
    clProductImgUrl: json["cl_product_img_url"],
    clProductRadioBtn: json["cl_product_radio_btn"],
    pattributes: List<Pattribute>.from(json["pattributes"].map((x) => Pattribute.fromJson(x))),
    pvariation: json["pvariation"],
    clProductGrpColor: json["cl_product_grp_color"],
    clProductColorCode: json["cl_product_color_code"],
    clProductStatus: json["cl_product_status"],
    clProductCreatedBy: json["cl_product_created_by"],
    clProductUpdatedBy: json["cl_product_updated_by"],
    clProductCreatedDate: DateTime.parse(json["cl_product_created_date"]),
    clProductUpdatedDate: json["cl_product_updated_date"],
    isDeleted: json["is_deleted"],
    hsnCode: json["hsn_code"],
    hsnIgst: json["hsn_igst"],
    hsnCgst: json["hsn_cgst"],
    hsnSgst: json["hsn_sgst"],
    clCategoryName: json["cl_category_name"],
    clSubcategoryName: json["cl_subcategory_name"],
    colors: List<ApiColor>.from(json["colors"].map((x) => ApiColor.fromJson(x))),
    available_stock: json['available_stock'].toString(),
    rate: json['rate'].toString()
  );

  Map<String, dynamic> toJson() => {
    "cl_product_id": clProductId,
    "cl_product_brand_id": clProductBrandId,
    "cl_product_cat_id": clProductCatId,
    "cl_product_sub_cat_id": clProductSubCatId,
    "cl_product_supplier_id": clProductSupplierId,
    "cl_product_name": clProductName,
    "cl_product_shortname": clProductShortname,
    "cl_product_sort_desc": clProductSortDesc,
    "cl_product_desc": clProductDesc,
    "cl_product_unit_price": clProductUnitPrice,
    "cl_product_sale_price": clProductSalePrice,
    "cl_product_pck_size": clProductPckSize,
    "cl_product_weight": clProductWeight,
    "cl_product_height": clProductHeight,
    "cl_product_hsn_code": clProductHsnCode,
    "cl_product_sku_code": clProductSkuCode,
    "cl_product_asin": clProductAsin,
    "cl_product_isbn": clProductIsbn,
    "cl_product_img": List<dynamic>.from(clProductImg.map((x) => x.toJson())),
    "cl_product_img_url": clProductImgUrl,
    "cl_product_radio_btn": clProductRadioBtn,
    "pattributes": List<dynamic>.from(pattributes.map((x) => x.toJson())),
    "pvariation": pvariation,
    "cl_product_grp_color": clProductGrpColor,
    "cl_product_color_code": clProductColorCode,
    "cl_product_status": clProductStatus,
    "cl_product_created_by": clProductCreatedBy,
    "cl_product_updated_by": clProductUpdatedBy,
    "cl_product_created_date": clProductCreatedDate.toIso8601String(),
    "cl_product_updated_date": clProductUpdatedDate,
    "is_deleted": isDeleted,
    "hsn_code": hsnCode,
    "hsn_igst": hsnIgst,
    "hsn_cgst": hsnCgst,
    "hsn_sgst": hsnSgst,
    "cl_category_name": clCategoryName,
    "cl_subcategory_name": clSubcategoryName,
    "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
    "available_stock":available_stock,
    "rate":rate
  };
}

class ClProductImg {
  ClProductImg({
    this.imageid,
    this.pimageid,
    this.iid,
    this.fileName,
    this.imageName,
    this.hPath,
    this.tPath,
    this.fileSize,
    this.fileType,
    this.fileExt,
  });

  String imageid;
  String pimageid;
  String iid;
  String fileName;
  String imageName;
  String hPath;
  String tPath;
  String fileSize;
  String fileType;
  String fileExt;

  factory ClProductImg.fromJson(Map<String, dynamic> json) => ClProductImg(
    imageid: json["imageid"],
    pimageid: json["pimageid"],
    iid: json["iid"],
    fileName: json["file_name"],
    imageName: json["image_name"],
    hPath: json["h_path"],
    tPath: json["t_path"],
    fileSize: json["file_size"],
    fileType: json["file_type"],
    fileExt: json["file_ext"],
  );

  Map<String, dynamic> toJson() => {
    "imageid": imageid,
    "pimageid": pimageid,
    "iid": iid,
    "file_name": fileName,
    "image_name": imageName,
    "h_path": hPath,
    "t_path": tPath,
    "file_size": fileSize,
    "file_type": fileType,
    "file_ext": fileExt,
  };
}

class ApiColor {
  ApiColor({
    this.clColorId,
    this.clColorCode,
    this.hexCode,
    this.skuCode,
  });

  String clColorId;
  String clColorCode;
  String hexCode;
  String skuCode;

  factory ApiColor.fromJson(Map<String, dynamic> json) => ApiColor(
    clColorId: json["cl_color_id"],
    clColorCode: json["cl_color_code"],
    hexCode: json["HexCode"],
    skuCode: json["sku_code"],
  );

  Map<String, dynamic> toJson() => {
    "cl_color_id": clColorId,
    "cl_color_code": clColorCode,
    "HexCode": hexCode,
    "sku_code": skuCode,
  };
}

class Pattribute {
  Pattribute({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Pattribute.fromJson(Map<String, dynamic> json) => Pattribute(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
