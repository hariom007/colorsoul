import 'package:colorsoul/Ui/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Values/appColors.dart';
import '../../Values/components.dart';

class ForgotPin extends StatefulWidget {
  const ForgotPin({Key key}) : super(key: key);

  @override
  _ForgotPinState createState() => _ForgotPinState();
}

class _ForgotPinState extends State<ForgotPin> {
  final key = new GlobalKey<ScaffoldState>();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: key,
        backgroundColor: Colors.black,
        body:Container(
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
                child: Padding(
                  padding: EdgeInsets.only(top:45,right: 30,left: 30),
                  child: Column(
                    children: [
                      SizedBox(height: height*0.05),
                      Image.asset('assets/images/Colorsoul_final-022(Traced).png',width: width/1.8),
                      SizedBox(height: height*0.1),
                      Text(
                        "Generate PIN",
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      SizedBox(height: height*0.04),
                      Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Enter PIN",
                            style: textStyle.copyWith(
                              fontSize: 12
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: PinCodeTextField(
                          blinkDuration: Duration(milliseconds: 1000),
                          blinkWhenObscuring: true,
                          controller: t1,
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: round2.copyWith(),
                              borderWidth: 1,
                              fieldHeight: 40,
                              fieldWidth: 50,
                              activeColor: AppColors.white,
                              inactiveColor: AppColors.white,
                              selectedColor: AppColors.white
                          ),
                          cursorColor: Colors.white,
                          animationType: AnimationType.fade,
                          cursorHeight: 20,
                          length: 4,
                          autoDismissKeyboard: true,
                          obscuringCharacter: "•",
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textStyle: textStyle.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          appContext: context,
                          onChanged: (String value) {},
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Confirm PIN",
                            style: textStyle.copyWith(
                                fontSize: 12
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: PinCodeTextField(
                          blinkDuration: Duration(milliseconds: 1000),
                          blinkWhenObscuring: true,
                          controller: t2,
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: round2.copyWith(),
                              borderWidth: 1,
                              fieldHeight: 40,
                              fieldWidth: 50,
                              activeColor: AppColors.white,
                              inactiveColor: AppColors.white,
                              selectedColor: AppColors.white
                          ),
                          cursorColor: Colors.white,
                          animationType: AnimationType.fade,
                          cursorHeight: 20,
                          length: 4,
                          autoDismissKeyboard: true,
                          obscuringCharacter: "•",
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textStyle: textStyle.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          appContext: context,
                          onChanged: (String value) {},
                        ),
                      ),
                      SizedBox(height: height*0.13),
                      Container(
                        height: 50,
                        width: width-80,
                        decoration: decoration.copyWith(),
                        child: ElevatedButton(
                          onPressed: () {
                            if(t1.text.length==0)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: AppColors.white,
                                  content: Text(
                                    'Please Enter Pin',
                                    style: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                  ),
                                )
                              );
                            }
                            else if(t2.text.length==0)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: AppColors.white,
                                  content: Text(
                                    'Please Enter Confirm Pin',
                                    style: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                  ),
                                )
                              );
                            }
                            else if(t1.text == t2.text)
                            {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text(
                                    'Pin Reset Successful',
                                    style: textStyle.copyWith(),
                                  ),
                                )
                              );
                            }
                            else if(t1.text != t2.text)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: AppColors.white,
                                  content: Text(
                                    "Pin Dosen't Match",
                                    style: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                  ),
                                )
                              );
                            }
                            else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: AppColors.white,
                                  content: Text(
                                    "Invalid Pin",
                                    style: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                  ),
                                )
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 14,
                            primary: Colors.transparent,
                            shape: StadiumBorder(),
                          ),
                          child: Text('Continue',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}
