import 'dart:async';
import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrder extends StatefulWidget {

  List productList = [];
  String retailerId,address,orderDate,totalAmount;

  ConfirmOrder({Key key,this.productList,this.retailerId,this.address,this.totalAmount,this.orderDate}) : super(key: key);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {


  TextEditingController noteController = TextEditingController();
  OrderProvider _orderProvider;

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
  }

  createOrder() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "id":"",
      "uid":"$userId",
      "retailer_id":"${widget.retailerId}",
      "address":"${widget.address}",
      "order_date":"${widget.orderDate}",
      "items": widget.productList,
      "total":"${widget.totalAmount}",
      "note":"${noteController.text}"
    };

    //print(data);

    _orderProvider.insertOrder(data, "/createOrders");
    if(_orderProvider.isSuccess == true){

      getOrders();

    }

  }

  int page = 1;
  bool isloading = false;
  getOrders() async {

    setState(() {
      isloading = true;
    });

    setState(() {
      _orderProvider.orderList.clear();
      _orderProvider.incompleteOrderList.clear();
      _orderProvider.completeOrderList.clear();
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      "from_date":"",
      "to_date":"",
      "status":""
    };
    await _orderProvider.getAllOrders(data,'/getOrder/$page');


    var data1 = {
      "uid":"$userId",
      "from_date":"",
      "to_date":"",
      "status":"Pending"
    };
    await _orderProvider.getIncompleteOrders(data1,'/getOrder/$page');


    var data2 = {
      "uid":"$userId",
      "from_date":"",
      "to_date":"",
      "status":"Delivered"
    };
    await _orderProvider.getCompleteOrders(data2,'/getOrder/$page');

    if(_orderProvider.isSuccess == true){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleCustomAlert();
          }
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _orderProvider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
        bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                  height: 70,
                  color: AppColors.white,
                  child:
                  _orderProvider.isLoaded == false || isloading == true
                      ?
                  Center(
                      child: SpinKitThreeBounce(
                        color: AppColors.black,
                        size: 25.0,
                      )
                  )
                      :
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:SizedBox(
                        height: 50,
                        width: width,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                              borderRadius: round.copyWith()
                          ),
                          child: ElevatedButton(
                            onPressed: () {

                              createOrder();

                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: Colors.transparent,
                                shape: StadiumBorder()
                            ),
                            child: Text('Confirm',
                              textAlign: TextAlign.center,
                              style: textStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                    ),
                  )
              )

            ]
        ),
        backgroundColor: Colors.white,
        body:Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Flesh2.png"),
                  fit: BoxFit.fill,
                )
            ),
            child: Column(
              children: [
                SizedBox(height: height*0.05),
                Padding(
                  padding: EdgeInsets.only(right: 20,left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Image.asset("assets/images/tasks/back.png",height: 16)
                          ),
                        ),
                        Text(
                          "Create Order",
                          style: textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.01),
                Expanded(
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (OverscrollIndicatorNotification overscroll) {
                              overscroll.disallowGlow();
                              return;
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: height*0.03),
                                  Text(
                                    "Order Amount",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "₹ ${widget.totalAmount}",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    "___",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 34,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  /*Text(
                                    "Delivery Date : December 18, 2021",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),*/
                                  Divider(
                                    height: 20,
                                    color: Color.fromRGBO(185, 185, 185, 0.75),
                                    thickness: 1.2
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Item Code",
                                          style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        child: Text(
                                          "Quantity",
                                          textAlign: TextAlign.center,
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        child: Text(
                                          "Amount",
                                          textAlign: TextAlign.center,
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 20,
                                    color: Color.fromRGBO(185, 185, 185, 0.75),
                                    thickness: 1.2
                                  ),

                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(top: 10),
                                    itemCount: widget.productList.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var productData = widget.productList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${productData['sku']}",
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: Text(
                                                "${productData['qty']}",
                                                textAlign: TextAlign.center,
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: Text(
                                                "${productData['amount']}",
                                                textAlign: TextAlign.center,
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),

                                  Divider(
                                    height: 20,
                                    color: Color.fromRGBO(185, 185, 185, 0.75),
                                    thickness: 1.2
                                  ),
                                  SizedBox(height: 10),

                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Amount",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                              "₹ ${widget.totalAmount}",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Text(
                                              "Delivery Charges",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                              "Free",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Total Amount",
                                          style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          "₹ ${widget.totalAmount}",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Remark",
                                      style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height*0.01),
                                  TextFormField(
                                    controller: noteController,
                                    style: textStyle.copyWith(
                                      color: AppColors.black
                                    ),
                                    cursorColor: AppColors.black,
                                    cursorHeight: 22,
                                    decoration: fieldStyle1.copyWith(
                                      hintText: "Add Remark",
                                      hintStyle: textStyle.copyWith(
                                        color: AppColors.black
                                      ),
                                      isDense: true
                                    )
                                  ),
                                  SizedBox(height: height*0.01),
                                ],
                              ),
                            ),
                          )
                      ),
                    )
                )
              ],
            )
        )
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
        Duration(milliseconds: 1000),
        () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,

      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
          borderRadius: round.copyWith(),
        ),
        height: 100,
        width: width/1.4,
        child: Center(
          child: Text(
            "Order Confirmed",
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
          ),
        ),
      ),
    );
  }
}