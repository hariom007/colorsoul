import 'package:colorsoul/components.dart';
import 'package:colorsoul/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'alert.dart';
import 'appColors.dart';
import 'bottombar.dart';
import 'products.dart';
import 'locater.dart';
import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int index = 0;

   final pages = <Widget>[
    Home(),
    Calendar(),
    Alert(),
    Data(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[index],
      bottomNavigationBar: BottomBar(
        index : index,
        onChangedTab : onChangedTab,
      ),
      floatingActionButton: SpeedDial(
        spaceBetweenChildren: 8,
        //renderOverlay: false,
        backgroundColor: AppColors.black,
        overlayColor: Colors.transparent,
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
              child: Padding(
                padding: EdgeInsets.only(right: 2),
                child: Image.asset("assets/images/home/TN.png",width: 26,height: 26),
              ),
              labelWidget: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  "Add Notes",
                  style: textStyle.copyWith(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
          ),
          SpeedDialChild(
            child: Padding(
              padding: EdgeInsets.only(left: 2),
              child: Image.asset("assets/images/home/TDT.png",width: 26,height: 26),
            ),
            labelWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "Create To Do",
                style: textStyle.copyWith(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Tasks()));
            }
          ),
          SpeedDialChild(
            child: Image.asset("assets/images/cartbox.png",width: 24,height: 24),
            labelWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                  "Create new Order",
                  style: textStyle.copyWith(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ),
          SpeedDialChild(
            child: Image.asset("assets/images/home/home1.png",width: 20,height: 20),
            labelWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "Add new distributor/Retailer",
                style: textStyle.copyWith(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        ],
        // child: Image.asset("assets/images/add.png",width: 20)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void onChangedTab(int index){
    setState(() {
      this.index = index;
    });
  }
}