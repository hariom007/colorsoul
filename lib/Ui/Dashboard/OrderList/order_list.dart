import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Products/productsfilter.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_details.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with TickerProviderStateMixin{
  TabController _tabController;
  int isSelected = 0;

  OrderProvider _orderProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

    getOrders();

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  int page = 1;
  getOrders() async {

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
    await _orderProvider.getIncompleteOrders(data,'/getOrder/$page');


    var data2 = {
      "uid":"$userId",
      "from_date":"",
      "to_date":"",
      "status":"Delivered"
    };
    await _orderProvider.getCompleteOrders(data,'/getOrder/$page');

  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _orderProvider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.black,
      body:  NotificationListener<OverscrollIndicatorNotification>(
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
                SizedBox(height: height*0.06),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Order List",
                        style: textStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsFilter()));
                        },
                        child: Image.asset("assets/images/locater/filter.png",height: 20,width: 20)
                      )
                    ],
                  ),
                ),
                SizedBox(height: height*0.03),
                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: TabBar(
                      onTap: (index) {
                        setState(() {
                          isSelected = index;
                        });
                      },
                      labelPadding: EdgeInsets.only(left: 4,right: 4),
                      labelStyle: textStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                      indicatorPadding: EdgeInsets.only(left: 4,right: 4,bottom: 2),
                      indicatorColor: Colors.transparent,
                      // indicator: decoration.copyWith(
                      //   gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                      //   boxShadow: [new BoxShadow(
                      //     color: Color.fromRGBO(255,255,255, 0.2),
                      //     offset: Offset(0, 5),
                      //     blurRadius: 4,
                      //   )]
                      // ),
                      controller: _tabController,
                      tabs: [
                        Tab(
                            height: 60,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 9),
                                  width: width,
                                  height: 35,
                                  decoration: decoration.copyWith(
                                      gradient: isSelected==0
                                          ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black])
                                          : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                      boxShadow: isSelected==0
                                          ? [new BoxShadow(
                                        color: Color.fromRGBO(255,255,255, 0.2),
                                        offset: Offset(0, 5),
                                        blurRadius: 4,
                                      )]
                                          : [new BoxShadow(
                                        color: Color.fromRGBO(0,0,0, 0.3),
                                        offset: Offset(0, 5),
                                        blurRadius: 6,
                                      )]
                                  ),
                                  child: Text('(06)',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected==0 ? AppColors.white : AppColors.black
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "All Order",
                                  style: textStyle.copyWith(
                                      fontSize: 12
                                  ),
                                )
                              ],
                            )
                        ),
                        Tab(
                            height: 60,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 9),
                                  width: width,
                                  height: 35,
                                  decoration: decoration.copyWith(
                                      gradient: isSelected==1
                                          ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black])
                                          : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                      boxShadow: isSelected==1
                                          ? [new BoxShadow(
                                        color: Color.fromRGBO(255,255,255, 0.2),
                                        offset: Offset(0, 5),
                                        blurRadius: 4,
                                      )]
                                          : [new BoxShadow(
                                        color: Color.fromRGBO(0,0,0, 0.3),
                                        offset: Offset(0, 5),
                                        blurRadius: 6,
                                      )]
                                  ),
                                  child: Text('(04)',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected==1 ? AppColors.white : AppColors.black
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Complete Order",
                                  style: textStyle.copyWith(
                                      fontSize: 12
                                  ),
                                )
                              ],
                            )
                        ),
                        Tab(
                            height: 60,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 9),
                                  width: width,
                                  height: 35,
                                  decoration: decoration.copyWith(
                                      gradient: isSelected==2
                                          ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black])
                                          : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                      boxShadow: isSelected==2
                                          ? [new BoxShadow(
                                        color: Color.fromRGBO(255,255,255, 0.2),
                                        offset: Offset(0, 5),
                                        blurRadius: 4,
                                      )]
                                          : [new BoxShadow(
                                        color: Color.fromRGBO(0,0,0, 0.3),
                                        offset: Offset(0, 5),
                                        blurRadius: 6,
                                      )]
                                  ),
                                  child: Text('(02)',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected==2 ? AppColors.white : AppColors.black
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Incomplete Order",
                                  style: textStyle.copyWith(
                                      fontSize: 12
                                  ),
                                )
                              ],
                            )
                        )
                      ]
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)
                        )
                    ),
                    padding: EdgeInsets.only(left: 15,right: 15,bottom: 30),
                    width: width,
                    child:
                    _orderProvider.isLoaded == false
                        ?
                    Center(
                        child: SpinKitThreeBounce(
                          color: AppColors.black,
                          size: 25.0,
                        )
                    )
                        :
                    TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "19, December 2021",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                itemCount: 3,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:(context, index){
                                  return buildCard(height,index);
                                },
                              ),
                              Text(
                                "20, December 2021",
                                style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:(context, index){
                                  return buildCard(height,index);
                                },
                              ),
                              Text(
                                "21, December 2021",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.only(top: 10,bottom: 40),
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:(context, index){
                                  return buildCard(height,index);
                                },
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "19, December 2021",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:(context, index){
                                  return buildCard(height,index);
                                },
                              ),
                              Text(
                                "20, December 2021",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:(context, index){
                                  return buildCard(height,index);
                                },
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "21, December 2021",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:(context, index){
                                  return buildCard(height,index);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  Widget buildCard(double height,int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actions: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.black,
            ),
            child: Center(
              child: Text(
                "Complete\nOrder",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(),
              ),
            ),
          )
        ],
        secondaryActions: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.black,
            ),
            child: Center(
              child: Text(
                "Incomplete\nOrder",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(),
              ),
            ),
          )
        ],
        child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: round1.copyWith()
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 5,bottom: 6),
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    'Be Shoppers Stop',
                    style: textStyle.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                subtitle: Column(
                  children: [
                    SizedBox(height: height*0.01,),
                    Text(
                      'Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                          height: 1.4
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '18, Dec 2021',
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '9:30 AM',
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()));
                },
              ),
            )
        ),
      ),
    );
  }
}