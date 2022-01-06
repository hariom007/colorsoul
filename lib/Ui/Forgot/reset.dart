import 'dart:async';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Values/appColors.dart';
import '../Login/login.dart';

class Reset extends StatelessWidget {

  TextEditingController t1 = new TextEditingController();
  final key = new GlobalKey<ScaffoldState>();
  final _resetkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: key,
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Flesh2.png"),
              fit: BoxFit.fill,
            )
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: SingleChildScrollView(
            child: Form(
              key: _resetkey,
              child: Column(
                children: [
                  Stack(
                      children: [
                        Image.asset("assets/images/Vector.png",height: MediaQuery.of(context).size.height/2.8,width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth),
                        Positioned(
                            left: 30,
                            right: 30,
                            top: MediaQuery.of(context).size.height/12,
                            bottom: MediaQuery.of(context).size.height/7,
                            child: Image.asset("assets/images/Group665.png")
                        )
                      ]
                  ),
                  Text(
                      "Reset Your New \n Password",
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  SizedBox(height: height*0.06),
                  SizedBox(
                    width: width - 50,
                    child: TextFormField(
                        controller: t1,
                        style: textStyle.copyWith(),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: fieldStyle.copyWith(
                            hintText: "New Password",
                            isDense: true
                        ),
                        validator: (String value) {
                          if(value.isEmpty)
                          {
                            return "Please enter a Valid Password";
                          }
                          else if(value.length < 8)
                          {
                            return "Password can't be less than 8 characters";
                          }
                          return null;
                        }
                    ),
                  ),
                  SizedBox(height: height*0.06),
                  SizedBox(
                    width: width - 50,
                    child: TextFormField(
                        style: textStyle.copyWith(),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: fieldStyle.copyWith(
                            hintText: "Confirm Password",
                            isDense: true
                        ),
                        validator: (String value) {
                          if(value.isEmpty)
                          {
                            return "Please enter a Valid Password";
                          }
                          else if(value.length < 8)
                          {
                            return "Password can't be less than 8 characters";
                          }
                          else if(value != t1.text)
                          {
                            return "Password does not match";
                          }
                          return null;
                        }
                    ),
                  ),
                  SizedBox(height: height*0.05),
                  Text(
                      "Minimum 8 Characters.",
                      style: textStyle.copyWith()
                  ),
                  SizedBox(height: height*0.13),
                  Container(
                    height: 50,
                    width: width-80,
                    decoration: decoration.copyWith(),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_resetkey.currentState.validate())
                        {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return SimpleCustomAlert();
                            }
                          );
                        }
                        else
                        {
                          Fluttertoast.showToast(
                              msg: "Server Error",
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 14,
                        primary: Colors.transparent,
                        shape: StadiumBorder(),
                      ),
                      child: Text('Submit',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleCustomAlert extends StatefulWidget {
  @override
  State<SimpleCustomAlert> createState() => _SimpleCustomAlertState();
}

class _SimpleCustomAlertState extends State<SimpleCustomAlert> {


  @override
  void initState()
  {
    super.initState();
    Timer(
      Duration(milliseconds: 3000),
      () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
          borderRadius: round.copyWith(),
        ),
        height: height/3,
        width: width-100,
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset("assets/images/Group665.png",height: height*0.15),
            SizedBox(height: 20),
            Text(
              "Your New Password \n Set Successfully",
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
            )
          ],
        ),
      ),
    );
  }
}