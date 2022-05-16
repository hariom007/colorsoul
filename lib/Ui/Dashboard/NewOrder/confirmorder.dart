import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/Pdf/savefile.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;


class ConfirmOrder extends StatefulWidget {

  List productList = [];
  String orderid,retailerId,retailerName,retailerNumber,state,address,orderDate,totalAmount,totalIgst,totalCgst,totalSgst;

  ConfirmOrder({Key key,this.orderid,this.retailerNumber,this.retailerName,this.productList,this.retailerId,this.address,this.state,
    this.totalAmount,this.orderDate,this.totalCgst,this.totalIgst,this.totalSgst
  }) : super(key: key);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  OrderProvider _orderProvider;

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);


  }

  pagecount(){

    double a = widget.productList.length/25;
    //print(a%4);
    if((a)%1 == 0){
      pageLength = a.toInt();
    }
    else{
      pageLength = a.toInt()+1;
    }
    //print(pageLength);

    if(pageLength==0){
      pageLength=1;
    }

    _createPDF();


  }

  List paymentMethods = [];

  createOrder() async {

    String grandTotal =
    roundingController.text == "" || roundingController.text == "+" || roundingController.text == "-"
        ?
    "${double.parse("${widget.totalAmount}")+double.parse("${widget.totalIgst}")}"
        :
    "${double.parse("${widget.totalAmount}")+double.parse("${widget.totalIgst}")+double.parse("${roundingController.text}")}";


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      "sales_bill_no":"${widget.orderid}",
      "sales_date":"${widget.orderDate}",
      "distributor_id":"${widget.retailerId}",
      "cl_group_color":"",
      "state": widget.state == null ? "" : widget.state,
      "items": widget.productList,
      "discount":"2",
      "total":"$grandTotal",
      "total_cgst":"${widget.totalCgst}",
      "total_igst":"${widget.totalIgst}",
      "total_sgst":"${widget.totalSgst}",
      "pay_mode": paymentMethods
    };

    print(data);

    await _orderProvider.insertSalesOrder(data, "/add_salesorder");

    if(_orderProvider.isSuccess == true){

      pagecount();

      Navigator.pop(context);
      Navigator.pop(context);

/*
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleCustomAlert();
          }
      );
      */

    }

  }

  int page = 1;
  bool isloading = false;

  bool isCash = false,isCheque = false,isCard = false,isVoucher = false;
  TextEditingController cashAmountController = TextEditingController();
  TextEditingController cashDetailsController = TextEditingController();

  TextEditingController chequeAmountController = TextEditingController();
  TextEditingController chequeDetailsController = TextEditingController();

  TextEditingController cardAmountController = TextEditingController();
  TextEditingController cardDetailsController = TextEditingController();

  TextEditingController voucherAmountController = TextEditingController();
  TextEditingController voucherDetailsController = TextEditingController();

  TextEditingController roundingController = TextEditingController(text: "0");

