import 'package:colorsoul/Ui/Dashboard/NewOrder/location_page.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/normal_order.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/barcode_confirm_order.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class BarcodeOrder extends StatefulWidget {

  String distributor_name,distributor_address,latitude,longitude,home_address,distributor_gst,landmark,city,state,
      person_name,person_mobile,person_tel,opentime,closetime,business_type,type,id;
  List productList;
  List<TextEditingController> selectedQuantity = [];
  List<TextEditingController> orderQuantity = [];
  List<TextEditingController> selectedAmount = [];

  BarcodeOrder({Key key, this.distributor_name,this.distributor_address,this.latitude,this.longitude,this.distributor_gst,this.landmark,
    this.person_name,this.person_mobile,this.person_tel,this.opentime,this.closetime,this.business_type,this.type,this.id,this.home_address,this.city,this.state,
    this.productList,this.selectedQuantity,this.orderQuantity,this.selectedAmount
  }) : super(key: key);

  @override
  State<BarcodeOrder> createState() => _BarcodeOrderState();
}

class _BarcodeOrderState extends State<BarcodeOrder> {

  String orderAddress;
  double totalAmount = 0.0;
  int totalQuentity = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    orderAddress = widget.distributor_address;
    for(int i=0;i<widget.selectedAmount.length;i++){

      double singleAmount = double.parse("${widget.selectedAmount[i].text}") * double.parse("${widget.orderQuantity[i].text}");
      totalAmount = totalAmount + singleAmount;

      totalQuentity = totalQuentity + int.parse("${widget.orderQuantity[i].text}");

    }

  }

  TextEditingController _textEditingController1 = new TextEditingController();
  DateTime _selectedDate;


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 70,
                  color: AppColors.white,
                  child: Padding(
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

                              if(_textEditingController1.text == null || _textEditingController1.text == ""){


                                Fluttertoast.showToast(
                                    msg: "Please Select Order Date.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                              }
                              else{

                                  double FinalAmount = 0.0;
                                  var FinalProduct = [];

                                  for(int i=0;i<widget.productList.length;i++){

                                    var singleProduct = {
                                      "pid":"${widget.productList[i]['pid']}",
                                      "color_id":"${widget.productList[i]['color_id']}",
                                      "color_code":"${widget.productList[i]['color_code']}",
                                      "sku":"${widget.productList[i]['sku']}",
                                      "amount":"${widget.selectedAmount[i].text}",
                                      "qty":"${widget.orderQuantity[i].text}",
                                      "stock":"${widget.selectedQuantity[i].text}",
                                    };

                                    FinalProduct.add(singleProduct);

                                    double singleAmount = double.parse(widget.selectedAmount[i].text) * double.parse(widget.orderQuantity[i].text);
                                    FinalAmount = FinalAmount + singleAmount;

                                  }

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BarcodeConfirmOrder(
                                    retailerId: widget.id,
                                    address: orderAddress,
                                    orderDate: _textEditingController1.text,
                                    totalAmount: "${FinalAmount}",
                                    productList: FinalProduct,
                                  )));
                                }


                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: Colors.transparent,
                                shape: StadiumBorder()
                            ),
                            child: Text('Next',
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
        body: Container(
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
                        SizedBox(width: 10),
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
                      child:
                      Padding(
                          padding: EdgeInsets.only(right: 10,left: 10),
                          child: NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (OverscrollIndicatorNotification overscroll) {
                              overscroll.disallowGlow();
                              return;
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        SizedBox(height: height*0.01),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height*0.02),
                                            RichText(
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "Retailer Name : ",
                                                          style: textStyle.copyWith(
                                                              fontSize: 16,
                                                              color: AppColors.black,
                                                              fontWeight: FontWeight.bold
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: "${widget.distributor_name}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 16,
                                                            color: AppColors.black,
                                                          )
                                                      )
                                                    ]
                                                )
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Image.asset("assets/images/tasks/location1.png",width: 20,height: 20),
                                                SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    "${widget.distributor_address}",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textStyle.copyWith(
                                                        color: AppColors.black,
                                                        height: 1.4
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 14),
                                            Row(
                                              children: [
                                                Image.asset("assets/images/neworder/call.png",width: 20,height: 20),
                                                SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    "+91 ${widget.person_mobile}",
                                                    maxLines: 2,
                                                    style: textStyle.copyWith(
                                                        fontSize: 15,
                                                        color: AppColors.black,
                                                        height: 1.2
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),

                                        SizedBox(height: height*0.02),

                                        Divider(
                                            color: Color.fromRGBO(185, 185, 185, 0.75),
                                            thickness: 2
                                        ),
                                        SizedBox(height: height*0.02),
                                        Text(
                                          "To Change Location Click Here",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),

                                        TextFormField(
                                            style: textStyle.copyWith(
                                                color: AppColors.black
                                            ),
                                            onTap: () async {

                                              final value = await Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage()));
                                              if(value != null){
                                                print(value);

                                                var fullAddress = value.split("/");
                                                orderAddress = fullAddress[0];

                                              }

                                            },
                                            cursorColor: AppColors.black,
                                            cursorHeight: 22,
                                            readOnly: true,
                                            decoration: fieldStyle1.copyWith(
                                                hintText: "Search Location",
                                                hintStyle: textStyle.copyWith(
                                                    color: AppColors.black
                                                ),
                                                prefixIcon: new IconButton(
                                                  icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                                  onPressed: null,
                                                ),
                                                isDense: true
                                            )
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/images/locater/location4.png",width: 20,height: 20),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: Text(
                                                  "$orderAddress",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textStyle.copyWith(
                                                      color: AppColors.black,
                                                      fontWeight: FontWeight.bold,
                                                      height: 1.4
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ),

                                        SizedBox(height: height*0.03),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tentative Order Date",
                                              style: textStyle.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(
                                              width: width,
                                              child: TextField(
                                                decoration: fieldStyle1.copyWith(
                                                  prefixIcon: new IconButton(
                                                    icon: new Image.asset('assets/images/tasks/donedate.png',width: 20,height: 20),
                                                    onPressed: null,
                                                  ),
                                                  hintText: "Select Date",
                                                  hintStyle: textStyle.copyWith(
                                                      color: Colors.black
                                                  ),
                                                  isDense: true,
                                                  errorStyle: TextStyle(height: 0),
                                                ),
                                                style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black
                                                ),
                                                focusNode: AlwaysDisabledFocusNode(),
                                                controller: _textEditingController1,
                                                onTap: () {
                                                  _selecttDate(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: height*0.02),
                                        Text(
                                          "Products",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [

                                        SizedBox(width: 30),

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
                                  ),

                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),

                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(top: 10,left: 6,right: 10),
                                    itemCount: widget.productList.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var productData = widget.productList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [

                                            InkWell(
                                              onTap: (){
                                                setState(() {
                                                  widget.productList.removeAt(index);
                                                  widget.selectedAmount.removeAt(index);
                                                  widget.orderQuantity.removeAt(index);
                                                  widget.selectedQuantity.removeAt(index);

                                                  totalAmount = 0;
                                                  totalQuentity = 0;
                                                  for(int i=0;i<widget.selectedAmount.length;i++){

                                                    double singleAmount = double.parse("${widget.selectedAmount[i].text}") * double.parse("${widget.orderQuantity[i].text}");
                                                    totalAmount = totalAmount + singleAmount;

                                                    totalQuentity = totalQuentity + int.parse("${widget.orderQuantity[i].text}");

                                                  }


                                                });
                                              },
                                              child: Icon(Icons.close,size: 20),
                                            ),

                                            SizedBox(width: 20),

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
                                                "${widget.orderQuantity[index].text}",
                                                textAlign: TextAlign.center,
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: Text(
                                                "${widget.selectedAmount[index].text}",
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

                                  SizedBox(height: 10),

                                  Row(
                                    children: [

                                      Expanded(
                                        child: Container(
                                          width: 130,
                                          child: Text(
                                            "Quantity : $totalQuentity",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "Amount : ${totalAmount.toStringAsFixed(2)}",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),


                                  SizedBox(height: height*0.02),
                                ],
                              ),
                            ),
                          )
                      ),
                    )
                )
              ],
            )
        ),
    );
  }

  _selecttDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.grey,
                onPrimary: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: AppColors.white,
            ),
            child: child,
          );
        }
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      setState(() {
        _textEditingController1 = TextEditingController(text: DateFormat('yyyy-MM-dd').format(_selectedDate));
      });
    }
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}