import 'package:colorsoul/appColors.dart';
import 'package:colorsoul/dashboard.dart';
import 'package:flutter/material.dart';
import 'components.dart';
import 'forgot.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController t1 = new TextEditingController(text: "abc@gmail.com");
  TextEditingController t2 = new TextEditingController(text: "12345");

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
            child: Form(
              key: _formkey,
              child: Stack(
                  children: [
                    Stack(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Image.asset('assets/images/upper.png')
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:45,right: 30,left: 30),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      height: 30,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
                                        borderRadius: round.copyWith()
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          elevation: 14,
                                          primary: Colors.transparent,
                                          shape: StadiumBorder()
                                      ),
                                      child: Text('!',
                                        style: textStyle.copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.04),
                                Image.asset('assets/images/Colorsoul_final-022(Traced).png',width: width-180),
                                SizedBox(height: height*0.07),
                                TextFormField(
                                    controller: t1,
                                    style: textStyle.copyWith(),
                                    cursorColor: Colors.white,
                                    textAlign: TextAlign.center,
                                    decoration: fieldStyle.copyWith(
                                        hintText: "Email / username",
                                        isDense: true,

                                    ),
                                    validator: (String value) {
                                      if(value.isEmpty)
                                      {
                                        return "Please enter Email";
                                      }
                                      else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                                      {
                                        return "Please enter a valid Email";
                                      }
                                      return null;
                                    }
                                ),
                                SizedBox(height: height*0.03),
                                TextFormField(
                                    controller: t2,
                                    obscureText: true,
                                    style: textStyle.copyWith(),
                                    cursorColor: Colors.white,
                                    textAlign: TextAlign.center,
                                    decoration: fieldStyle.copyWith(
                                        hintText: "Password",
                                        isDense: true
                                    ),
                                    validator: (String value) {

                                      if(value.isEmpty)
                                      {
                                        return "Please enter Password";
                                      }
                                      return null;
                                    }
                                ),
                                SizedBox(height: height*0.04),
                                CheckBox(),
                                SizedBox(height: height*0.01),
                                TextButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Forgot()));
                                    },
                                    child: Text(
                                        "Forgot Your Password?",
                                        style: textStyle.copyWith()
                                    )
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 30,
                            left: 30,
                            child: Container(
                                height: 100,
                                width: width-80,
                                padding: EdgeInsets.only(top: 50),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                    borderRadius: round.copyWith(),
                                    boxShadow: [new BoxShadow(
                                    color: Color.fromRGBO(60, 57, 57, 0.8),
                                    offset: Offset(0, 10),
                                    blurRadius: 20,
                                  )]
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(_formkey.currentState.validate())
                                      {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
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
                                    child: Text('Login',
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      )
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ]
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
            color: AppColors.white
          ),
          shape: StadiumBorder(),
          activeColor: Colors.black,
          value: this.value,
          onChanged: (bool value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        Text(
            "Keep me Signed in",
            style: textStyle.copyWith()
        )
      ],
    );
  }
}
