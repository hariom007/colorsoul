import 'package:colorsoul/Ui/Dashboard/Home/ToDoTask/to_do_task.dart';
import 'package:colorsoul/Ui/Dashboard/Home/TotalNotes/totalnotes.dart';
import 'package:colorsoul/Ui/Dashboard/Home/alert.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

import 'Total_task/total_tasks.dart';

class Home extends StatefulWidget {
 @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  TabController _tabController;
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                SizedBox(height: height*0.05),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/home/person.png")
                  ),
                  title: Text(
                    "Hi Amit",
                    style: textStyle.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle:  Row(
                    children: [
                      //Icon(FontAwesomeIcons.calendar,color:Colors.white,size: 12),
                      Image.asset("assets/images/home/date.png",width: 12),
                      SizedBox(width: 8),
                      Text(
                        "Dec 18, 2021",
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
                                Text(
                                  "110",
                                  style: textStyle.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: height*0.015),
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
                                Text(
                                  "35",
                                  style: textStyle.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                SizedBox(height: height*0.015),
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
                                Text(
                                  "10",
                                  style: textStyle.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                SizedBox(height: height*0.015),
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
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.only(top: 10,bottom: 40),
                          itemCount: 6,
                          shrinkWrap: true,
                          itemBuilder:(context, index){
                            return buildCard(height,index);
                          },
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(top: 10,bottom: 40),
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder:(context, index){
                            return buildCard(height,index);
                          },
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(top: 10,bottom: 40),
                          itemCount: 2,
                          shrinkWrap: true,
                          itemBuilder:(context, index){
                            return buildCard(height,index);
                          },
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

  Widget buildCard(double height,int index) {
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
          ),
        )
      ),
    );
  }
}