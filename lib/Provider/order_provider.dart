import 'package:colorsoul/Api%20Handler/ApiHandler.dart';
import 'package:colorsoul/Model/Order_Model.dart';
import 'package:colorsoul/Model/Sales_Order_Model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderProvider with ChangeNotifier
{

  bool isLoaded = true;

  bool isSuccess = false;
  insertOrder(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      print(value);
      if(value["st"] == "success")
      {
        isSuccess = true;

       orderList.clear();
       incompleteOrderList.clear();
       completeOrderList.clear();

        var data2 = {
          "uid":"${data["uid"]}",
          "from_date":"",
          "to_date":"",
          "status":""
        };

        var data3 = {
          "uid":"${data["uid"]}",
          "from_date":"",
          "to_date":"",
          "status":"Delivered"
        };

        var data4 = {
          "uid":"${data["uid"]}",
          "from_date":"",
          "to_date":"",
          "status":"Pending"
        };


       getAllOrders(data2, "/getOrder/1");
       getCompleteOrders(data3, "/getOrder/1");
       getIncompleteOrders(data4, "/getOrder/1");
        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Insert Error !!",
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


  List<OrderModel> orderList = [];
  String allOrderCount = "",completeOrderCount = "",incompleteOrderCount = "";
  getAllOrders(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<OrderModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];
        allOrderCount = "${value["total_result"]}";

        List client = items as List;
        list  = client.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
        orderList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Order Get List Error !!",
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

  List<OrderModel> completeOrderList = [];
  getCompleteOrders(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<OrderModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];
        completeOrderCount = "${value["total_result"]}";


        List client = items as List;
        list  = client.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
        completeOrderList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Order Get List Error !!",
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

  List<OrderModel> incompleteOrderList = [];
  getIncompleteOrders(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<OrderModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];
        incompleteOrderCount = "${value["total_result"]}";

        List client = items as List;
        list  = client.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
        incompleteOrderList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Order Get List Error !!",
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

  bool isConfirm = false;
  confirmOrder(data,url) async
  {

    isConfirm = false;
    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      if(value["st"] == "success")
      {
        isConfirm = true;
        notifyListeners();
      }
      else
      {
        isConfirm = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Order Confirm Error !!",
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

  insertSalesOrder(data,url) async
  {

    isLoaded = false;
    isSuccess = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      print(value);
      if(value["st"] == "success")
      {
        isSuccess = true;

        salesOrderList.clear();

        var data2 = {
          "uid":"${data["uid"]}",
        };

        getSalesOrders(data2, "/get_salesorder/1");
        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Insert Error !!",
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


  List<SalesOrderModel> salesOrderList = [];
  getSalesOrders(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<SalesOrderModel> list;

     // print(value);
      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];

        List client = items as List;
        list  = client.map<SalesOrderModel>((json) => SalesOrderModel.fromJson(json)).toList();
        salesOrderList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Order Get List Error !!",
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


  var orderDetails;
  getOrderDetails(data,url)async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){

      if(value["st"] == "success")
      {
        isSuccess = true;
        orderDetails = value["order_detail"];
        print(orderDetails);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Order Get List Error !!",
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


  var scanProductDetails;
  bool isProductSuccess = false;
  getScanProductDetails(data,url)async
  {

    isLoaded = false;
    isProductSuccess= false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){

      if(value["st"] == "success")
      {
        isProductSuccess = true;
        scanProductDetails = value["product_detail"];

        notifyListeners();
      }
      else
      {
        isProductSuccess = false;
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


  bool isBarcode = false;
  insertBarcodeOrder(data,url) async
  {

    isLoaded = false;
    isBarcode = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      print(value["st"]);
      if(value["st"] == "success")
      {
        isBarcode = true;
        isLoaded = true;
        print(isBarcode);
        notifyListeners();
      }
      else
      {
        isBarcode = false;
        isLoaded = true;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Insert Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

    });

  }




}