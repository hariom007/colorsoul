import 'dart:async';
import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrder extends StatefulWidget {

  List productList = [];
  String orderid,retailerId,state,address,orderDate,totalAmount,totalIgst,totalCgst,totalSgst;

  ConfirmOrder({Key key,this.orderid,this.productList,this.retailerId,this.address,this.state,
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

    _orderProvider.insertOrder(data, "/add_salesorder");

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

                              selectPaymentMethod();
                              //createOrder();

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
                                          "₹ ${double.parse("${widget.totalAmount}")+double.parse("${widget.totalIgst}")}"
                                              :
                                          "₹ ${double.parse("${widget.totalAmount}")+double.parse("${widget.totalIgst}")+double.parse("${roundingController.text}")}",
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