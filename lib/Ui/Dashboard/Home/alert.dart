import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset("assets/images/productsdata/back1.png",width: 20,height: 16,color: AppColors.white),
            ),
            SizedBox(width: 10),
            Text(
              "Alert",
              style: textStyle.copyWith(
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/home/bell1.png",height: 150,width: 150),
            SizedBox(height: 20),
            Text(
              "No Notification Yet",
              style: textStyle.copyWith(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      )
    );
  }
}
