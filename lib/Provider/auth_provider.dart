import 'package:colorsoul/Api%20Handler/ApiHandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider with ChangeNotifier
{

  bool isLoaded = true;
  bool isSuccess = false;

  var loginData;
  loginApi(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){

        if(value["st"] == "success")
        {
          isSuccess = true;
          loginData = value;
          notifyListeners();
        }
        else
        {
          isSuccess = false;
          notifyListeners();

          Fluttertoast.showToast(
              msg: "Number or Password are Wrong !!",
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