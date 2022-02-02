import 'dart:async';
//import 'package:colorsoul/components.dart';
import 'package:colorsoul/Provider/auth_provider.dart';
import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Ui/Pin/pin.dart';
import 'package:colorsoul/locater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'appColors.dart';
import 'Ui/Login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => DistributorProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Colorsoul',
        home: splash(),
        //home: testClass(),
      ),
    );
  }
}

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {

  AuthProvider _authProvider;

  @override
  void initState()
  {

    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    super.initState();
    getUserData();

  }

  loginMethod() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userName = sharedPreferences.get("number");
    password = sharedPreferences.get("password");

    var data = {
      "username": "$userName",
      "password": "$password"
    };


    await _authProvider.loginApi(data,'/login');
    if(_authProvider.isSuccess == true){

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      var body = _authProvider.loginData;
      sharedPreferences.setString('userId', '${body['uid']}');
      sharedPreferences.setString('name', '${body['name']}');
      sharedPreferences.setString('mobile', '${body['mobile']}');
      sharedPreferences.setString('email', '${body['email']}');
      sharedPreferences.setString('address', '${body['address']}');
      sharedPreferences.setString('image', '${body['image']}');

      userPin = sharedPreferences.get("pin");
      userName = sharedPreferences.get("number");
      password = sharedPreferences.get("password");
      name = sharedPreferences.get("name");
      bool authValue = sharedPreferences.getBool("authValue");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pin(
        userPin: userPin,userName: userName,authValue: authValue,name: name
      )));

    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }

  }


  String userName,password,userPin,name;

  getUserData() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userName = sharedPreferences.get("pin");

    if(userName != null){
      loginMethod();
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          SingleChildScrollView(child: Image.asset('assets/images/Flesh2.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)),
          Center(
            child: Image.asset('assets/images/Colorsoul_final-022(Traced).png',width: width - 180,)
          )
        ],
      )
    );
  }
}