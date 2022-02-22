import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Ui/Dashboard/OrderList/sales_order_details.dart';
import 'package:flutter/material.dart';
import 'package:colorsoul/Ui/Dashboard/Products/productsfilter.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_details.dart';

class SalesOrderList extends StatefulWidget {
  const SalesOrderList({Key key}) : super(key: key);

  @override
  _SalesOrderListState createState() => _SalesOrderListState();
}

class _SalesOrderListState extends State<SalesOrderList> {

  OrderProvider _orderProvider;

  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

    setState(() {
      _orderProvider.salesOrderList.clear();
    });
    getOrders();


    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {

          setState(() {
            isScrollingDown = true;
          });
          setState(() {
            page = page + 1;
            getOrders();
          });
        }
      }
    });

  }

  int page = 1;
  getOrders() async {

    setState(() {
      isScrollingDown = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
    };
    await _orderProvider.getSalesOrders(data,'/get_salesorder/$page');

    setState(() {
      isScrollingDown = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    _orderProvider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.black,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Flesh2.png"),
                  fit: BoxFit.fill,
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.06),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Sales Order List",
                        style: textStyle.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => ProductsFilter()));
                          },
                          child: Image.asset(
                              "assets/images/locater/filter.png", height: 20,
                              width: 20)
                      )
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      ),
                      color: AppColors.white,
                    ),
                    child:

                    Column(
                      children: [

                        ListView.builder(
                          controller: _scrollViewController,
                          padding: EdgeInsets.only(top: 10, bottom: 30,left: 10,right: 10),
                          itemCount: _orderProvider.salesOrderList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var allOrder = _orderProvider.salesOrderList[index];
                            return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: round1.copyWith()
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, bottom: 6),
                                      child: ListTile(
                                        title: Padding(
                                          padding: EdgeInsets.only(
                                              top: 6),
                                          child: Text(
                                            '${allOrder
                                                .customerName}',
                                            style: textStyle.copyWith(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight
                                                    .bold
                                            ),
                                          ),
                                        ),
                                        subtitle: Column(
                                          children: [
                                            SizedBox(
                                              height: height * 0.01,),
                                            Text(
                                              '${allOrder.customerAddress}',
                                              maxLines: 2,
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              style: textStyle.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  height: 1.4
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .end,
                                          children: [
                                            Text(
                                              "${DateFormat('dd, MMM yyyy').format(
                                                  allOrder.createAt)}",
                                              style: textStyle.copyWith(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight
                                                    .bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {

                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalesOrderDetails(
                                                        retailerBusinessName: allOrder
                                                            .customerName,
                                                        retailerAddress: allOrder
                                                            .customerAddress,
                                                        retailerMobile: allOrder
                                                            .customerMobile,
                                                        orderDate: "${DateFormat(
                                                            'dd, MMM yyyy')
                                                            .format(
                                                            allOrder
                                                                .createAt)}",
                                                        orderAddress: allOrder.customerAddress,
                                                        products: allOrder.items,
                                                        totalAmount: allOrder.totalAmount,
                                                      )));

                                        },

                                      ),
                                    )
                                )
                            );
                          },
                        ),

                        _orderProvider.isLoaded == false
                            ?
                        Center(
                            child: SpinKitThreeBounce(
                              color: AppColors.black,
                              size: 25.0,
                            )
                        )
                            :
                        SizedBox()

                      ],
                    ),
                  ),
                ),



              ],
            )
        ),
      ),
    );
  }
}

