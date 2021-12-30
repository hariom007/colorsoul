import 'package:flutter/material.dart';
import 'appColors.dart';

var textStyle = TextStyle(
    color: AppColors.white,
    fontFamily: "Roboto-Regular"
);

var fieldStyle = InputDecoration(
    hintStyle: TextStyle(fontSize: 15 ,color: Colors.white),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(30)
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30)
        ),
        borderSide: BorderSide(
          color: Colors.white,
        )
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30)
        ),
        borderSide: BorderSide(
          color: Colors.red,
        )
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30)
        ),
        borderSide: BorderSide(
          color: Colors.red,
        )
    )
);

var fieldStyle1 = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topRight: Radius.circular(30)
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topRight: Radius.circular(30)
    ),
  )
);

var decoration = BoxDecoration(
    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
    borderRadius: round,
    boxShadow: [new BoxShadow(
      color: Color.fromRGBO(60, 57, 57, 0.8),
      offset: Offset(0, 10),
      blurRadius: 20,
    )]
);

var decoration1 = BoxDecoration(
    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Color(0xFFFF647C),Color(0xFFD62A44)]),
    shape: BoxShape.circle,
    boxShadow: [new BoxShadow(
      color: Color.fromRGBO(60, 57, 57, 0.8),
      offset: Offset(0, 2),
      blurRadius: 3,
    )]
);

var decoration2 = BoxDecoration(
    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Color(0xFF05DEBF),Color(0xFF078472)]),
    shape: BoxShape.circle,
    boxShadow: [new BoxShadow(
      color: Color.fromRGBO(60, 57, 57, 0.8),
      offset: Offset(0, 2),
      blurRadius: 3,
    )]
);

var decoration3 = BoxDecoration(
    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Color(0xFFFFD360),Color(0xFFDEA100)]),
    shape: BoxShape.circle,
    boxShadow: [new BoxShadow(
      color: Color.fromRGBO(60, 57, 57, 0.8),
      offset: Offset(0, 2),
      blurRadius: 3,
    )]
);

var round = BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
    topRight: Radius.circular(30)
);

var round1 = BorderRadius.only(
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
    topRight: Radius.circular(20)
);

var round2 = BorderRadius.only(
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
    topRight: Radius.circular(10)
);