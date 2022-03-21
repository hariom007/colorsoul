import 'package:colorsoul/Model/Order_Model.dart';
import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Ui/Dashboard/OrderList/edit_order.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {

  String orderId;
  OrderDetails({
    Key key,
    this.orderId,
  }) : super(key: key);


  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  OrderProvider _orderProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

    getOrders();

  }

  String
  retailer_id, retailerBusinessName, retailerAddress, orderAddress,
      retailerMobile, orderDate, totalAmount;
  var products;


  bool isLoading = false;
  getOrders() async {

    setState(() {
      isLoading= true;
    });

    var data = {
      "id":"${widget.orderId}"
    };

    await _orderProvider.getOrderDetails(data,'/get_order_detail');

    print(_orderProvider.orderDetails);


    if(_orderProvider.isSuccess == true){

      retailerBusinessName = _orderProvider.orderDetails['name'] == "" ?  _orderProvider.orderDetails['business_name'] : _orderProvider.orderDetails['name'];
      retailer_id = _orderProvider.orderDetails['retailer_id'];
      retailerAddress = _orderProvider.orderDetails['address'];
      orderAddress = _orderProvider.orderDetails['address'];
      retailerMobile = _orderProvider.orderDetails['mobile'];
      orderDate = _orderProvider.orderDetails['order_date'];
      totalAmount = _orderProvider.orderDetails['total'];
      products = _orderProvider.orderDetails['items'];

      print(products);

    }

    setState(() {
      isLoading= false;
    });

  }


  @override
  Widget build(BuildContext context) {

    _orderProvider = Provider.of<OrderProvider>(context, listen: true);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
        backgroundColor: AppColors.black,
        body:
        isLoading == true
            ?
        SpinKitThreeBounce(
          color: AppColors.white,
          size: 25.0,
        )
            :
        Container(
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
                              child: Image.asset("assets/images/tasks/back.png",height: 18)
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${retailerBusinessName}",
                            style: textStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        InkWell(
                            onTap: () async {

                              final value = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditOrder(
                                orderId: widget.orderId,
                                retailerId: retailer_id,
                                retailerAddress: retailerAddress,
                                retailerName: retailerBusinessName,
                                orderDate: orderDate,
                                productList: products,
                              )));

                              if(value != null){

                                getOrders();

                              }

                            },
                            child: Icon(Icons.edit,color: AppColors.white,size: 23)
                        ),

                        SizedBox(width: 8),

                        /*
                        InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 220,
                                  padding: EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset("assets/images/notes/edit.png",width: 18,height: 18),
                                          SizedBox(width: 10),
                                          Text(
                                            "Edit",
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset("assets/images/notes/copy.png",width: 18,height: 18),
                                          SizedBox(width: 10),
                                          Text(
                                            "Copy",
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset("assets/images/notes/share.png",width: 19,height: 19),
                                          SizedBox(width: 10),
                                          Text(
                                            "Send",
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset("assets/images/notes/bin1.png",width: 20,height: 20),
                                          SizedBox(width: 10),
                                          Text(
                                            "Delete",
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Image.asset("assets/images/details/menu1.png",width: 20,height: 20)
                        ),
                        */

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right: 30,left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height*0.02),
                      Row(
                        children: [
                          Image.asset("assets/images/tasks/location1.png",width: 20,height: 20,color: AppColors.white,),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "${retailerAddress}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle.copyWith(
                                height: 1.4
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Image.asset("assets/images/neworder/call.png",width: 20,height: 20,color: AppColors.white,),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "+91 ${retailerMobile}",
                              maxLines: 2,
                              style: textStyle.copyWith(
                                fontSize: 15,
                                height: 1.2
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: height*0.02),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height*0.03),
                                  Text(
                                    "Location",
                                    style: textStyle.copyWith(
                                      fontSize: 16,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Image.asset("assets/images/tasks/location1.png",width: 20,height: 20),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "$orderAddress",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              height: 1.4
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20),
                                  Text(
                                    "Tentative Order Date",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${orderDate}",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "Products",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Item Name",
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
                                    itemCount: products.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var productData = products[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${productData['short']}",
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
                                              "₹ ${totalAmount}",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        /*Row(
                                          children: [
                                            Text(
                                              "Discount",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                                "- ₹200.00",
                                              style: textStyle.copyWith(
                                                  color: Color.fromRGBO(0, 169, 145, 1),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 15),*/
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
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Text(
                                              "Taxes (estimated)",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                              "₹0.0",
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
                                    child: Container(
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total Amount",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "₹ ${totalAmount}",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 34,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
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
        )
    );
  }
}