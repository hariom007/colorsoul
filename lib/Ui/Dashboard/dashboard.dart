import 'package:colorsoul/Ui/Dashboard/NewOrder/sales_order.dart';
import 'package:colorsoul/Ui/Dashboard/OrderList/Sales_order_screen.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/retailer_inventory.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/neworder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'Add_distributers/add_distributers.dart';
import 'CreateToDo/to_do.dart';
import 'Distributers/distributers.dart';
import '../../Values/appColors.dart';
import 'Notes/notes.dart';
import 'OrderList/order_list.dart';
import 'Products/products.dart';
import '../../locater.dart';
import 'Home/home.dart';
import 'bottombar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int index = 0;

   final pages = <Widget>[
    Home(),
    Distributors(),
    //Products(),
     SalesOrderList(),
    OrderList(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(0),
                contentPadding: EdgeInsets.all(0),
                backgroundColor: Colors.transparent,
                content: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: round1.copyWith()
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Are you sure you want to exit?',
                          style: textStyle.copyWith(
                              fontSize: 16,
                              color: AppColors.black
                          ),
                        ),
                        SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
                                'No',
                                style: textStyle.copyWith(
                                    color: AppColors.black
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            TextButton(
                              child: Text(
                                'Yes, exit',
                                style: textStyle.copyWith(
                                    color: AppColors.black
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        );
        return value == true;
      },
      child: Scaffold(
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes()));
              }
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ToDo()));
              }
            ),
            /*SpeedDialChild(
                child: Image.asset("assets/images/home/home1.png",width: 20,height: 20),
                labelWidget: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                      "Retailer Inventory",
                      style: textStyle.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => RetailerInventory()));
                }
            ),*/
            SpeedDialChild(
                child: Image.asset("assets/images/cartbox.png",width: 24,height: 24),
                labelWidget: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                      "Create Distributor Order",
                      style: textStyle.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SalesOrder()));
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RetailerInventory()));

                //Navigator.push(context, MaterialPageRoute(builder: (context) => NewOrder()));
              }
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
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddDistributers()));
              }
            ),
          ],
          // child: Image.asset("assets/images/add.png",width: 20)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  void onChangedTab(int index){
    setState(() {
      this.index = index;
    });
  }
}