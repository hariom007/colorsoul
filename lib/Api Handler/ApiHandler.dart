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
        'Authorization':'4ccda7514adc0f13595a585205fb9761'
      };

      //var baseUrl = Uri.http('colorsoul.koffeekodes.com','/admin/Api$url');
      var baseUrl = Uri.https('console.colorsoul.co','/admin/Api$url');

      http.Response response = await http.post(
          baseUrl,
          headers: _setHeadersPost(),
          body: jsonEncode(body)
      );

     // print(json.decode(response.body));

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

      var baseUrl = Uri.https('console.colorsoul.co','/admin/Api$url');
      //var baseUrl = Uri.http('colorsoul.koffeekodes.com','/admin/Api$url');

      _setHeadersGet()=> {
        'Content-type': 'application/json',
        'Authorization':'4ccda7514adc0f13595a585205fb9761'
      };

      http.Response response = await http.get(
          baseUrl,
          headers: _setHeadersGet()
      );

      //print(json.decode(response.body));

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

    var baseUrl = Uri.https('console.colorsoul.co','/admin/Api$url');
    //var baseUrl = Uri.http('colorsoul.koffeekodes.com','/admin/Api$url');

      _setHeadersGet()=> {
        'Content-type': 'application/json',
        'Authorization':'4ccda7514adc0f13595a585205fb9761'
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

  static Future<dynamic> normalPost(body,url) async {

    _setHeadersPost()=> {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var baseUrl = Uri.parse(url);

    http.Response response = await http.post(
        baseUrl,
        headers: _setHeadersPost(),
        body: jsonEncode(body)
    );

    // print(json.decode(response.body));

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