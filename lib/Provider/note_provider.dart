import 'package:colorsoul/Api%20Handler/ApiHandler.dart';
import 'package:colorsoul/Model/Note_Model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteProvider with ChangeNotifier
{

  bool isLoaded = true;

  bool isSuccess = false;
  insertNote(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      if(value["st"] == "success")
      {
        isSuccess = true;
        getAllNote({},"/getNote/1");
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


  List<NoteModel> noteList = [];
  getAllNote(data,url) async
  {

    isLoaded = false;
    notifyListeners();

    await ApiHandler.post(data,url).then((value){
      List<NoteModel> list;

      if(value["st"] == "success")
      {
        isSuccess = true;

        var items = value["data"];

        List client = items as List;
        list  = client.map<NoteModel>((json) => NoteModel.fromJson(json)).toList();
        noteList.addAll(list);

        notifyListeners();
      }
      else
      {
        isSuccess = false;
        notifyListeners();

        Fluttertoast.showToast(
            msg: "Note Get List Error !!",
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