/*

  selectPaymentMethod() {

    final _formkey2 = GlobalKey<FormState>();

    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled:true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {

                  return Form(
                    key: _formkey2,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        height: MediaQuery.of(context).size.height-100,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [

                                  Expanded(
                                    child: Text(
                                      "Select Payment Method",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){

                                      Navigator.pop(context);

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.close),
                                    ),
                                  )


                                ],
                              ),

                              SizedBox(height: 20),

                              Row(
                                children: [

                                  Container(
                                      width: 25,
                                      height: 25,
                                      child: Checkbox(
                                          value: isCash,
                                          checkColor: AppColors.white,
                                          activeColor: AppColors.black,
                                          onChanged: (value){
                                            setState((){
                                              isCash = !isCash;
                                            });
                                          })
                                  ),

                                  SizedBox(width: 20),

                                  Text(
                                    'Cash',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black
                                    ),
                                  ),

                                ],
                              ),

                              isCash == true
                                  ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: MediaQuery.of(context).size.width*0.03),

                                  TextFormField(
                                      controller: cashAmountController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Amount",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),

                                  SizedBox(height: 10),

                                  TextFormField(
                                      controller: cardDetailsController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Details",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),

                                ],
                              ):SizedBox(),

                              SizedBox(height: 20),

                              Row(
                                children: [

                                  Container(
                                      width: 25,
                                      height: 25,
                                      child: Checkbox(
                                          value: isCheque,
                                          checkColor: AppColors.white,
                                          activeColor: AppColors.black,
                                          onChanged: (value){
                                            setState((){
                                              isCheque = !isCheque;
                                            });
                                          })
                                  ),

                                  SizedBox(width: 20),

                                  Text(
                                    'Cheque',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black
                                    ),
                                  ),

                                ],
                              ),

                              isCheque == true
                                  ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: MediaQuery.of(context).size.width*0.03),

                                  TextFormField(
                                      controller: chequeAmountController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Amount",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                      controller: chequeDetailsController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Details",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),

                                ],
                              ):SizedBox(),

                              SizedBox(height: 20),

                              Row(
                                children: [

                                  Container(
                                      width: 25,
                                      height: 25,
                                      child: Checkbox(
                                          value: isCard,
                                          checkColor: AppColors.white,
                                          activeColor: AppColors.black,
                                          onChanged: (value){
                                            setState((){
                                              isCard = !isCard;
                                            });
                                          })
                                  ),

                                  SizedBox(width: 20),

                                  Text(
                                    'Card',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black
                                    ),
                                  ),

                                ],
                              ),

                              isCard == true
                                  ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: MediaQuery.of(context).size.width*0.03),

                                  TextFormField(
                                      controller: cardAmountController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Amount",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                      controller: cardDetailsController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Details",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),

                                ],
                              ):SizedBox(),

                              SizedBox(height: 20),

                              Row(
                                children: [

                                  Container(
                                      width: 25,
                                      height: 25,
                                      child: Checkbox(
                                          value: isVoucher,
                                          checkColor: AppColors.white,
                                          activeColor: AppColors.black,
                                          onChanged: (value){
                                            setState((){
                                              isVoucher = !isVoucher;
                                            });
                                          })
                                  ),

                                  SizedBox(width: 20),

                                  Text(
                                    'Voucher',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black
                                    ),
                                  ),

                                ],
                              ),


                              isVoucher == true
                                  ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: MediaQuery.of(context).size.width*0.03),

                                  TextFormField(
                                      controller: voucherAmountController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Amount",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                      controller: voucherDetailsController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Details",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),

                                ],
                              ):SizedBox(),

                              SizedBox(height: 20),

                              SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                        borderRadius: round.copyWith()
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {


                                        if(isCash == true){

                                          var data = {
                                            "mode":"cash",
                                            "amount":"${cashAmountController.text}",
                                            "note":"${cashDetailsController.text}"
                                          };
                                          paymentMethods.add(data);
                                        }

                                        if(isCheque == true){

                                          var data = {
                                            "mode":"cheque",
                                            "amount":"${chequeAmountController.text}",
                                            "note":"${chequeDetailsController.text}"
                                          };
                                          paymentMethods.add(data);
                                        }

                                        if(isCard == true){

                                          var data = {
                                            "mode":"card",
                                            "amount":"${cardAmountController.text}",
                                            "note":"${cardDetailsController.text}"
                                          };
                                          paymentMethods.add(data);
                                        }

                                        if(isVoucher == true){

                                          var data = {
                                            "mode":"voucher",
                                            "amount":"${voucherAmountController.text}",
                                            "note":"${voucherDetailsController.text}"
                                          };
                                          paymentMethods.add(data);
                                        }

                                        Navigator.pop(context);
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

                            ],
                          ),
                        )
                    ),
                  );
                }
            ),
          );
        }
    ).whenComplete(() {
      setState(() {

      });
    });
  }

*/

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

                              //selectPaymentMethod();

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
                                  SizedBox(height: 20),
                                  Text(
                                    "₹ ${double.parse(widget.totalAmount).toStringAsFixed(2)}",
                                    //"₹ ${widget.totalAmount}",
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
                                      fontSize: 20,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 10),
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
                                                "${productData['name']}",
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
                                                "${productData['price']}",
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
                                              "₹ ${double.parse(widget.totalAmount).toStringAsFixed(2)}",
                                              //"₹ ${widget.totalAmount}",
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
                                          "₹ ${double.parse(widget.totalAmount).toStringAsFixed(2)}",
                                          //"₹ ${widget.totalAmount}",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  widget.state == "Maharashtra"
                                  ?
                                      SizedBox()
                                  :
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(child: Container()),
                                        Text(
                                          "Total Igst  -  ",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          "₹ ${widget.totalIgst}",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  widget.state == "Maharashtra"
                                      ?
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(child: Container()),
                                        Text(
                                          "Cgst  -  ",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "₹ ${widget.totalCgst}",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  :
                                      SizedBox(),

                                  SizedBox(height: 10),
                                  widget.state == "Maharashtra"
                                      ?
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(child: Container()),
                                        Text(
                                          "Sgst  - ",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          "₹ ${widget.totalSgst}",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                      :
                                  SizedBox(),

                                  SizedBox(height: 15),

                                  Row(
                                    children: [

                                      Expanded(child: Container()),

                                      Text(
                                        "Rounding  - ",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),


                                      Container(
                                        width: 100,
                                        child: TextFormField(
                                          controller: roundingController,
                                          inputFormatters: <TextInputFormatter>[
                                            //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                                            FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
                                          ],
                                          keyboardType: TextInputType.number,
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: AppColors.black
                                          ),
                                          cursorHeight: 22,
                                          textAlign: TextAlign.center,
                                          cursorColor: Colors.grey,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.only(),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.only(),
                                            ),
                                            isDense: true,
                                            hintText: "Rounding",
                                            errorStyle: TextStyle(height: 0,fontSize: 0),
                                          ),
                                          onChanged: (value){
                                            setState(() {
                                              print("$value");
                                            });
                                          },
                                        ),
                                      ),

                                    ],
                                  ),

                                  SizedBox(height: 15),

                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Grand Amount",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          roundingController.text == "" || roundingController.text == "+" || roundingController.text == "-"
                                              ?
                                          "₹ ${double.parse("${double.parse("${widget.totalAmount}")+double.parse("${widget.totalIgst}")}").toStringAsFixed(2)}"
                                            :
                                          "₹ ${double.parse("${double.parse("${widget.totalAmount}")+double.parse("${widget.totalIgst}")+double.parse("${roundingController.text}")}").toStringAsFixed(2)}",
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
                                  /*Align(
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
                                  ),*/
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

  String url = "";
  sendImage(path) async {

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "4ccda7514adc0f13595a585205fb9761"
    };

    final uri = 'https://colorsoul.koffeekodes.com/admin/Api/imageUpload';
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(headers);

    request.fields['folder'] = "profile";
    request.files.add(await http.MultipartFile.fromPath('file', path));

    request.send().then((response) async {
      var res = await response.stream.bytesToString();
      print(res);
      var body = json.decode(res);

      if (response.statusCode == 200 && body['st'] == "success") {

        print("Upload done");

        url = body['file'];
        sendOnWhatsapp(url);
      }
      else{
        Navigator.pop(context);

        Fluttertoast.showToast(
            msg: "Pdf Upload Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    });

  }

  sendOnWhatsapp(String url) async {

    var data = {

      "key": "fd3b0043e7a54dffa1778d00a9e8828e",
      "to": "918866609678",
      "url": url,
      "filename": "Invoice_No_${widget.orderid}.pdf",
      "isUrgent": true
    };
    await _orderProvider.SendWhatsapp(data,'http://smartwhatsapp.dove-sms.com/api/v1/sendDocument');
    if(_orderProvider.isSendWhatsapp == true){
      print("Send On Whatsapp done");
    }
  }

  int pageLength;
  bool isLoading = false;
  Future<void> _createPDF() async {
    //Create a new PDF document


    PdfDocument document = PdfDocument();
    List<PdfPage> pageList=[];
    List<PdfGrid> gridList=[];
    List<PdfGridRow> hadderList=[];
    List<PdfGridRow> rowList=[];


    //  ------ Style ----------------------------------------------------------
    PdfStringFormat format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
        wordSpacing: 10);
    PdfGridRowStyle rowStylebold = PdfGridRowStyle(
        font: PdfStandardFont(
            PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold));
    PdfGridRowStyle rowStyle = PdfGridRowStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 11));
    PdfGridCellStyle cellStyle1 = PdfGridCellStyle(
      //cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
      font: PdfStandardFont(
          PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),
    );

    PdfBorders borderu = PdfBorders(
      top: PdfPen(PdfColor.empty),
    );
    PdfBorders borderb = PdfBorders(
      bottom: PdfPen(PdfColor.empty),
    );

    PdfBorders bordempty = PdfBorders(
      bottom: PdfPen(PdfColor.empty),
      top: PdfPen(PdfColor.empty),
    );

    PdfGridStyle gridStyle = PdfGridStyle(
      cellPadding: PdfPaddings(left: 7, right: 7, top: 3, bottom: 0),
    );
    PdfGridStyle gridStyle1 = PdfGridStyle(
      cellPadding: PdfPaddings(left: 7, right: 7, top: 4, bottom: 4),
    );
    PdfGridStyle gridStylewithheader = PdfGridStyle(
      cellPadding: PdfPaddings(left: 5, right: 5, top: 03, bottom: 0),
    );

    // Page - create
    for(int i=0;i<pageLength;i++){
      pageList.add(document.pages.add());
      gridList.add(PdfGrid());
      gridList[i].columns.add(count: 5);
      gridList[i].headers.add(1);
      pageList[0].graphics.drawString(
          'Tax Invoice',
          PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(225, 00, 500, 0));
      PdfBorders border = PdfBorders(
        bottom: PdfPen(PdfColor.empty),
        top: PdfPen(PdfColor.empty),
        left: PdfPen(PdfColor.empty),
        right: PdfPen(PdfColor.empty),
      );
    }

    int x=0;
    int y=25;
    if(y>widget.productList.length){
      y=widget.productList.length;
    }

    // Grid Create / Header Create -----------------
    for(int i=0;i<gridList.length;i++){

      hadderList.add(gridList[i].headers[0]);
      hadderList[i].cells[0].value ="Sr.";//Save the document
      hadderList[i].cells[1].value ="Item Code";//Save the document
      hadderList[i].cells[2].value ="Quantity";
      hadderList[i].cells[3].value ="Rate";
      hadderList[i].cells[4].value ="Amount";

      hadderList[i].style = rowStyle;

      gridList[i].columns[0].width=30;
      gridList[i].columns[1].width=250;
      gridList[i].columns[2].width=60;
      gridList[i].columns[3].width=60;
      gridList[i].columns[4].width=110;
      gridList[i].rows.applyStyle(gridStylewithheader);

      // header.cells[0].style =PdfGridCellStyle(,cellPadding: PdfPaddings(left: 100,right: 100));
      hadderList[i].cells[0].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);
      hadderList[i].cells[1].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 2);
      hadderList[i].cells[2].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);
      hadderList[i].cells[3].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);
      hadderList[i].cells[4].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);


      for (int j = x; j < y; j++) {

        rowList.add(gridList[i].rows.add());
        rowList[j].cells[0].value=(j+1).toString();
        rowList[j].cells[1].value = widget.productList[j]["name"];
        rowList[j].cells[2].value = widget.productList[j]["qty"];
        rowList[j].cells[3].value = widget.productList[j]["price"];
        rowList[j].cells[4].value = "${double.parse("${widget.productList[j]["qty"]}") * double.parse("${widget.productList[j]["price"]}")}";

        rowList[j].cells[1].style = cellStyle1;
        rowList[j].cells[2].style = cellStyle1;
        rowList[j].cells[3].style = cellStyle1;
        rowList[j].cells[4].style = cellStyle1;

        rowList[j].cells[i].style = PdfGridCellStyle(
          cellPadding: PdfPaddings(left: 3, right: 3, top: 4, bottom: 0),
          font: PdfStandardFont(PdfFontFamily.timesRoman, 10,style: PdfFontStyle.bold),
        );
        rowList[j].cells[1].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[0].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[1].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[2].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[3].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[4].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );

      }

      x=y;
      y=y+25;

      print(widget.productList.length);
      if(y>widget.productList.length){
        y=widget.productList.length;
      }

      PdfGridRow r2=gridList[i].rows.add();

      for (int d = 0; d < gridList[i].columns.count; d++) {
        if(d==1||d==4){
          r2.cells[d].style = PdfGridCellStyle(
            cellPadding: PdfPaddings(left: 2, right: 3, top: 5, bottom: 5),
            font: PdfStandardFont(PdfFontFamily.timesRoman, 10,style: PdfFontStyle.bold),
          );
          if(d==1){

            r2.cells[d].style = PdfGridCellStyle(
              cellPadding: PdfPaddings(left: 2, right: 3, top: 0, bottom: 5),
              font: PdfStandardFont(PdfFontFamily.timesRoman, 10,style: PdfFontStyle.bold),
            );
            r2.cells[d].style.stringFormat = PdfStringFormat(
                alignment: PdfTextAlignment.right,
                lineAlignment: PdfVerticalAlignment.middle,
                wordSpacing: 0);
          }
        }

      }
      r2.cells[4].value=" Rs.${widget.totalAmount}\n ${widget.totalIgst}\n\n Rs.${double.parse('${widget.totalAmount}')+double.parse('${widget.totalIgst}')}";
      r2.cells[1].value="Amount \nGst \n\nTotal Amount ";

      PdfGrid gridu = PdfGrid();

      gridu.columns.add(count: 1);
      gridu.headers.add(0);
      gridu.rows.applyStyle(gridStyle1);
      gridu.columns[0].width = 510;

