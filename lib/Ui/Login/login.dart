import 'package:colorsoul/Provider/auth_provider.dart';
import 'package:colorsoul/Ui/Pin/forgotpin.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Values/components.dart';
import '../Forgot/forgot.dart';
import '../Pin/pin.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController numberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();

    _authProvider = Provider.of<AuthProvider>(context, listen: false);

  }

  loginMethod() async {

    var data = {
      "username": "${numberController.text}",
      "password": "${passwordController.text}"
    };

    await _authProvider.loginApi(data,'/login');
    if(_authProvider.isSuccess == true){

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('number', '${numberController.text}');
      sharedPreferences.setString('password', '${passwordController.text}');

      var body = _authProvider.loginData;
      sharedPreferences.setString('userId', '${body['sales_id']}');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPin()));

    }

  }

  bool isPhone(String input) {
    if(input.length != 10){
      return false;
    }
    else{
      return true;
    }
  }

  bool isEmail(String input) => RegExp(
      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]"
  ).hasMatch(input);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.black,
        body:Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/images/Rectangle17.png"),
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
              child: Padding(
                padding: EdgeInsets.only(top:45,right: 30,left: 30),
                child: Column(
                  children: [
                    SizedBox(height: height*0.02),
                    Image.asset('assets/images/Colorsoul_final-022(Traced).png',width: width/1.8,color: AppColors.black,),
                    SizedBox(height: height*0.04),
                    Image.asset('assets/images/Group668.png',width: width/1.8),
                    SizedBox(height: height*0.05),
                    Container(
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topLeft,
                            focal: Alignment.centerLeft,
                            radius: 4,
                            colors: [
                              AppColors.grey2,
                              AppColors.grey4,
                              AppColors.grey2,
                            ],
                          ),
                          borderRadius: round.copyWith(),
                          boxShadow: [new BoxShadow(
                            color: Color.fromRGBO(0,0,0, 0.2),
                            offset: Offset(0, 5),
                            blurRadius: 5,
                          )
                        ]
                      ),
                      child: TextFormField(
                        controller: numberController,
                        style: textStyle.copyWith(
                          color: AppColors.black
                        ),
                        cursorColor: AppColors.black,
                        textAlign: TextAlign.center,
                        decoration: fieldStyle3.copyWith(
                          errorStyle: TextStyle(height: 0),
                          hintText: "Email / Number",
                          hintStyle: textStyle.copyWith(
                              color: AppColors.black
                          ),
                          isDense: true,
                        ),
                        validator: (String value) {
                          if (!isEmail(value) && !isPhone(value)) {
                            return '';
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(height: height*0.03),
                    Container(
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topLeft,
                            focal: Alignment.centerLeft,
                            radius: 4,
                            colors: [
                              AppColors.grey2,
                              AppColors.grey4,
                              AppColors.grey2,
                            ],
                          ),
                          borderRadius: round.copyWith(),
                          boxShadow: [new BoxShadow(
                            color: Color.fromRGBO(0,0,0, 0.2),
                            offset: Offset(0, 5),
                            blurRadius: 5,
                          )
                        ]
                      ),
                      child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          style: textStyle.copyWith(
                            color: AppColors.black
                          ),
                          cursorColor: AppColors.black,
                          textAlign: TextAlign.center,
                          decoration: fieldStyle3.copyWith(
                            hintStyle: textStyle.copyWith(
                                color: AppColors.black
                            ),
                            errorStyle: TextStyle(height: 0),
                            hintText: "Password",
                            isDense: true
                          ),
                          validator: (String value) {

                            if(value.isEmpty)
                            {
                              return "";
                            }
                            return null;
                          }
                      ),
                    ),
                    SizedBox(height: height*0.02),
                    CheckBox(),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Forgot()));
                        },
                        child: Text(
                          "Forgot Your Password?",
                          style: textStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold
                          )
                        )
                    ),

                    _authProvider.isLoaded == false
                        ?
                      SpinKitThreeBounce(
                        color: AppColors.black,
                        size: 25.0,
                      )
                        :
                      Container(
                        height: 50,
                        width: width-80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                            borderRadius: round.copyWith(),
                            boxShadow: [new BoxShadow(
                              color: Color.fromRGBO(0,0,0, 0.2),
                              offset: Offset(0, 6),
                              blurRadius: 3,
                            )
                          ]
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if(_formkey.currentState.validate())
                            {
                              loginMethod();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 14,
                            primary: Colors.transparent,
                            shape: StadiumBorder(),
                          ),
                          child: Text('Login',
                              style: textStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white
                              )
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        )
      )
    );
  }
}

class CheckBox extends StatefulWidget {
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          side: BorderSide(
            color: AppColors.black
          ),
          //shape: StadiumBorder(),
          activeColor: Colors.grey,
          checkColor: AppColors.black,
          value: this.value,
          onChanged: (bool value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        Text(
            "Enables biometric access to Login",
            style: textStyle.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold
            )
        )
      ],
    );
  }
}
