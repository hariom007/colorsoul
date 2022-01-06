import 'package:colorsoul/Values/components.dart';
import 'package:colorsoul/Ui/Forgot/reset.dart';
import 'package:flutter/material.dart';

import '../../Values/appColors.dart';

class Forgot extends StatefulWidget {
  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _formkey = GlobalKey<FormState>();
  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              key: _formkey,
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
                    "Forgot Password?",
                    style: textStyle.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  SizedBox(height: height*0.01),
                  Text(
                    "Reset Password In Two Quick Step",
                    style: textStyle.copyWith(
                      fontSize: 16,
                    )
                  ),
                  SizedBox(height: height*0.03),
                  SizedBox(
                    width: width - 50,
                    child: TextFormField(
                      style: textStyle.copyWith(),
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      decoration: fieldStyle.copyWith(
                        hintText: "Email ID / Mobile No",
                        isDense: true
                      ),
                      validator: (String value) {
                        if(value.isEmpty)
                        {
                          return "Please enter Email or Number";
                        }
                        else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value) && value.length!=10)
                        {
                          return "Please enter a valid Email or Number";
                        }
                        return null;
                      }
                    ),
                  ),
                  SizedBox(height: height*0.03),
                  Container(
                      height: 30,
                      decoration: decoration.copyWith(),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if(isvisible == false)
                            {
                              isvisible = true;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 14,
                          primary: Colors.transparent,
                          shape: StadiumBorder(),
                        ),
                        child: Text('Get Code',
                          style: textStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: height*0.03),
                  Visibility(
                    visible: isvisible,
                    child: Text(
                      "Enter 6 Digit Verification Code",
                      style: textStyle.copyWith(
                        fontSize: 16,
                      )
                    ),
                  ),
                  SizedBox(height: height*0.02),
                  Visibility(
                    visible: isvisible,
                    child: SizedBox(
                      width: width - 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle.copyWith(),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: fieldStyle.copyWith(
                          isDense: true
                        ),
                        validator: (String value) {
                          if(value.isEmpty)
                          {
                            return "Please enter Verification Code";
                          }
                          else if(value.length!=6)
                          {
                            return "Please enter a valid Verification Code";
                          }
                          return null;
                        }
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.02),
                  Visibility(
                    visible: isvisible,
                    child: TextButton(
                        onPressed: (){},
                        child: Text(
                          "Didn't Receive The Code?",
                          style: textStyle.copyWith()
                        )
                    ),
                  ),
                  SizedBox(height: height*0.01),
                  Visibility(
                    visible: isvisible,
                    child: Container(
                        height: 30,
                        decoration: decoration.copyWith(),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 14,
                            primary: Colors.transparent,
                            shape: StadiumBorder(),
                          ),
                          child: Text('Resend Code',
                            style: textStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: height*0.04),
                  Visibility(
                    visible: isvisible,
                    child: Container(
                      height: 50,
                      width: width-80,
                      decoration: decoration.copyWith(),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formkey.currentState.validate())
                          {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Reset()));
                          }
                          else
                          {
                            print("Error");
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