//Add rows to grid
      PdfGridRow rowug3 = gridu.rows.add();
      rowug3.cells[0].value = "Invoice No : ${widget.orderid}";
      rowug3.cells[0].style.borders = borderb;
      rowug3.style = rowStyle;

      PdfGridRow rowug1 = gridu.rows.add();
      rowug1.cells[0].value = "Retailer Name : ${widget.retailerName}";
      rowug1.style = rowStylebold;
      rowug1.cells[0].style.borders = bordempty;

      PdfGridRow rowup2 = gridu.rows.add();
      rowup2.cells[0].value = "Address : ${widget.address}";
      rowup2.style = rowStylebold;
      rowup2.cells[0].style.borders = bordempty;


      PdfLayoutResult result,result1;

      result = gridu.draw(
          page: pageList[i],
          bounds: const Rect.fromLTWH(0, 25, 510, 3000));

      //--------------------------------------------------------------TOP SECOND GRID  ---------------------------------
      result1 = gridList[i].draw(
          page: pageList[i],
          bounds: Rect.fromLTWH(0, result.bounds.bottom, 510, 10040)
      );

      PdfGrid grid2 = PdfGrid();
      grid2.style = PdfGridStyle(
          cellPadding: PdfPaddings(left: 7, right: 7, top: 1, bottom: 0),
          font: PdfStandardFont(PdfFontFamily.timesRoman, 10));
      grid2.columns.add(count: 2);

      PdfGrid grid3 = PdfGrid();
      grid3.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 2, right: 5,),);

      grid3.columns.add(count: 5);
      grid3.columns[0].width = 234;
      grid3.columns[1].width = 80;
      grid3.columns[2].width = 50;
      // /grid.columns[1].width = 50;
      grid3.headers.add(1);

    }
    List<int> bytes = document.save();
    //Dispose the document
    document.dispose();

    //await saveAndLaunchFile(bytes, 'Inv.pdf');


    final path= Directory("storage/emulated/0/Document/ColorsoulPdf");
    // print(path);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      await Permission.mediaLibrary.request();
    }
    if ((await path.exists())) {
      null;
    } else {
      path.create();
    }

    String route = "storage/emulated/0/Document/ColorsoulPdf";
    File file = File('$route/Invoice_id_${widget.orderid}_$currentDate.pdf');
    await file.writeAsBytes(bytes, flush: true);

    //sendImage(file.path);

    OpenFile.open('$route/Invoice_id_${widget.orderid}_$currentDate.pdf').then((value) {

      setState(() {
        isLoading = false;
      });

      return null;
    });

  }

  String dateFormate = DateFormat("yyMMddhhmmss").format(DateTime.now());
  String currentDate = DateFormat("dd_MMM_yyyy_hhmmss").format(DateTime.now());

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