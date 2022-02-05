import 'package:colorsoul/Model/Order_Model.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {

  String retailerBusinessName,retailerAddress,orderAddress,retailerMobile,orderDate,totalAmount;
  List<Item> products;

  OrderDetails({
    Key key,
    this.retailerBusinessName,
    this.retailerAddress,
    this.orderDate,
    this.retailerMobile,
    this.totalAmount,
    this.orderAddress,
    this.products
  }) : super(key: key);


  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.black,
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
                        SizedBox(width: 8),
                        Text(
                          "${widget.retailerBusinessName}",
                          style: textStyle.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Expanded(child: Container()),
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
                              "${widget.retailerAddress}",
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
                              "+91 ${widget.retailerMobile}",
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
                                          "Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)",
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
                                    "${widget.orderDate}",
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
                                    itemCount: widget.products.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var productData = widget.products[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${productData.sku}",
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: Text(
                                                "${productData.qty}",
                                                textAlign: TextAlign.center,
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: Text(
                                                "${productData.amount}",
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
                                              "₹100",
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
                                            "₹ ${widget.totalAmount}",
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