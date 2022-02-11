import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Provider/note_provider.dart';
import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Provider/task_provider.dart';
import 'package:colorsoul/Provider/todo_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Home/ToDoTask/to_do_task.dart';
import 'package:colorsoul/Ui/Dashboard/Home/TotalNotes/totalnotes.dart';
import 'package:colorsoul/Ui/Dashboard/Home/alert.dart';
import 'package:colorsoul/Ui/Dashboard/OrderList/order_details.dart';
import 'package:colorsoul/Ui/profile_page.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Total_task/total_tasks.dart';

class Home extends StatefulWidget {
 @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  TabController _tabController;
  OrderProvider _orderProvider;

  int isSelected = 0;
  String userImage,userName;

  String currentDate = DateFormat('MMM dd,yyyy').format(DateTime.now());


  TaskProvider _taskProvider;
  NoteProvider _noteProvider;
  TodoProvider _todoProvider;

  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _noteProvider = Provider.of<NoteProvider>(context, listen: false);
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);

    setState(() {
      _orderProvider.orderList.clear();
      _orderProvider.incompleteOrderList.clear();
      _orderProvider.completeOrderList.clear();
    });

    getUserDetails();
    getOrders();
    getTask();
    getNote();
    getTodo();

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

  bool isLoaded = true;
  getUserDetails() async {

    setState(() {
      isLoaded = false;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userImage = sharedPreferences.getString("image");
      userName = sharedPreferences.getString("name");
      isLoaded = true;
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

    setState(() {
      isScrollingDown = false;
    });

  }

  getTask() async {

    setState(() {
      _taskProvider.taskList.clear();
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      //"from_date":"",
      //"to_date":"",
      "status":""
    };
    await _taskProvider.getAllTask(data,'/getTask/$page');

  }

  getNote() async {

    setState(() {
      _noteProvider.noteList.clear();
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      //"from_date":"",
      //"to_date":"",
      //"status":""
    };
    await _noteProvider.getAllNote(data,'/getNote/$page');

  }

  getTodo() async {

    setState(() {
      _todoProvider.allTodoList.clear();
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      //"from_date":"",
      //"to_date":"",
      "status":""
    };
    await _todoProvider.getAllTodo(data,'/getTodo/$page');

  }

  changeStatus(String orderId) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      "id":"$orderId"
    };
    await _orderProvider.confirmOrder(data,'/changeOrderStatus');

    if(_orderProvider.isConfirm == true){

      setState(() {
        _orderProvider.orderList.clear();
        _orderProvider.incompleteOrderList.clear();
        _orderProvider.completeOrderList.clear();
      });

      getOrders();
    }

  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    _orderProvider = Provider.of<OrderProvider>(context, listen: true);
    _noteProvider = Provider.of<NoteProvider>(context, listen: true);
    _taskProvider = Provider.of<TaskProvider>(context, listen: true);
    _todoProvider = Provider.of<TodoProvider>(context, listen: true);

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
            child:
              isLoaded == false
                  ?
              Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.white,
                    size: 25.0,
                  )
              )
                  :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.05),
                  InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));

                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: CachedNetworkImage(
                          imageUrl: "$userImage",
                          placeholder: (context, url) => Center(
                              child: SpinKitThreeBounce(
                                color: AppColors.white,
                                size: 25.0,
                              )
                          ),
                          errorWidget: (context, url, error) => Image.asset("assets/images/profile.png",height: 50,width: 50),
                          width: 50,
                          height: 50,
                        ),
                      ),
                      title: Text(
                        "Hii ${userName}",
                        style: textStyle.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:  Row(
                        children: [
                          //Icon(FontAwesomeIcons.calendar,color:Colors.white,size: 12),
                          Image.asset("assets/images/home/date.png",width: 12),
                          SizedBox(width: 8),
                          Text(
                            "$currentDate",
                            style: textStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            )
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Alert()));
                        },
                        child: Image.asset("assets/images/bell.png",width: 24,height: 24)
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.02),
                  Padding(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Text(
                      "Set Your Work Today!",
                      style: textStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.03),
                  Padding(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TotalTasks()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                  borderRadius: round1,
                                  boxShadow: [new BoxShadow(
                                    color: Color.fromRGBO(255, 255, 255, 0.15),
                                    offset: Offset(0, 15),
                                    blurRadius: 20,
                                  )]
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: height*0.03),
                                  Image.asset("assets/images/home/TT.png",width: 50),
                                  SizedBox(height: height*0.015),
                                  Text(
                                    "Total Task",
                                    style: textStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    )
                                  ),

                                  SizedBox(height: 4),

                                  _taskProvider.isLoaded == false
                                      ?
                                  SizedBox(
                                    height: 15,
                                    child: SpinKitThreeBounce(
                                      color: AppColors.black,
                                      size: 15.0,
                                    ),
                                  )
                                      :
                                  Text(
                                    "${_taskProvider.taskList.length}",
                                    style: textStyle.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: height*0.013),
                                ],
                              )
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoTasks()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                  borderRadius: round1,
                                  boxShadow: [new BoxShadow(
                                    color: Color.fromRGBO(255, 255, 255, 0.15),
                                    offset: Offset(0, 15),
                                    blurRadius: 20,
                                  )]
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: height*0.03,),
                                  Image.asset("assets/images/home/TDT.png",width: 50),
                                  SizedBox(height: height*0.015),
                                  Text(
                                      "To Do Task",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      )
                                  ),

                                  SizedBox(height: 4),

                                  _todoProvider.isLoaded == false
                                      ?
                                  SizedBox(
                                    height: 15,
                                    child: SpinKitThreeBounce(
                                      color: AppColors.black,
                                      size: 15.0,
                                    ),
                                  )
                                      :
                                  Text(
                                    "${_todoProvider.allTodoList.length}",
                                    style: textStyle.copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: height*0.013),
                                ],
                              )
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TotalNotes()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                  borderRadius: round1,
                                  boxShadow: [new BoxShadow(
                                    color: Color.fromRGBO(255, 255, 255, 0.15),
                                    offset: Offset(0, 15),
                                    blurRadius: 20,
                                  )]
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: height*0.03),
                                  Image.asset("assets/images/home/TN.png",width: 46),
                                  SizedBox(height: height*0.015),
                                  Text(
                                      "Notes",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      )
                                  ),

                                  SizedBox(height: 4),

                                  _noteProvider.isLoaded == false
                                      ?
                                  SizedBox(
                                    height: 15,
                                    child: SpinKitThreeBounce(
                                      color: AppColors.black,
                                      size: 15.0,
                                    ),
                                  )
                                      :
                                  Text(
                                      "${_noteProvider.noteList.length}",
                                    style: textStyle.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  SizedBox(height: height*0.013),
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.02),
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
                                    child:
                                    _orderProvider.isLoaded == false
                                        ?
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: SpinKitThreeBounce(
                                        color: AppColors.white,
                                        size: 25.0,
                                      ),
                                    )
                                        :
                                    Text('(${_orderProvider.orderList.length})',
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
                                    child:
                                    _orderProvider.isLoaded == false
                                        ?
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: SpinKitThreeBounce(
                                        color: AppColors.black,
                                        size: 25.0,
                                      ),
                                    )
                                        :
                                    Text('(${_orderProvider.completeOrderList.length})',
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
                                    child:
                                    _orderProvider.isLoaded == false
                                        ?
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: SpinKitThreeBounce(
                                        color: AppColors.black,
                                        size: 25.0,
                                      ),
                                    )
                                        :
                                    Text('(${_orderProvider.incompleteOrderList.length})',
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
                      TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [

                          SingleChildScrollView(
                            controller: _scrollViewController,
                            child: Column(
                              children: [
                                ListView.builder(
                                  padding: EdgeInsets.only(top: 10,bottom: 30),
                                  itemCount: _orderProvider.orderList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:(context, index){
                                    var allOrder = _orderProvider.orderList[index];
                                    return Padding(
                                        padding: EdgeInsets.only(bottom: 10),
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
                                                    '${allOrder.retailerBusinessName}',
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
                                                      '${allOrder.address}',
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
                                                      "${DateFormat('dd, MMM yyyy').format(allOrder.orderDate)}",
                                                      style: textStyle.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails(
                                                    retailerBusinessName: allOrder.retailerBusinessName,
                                                    retailerAddress: allOrder.retailerAddress,
                                                    retailerMobile: allOrder.retailerMobile,
                                                    orderDate: "${DateFormat('dd, MMM yyyy').format(allOrder.orderDate)}",
                                                    orderAddress: allOrder.address,
                                                    products: allOrder.items,
                                                    totalAmount: allOrder.total,
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

                          SingleChildScrollView(
                            controller: _scrollViewController,
                            child: Column(
                              children: [

                                ListView.builder(
                                  padding: EdgeInsets.only(top: 10,bottom: 30),
                                  itemCount: _orderProvider.completeOrderList.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:(context, index){
                                    var completedOrder = _orderProvider.completeOrderList[index];
                                    return Padding(
                                        padding: EdgeInsets.only(bottom: 10),
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
                                                    '${completedOrder.retailerBusinessName}',
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
                                                      '${completedOrder.address}',
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
                                                      "${DateFormat('dd, MMM yyyy').format(completedOrder.orderDate)}",
                                                      style: textStyle.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {

                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails(
                                                    retailerBusinessName: completedOrder.retailerBusinessName,
                                                    retailerAddress: completedOrder.retailerAddress,
                                                    retailerMobile: completedOrder.retailerMobile,
                                                    orderDate: "${DateFormat('dd, MMM yyyy').format(completedOrder.orderDate)}",
                                                    orderAddress: completedOrder.address,
                                                    products: completedOrder.items,
                                                    totalAmount: completedOrder.total,
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

                          SingleChildScrollView(
                            controller: _scrollViewController,
                            child: Column(
                              children: [

                                ListView.builder(
                                  padding: EdgeInsets.only(top: 10,bottom: 30),
                                  itemCount: _orderProvider.incompleteOrderList.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:(context, index){
                                    var incompleteOrder = _orderProvider.incompleteOrderList[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        /*secondaryActions: [
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
                                      ],*/
                                        secondaryActions: [
                                          InkWell(
                                            onTap: (){

                                              showDialog<bool>(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      insetPadding: EdgeInsets.all(0),
                                                      contentPadding: EdgeInsets.all(0),
                                                      backgroundColor: Colors.transparent,
                                                      content: Container(
                                                        width: MediaQuery.of(context).size.width/1.2,
                                                        decoration: BoxDecoration(
                                                            color: AppColors.white,
                                                            borderRadius: round1.copyWith()
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                'Are you sure you want to Complete Order?',
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
                                                                      'Yes, Confirm',
                                                                      style: textStyle.copyWith(
                                                                          color: AppColors.black
                                                                      ),
                                                                    ),
                                                                    onPressed: () {

                                                                      Navigator.of(context).pop();
                                                                      changeStatus(incompleteOrder.id);

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

                                            },
                                            child: Container(
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
                                                    '${incompleteOrder.retailerBusinessName}',
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
                                                      '${incompleteOrder.address}',
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
                                                      "${DateFormat('dd, MMM yyyy').format(incompleteOrder.orderDate)}",
                                                      style: textStyle.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {

                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails(
                                                    retailerBusinessName: incompleteOrder.retailerBusinessName,
                                                    retailerAddress: incompleteOrder.retailerAddress,
                                                    retailerMobile: incompleteOrder.retailerMobile,
                                                    orderDate: "${DateFormat('dd, MMM yyyy').format(incompleteOrder.orderDate)}",
                                                    orderAddress: incompleteOrder.address,
                                                    products: incompleteOrder.items,
                                                    totalAmount: incompleteOrder.total,
                                                  )));

                                                },
                                              ),
                                            )
                                        ),
                                      ),
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

}