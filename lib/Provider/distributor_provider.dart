import 'package:colorsoul/Api%20Handler/ApiHandler.dart';
import 'package:colorsoul/Model/Distributor_Model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DistributorProvider with ChangeNotifier
{

  bool isLoaded = true;
  bool isSuccess = false;

  List<DistributorModel> distributorList = [];

  getDistributor(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<DistributorModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];

        print(items);

        List client = items as List;
        list  = client.map<DistributorModel>((json) => DistributorModel.fromJson(json)).toList();
        distributorList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Distributor Get List Error !!",
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

  insertDistributor(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      if(value["st"] == "success")
      {
        isSuccess = true;
        var data = {
          "search_term":""
        };
        getDistributor(data,"/getDistributorRetailer/1");
        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Insert Distributor Error !!",
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

  bool isDistributorLoaded = true;
  List<DistributorModel> onlyDistributorList = [];
  var distributorValue;
  getOnlyDistributor(data,url) async
  {

    isDistributorLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<DistributorModel> list;


      if(value["st"] == "success")
      {
        isSuccess = true;

        distributorValue = value['data'];
        var items = value["data"];

        List client = items as List;
        list  = client.map<DistributorModel>((json) => DistributorModel.fromJson(json)).toList();
        onlyDistributorList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Distributor Get List Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

      isDistributorLoaded = true;
      notifyListeners();

    });

  }


  var distributorData;
  bool isDistributorDataLoaded = true;
  getDistributorDetails(data,url) async
  {

    isDistributorDataLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){

      if(value["st"] == "success")
      {
        isSuccess = true;

        distributorData = value['data'];
        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Distributor Get List Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

      isDistributorDataLoaded = true;
      notifyListeners();

    });

  }


}