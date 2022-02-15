import 'package:colorsoul/Api%20Handler/ApiHandler.dart';
import 'package:colorsoul/Model/Group_Model.dart';
import 'package:colorsoul/Model/Product_Category_Model.dart';
import 'package:colorsoul/Model/Product_Model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductProvider with ChangeNotifier
{

  bool isLoaded = true;
  bool isSuccess = false;

  List<ProductCategoryModel> productCategoryList = [];
  getProductCategory(url) async
  {

    isLoaded = false;
    productCategoryList.clear();
    notifyListeners();

    await ApiHandler.get(url).then((value){
      List<ProductCategoryModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];

        List client = items as List;
        list  = client.map<ProductCategoryModel>((json) => ProductCategoryModel.fromJson(json)).toList();
        productCategoryList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Product Get List Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

      isLoaded = true;
      notifyListeners();

    });

  }


  List<ProductModel> productList = [];
  getProducts(data,url) async
  {

    isLoaded = false;
    productList.clear();
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<ProductModel> list;

      print(value);

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];

        List client = items as List;
        list  = client.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
        productList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Product Get List Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

      isLoaded = true;
      notifyListeners();

    });

  }


  List<ProductModel> searchProductList = [];
  getSearchProducts(data,url) async
  {

    isLoaded = false;
    searchProductList.clear();
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<ProductModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];

        List client = items as List;
        list  = client.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
        searchProductList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Product Get List Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

      isLoaded = true;
      notifyListeners();

    });

  }


  List<GroupModel> groupList = [];
  getGroupList(url) async
  {

    isLoaded = false;
    groupList.clear();
    notifyListeners();

    await ApiHandler.get(url).then((value){
      List<GroupModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];

        List client = items as List;
        list  = client.map<GroupModel>((json) => GroupModel.fromJson(json)).toList();
        groupList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Get Group List Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

      isLoaded = true;
      notifyListeners();

    });

  }


}