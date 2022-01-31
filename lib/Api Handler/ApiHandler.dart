import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiHandler {

  static Future<dynamic> post(body,url) async {

      _setHeadersPost()=> {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization':'4fe0c4203533aa61c0fae455ac8d9d07cb237fbf5b8b1e92a783319c02fa5a8d'
      };

      var baseUrl = Uri.http('162.0.210.138','/api$url');

      http.Response response = await http.post(
          baseUrl,
          headers: _setHeadersPost(),
          body: jsonEncode(body)
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {

        switch(response.statusCode){
          case 400:
            return Fluttertoast.showToast(
                  msg: "Bad Response Format",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
          case 401:
            return Fluttertoast.showToast(
                      msg: "Unauthorized User",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
            );
          case 500:
            return Fluttertoast.showToast(
                msg: "Internal Server Error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          case 404:
            return Fluttertoast.showToast(
                msg: "Resource Not Found",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          default:
            return Fluttertoast.showToast(
                msg: "Unknown Error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
        }

      }
  }

  static Future<dynamic> get(url) async {

      var baseUrl = Uri.http('162.0.210.138','/api$url');

      _setHeadersGet()=> {
        'Content-type': 'application/json',
        'Authorization':'4fe0c4203533aa61c0fae455ac8d9d07cb237fbf5b8b1e92a783319c02fa5a8d'
      };

      http.Response response = await http.get(
          baseUrl,
          headers: _setHeadersGet()
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {

        switch(response.statusCode){
          case 400:
            return Fluttertoast.showToast(
                msg: "Bad Response Format",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          case 401:
            return Fluttertoast.showToast(
                msg: "Unauthorized User",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          case 500:
            return Fluttertoast.showToast(
                msg: "Internal Server Error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          case 404:
            return Fluttertoast.showToast(
                msg: "Resource Not Found",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          default:
            return Fluttertoast.showToast(
                msg: "Unknown Error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
        }

      }
  }

  static Future<dynamic> getWithParams(url,params) async {

      var baseUrl = Uri.http('162.0.210.138','/api$url',params);

      _setHeadersGet()=> {
        'Content-type': 'application/json',
        'Authorization':'4fe0c4203533aa61c0fae455ac8d9d07cb237fbf5b8b1e92a783319c02fa5a8d'
      };

      http.Response response = await http.get(
          baseUrl,
          headers: _setHeadersGet()
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {

        switch(response.statusCode){
          case 400:
            return Fluttertoast.showToast(
                msg: "Bad Response Format",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          case 401:
            return Fluttertoast.showToast(
                msg: "Unauthorized User",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          case 500:
            return Fluttertoast.showToast(
                msg: "Internal Server Error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          case 404:
            return Fluttertoast.showToast(
                msg: "Resource Not Found",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          default:
            return Fluttertoast.showToast(
                msg: "Unknown Error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
        }

      }
  }

}