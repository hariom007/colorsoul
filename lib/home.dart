import 'package:colorsoul/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'appColors.dart';

class Home extends StatefulWidget {
 @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = new TabController(length: 3, vsync: this);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body:  Container(
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
              trailing: Image.asset("assets/images/bell.png",width: 24,height: 24),
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
                          Image.asset("assets/images/home/TT.png",width: 50),
                          SizedBox(height: height*0.03),
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
                              fontSize: 13,
                              color: Colors.black
                            ),
                          ),
                          SizedBox(height: height*0.03,),
                        ],
                      )
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
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
                          SizedBox(height: height*0.03),
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
                              fontSize: 13,
                              color: Colors.black
                            )
                          ),
                          SizedBox(height: height*0.03,),
                        ],
                      )
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
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
                          Image.asset("assets/images/home/TN.png",width: 46),
                          SizedBox(height: height*0.03),
                          Text(
                              "Total Notes",
                              style: textStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              )
                          ),
                          Text(
                            "10",
                            style: textStyle.copyWith(
                              fontSize: 13,
                              color: Colors.black
                            )
                          ),
                          SizedBox(height: height*0.03,),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.01),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: TabBar(
                  labelPadding: EdgeInsets.only(left: 4,right: 4),
                  labelStyle: textStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  indicatorPadding: EdgeInsets.only(left: 4,right: 4,bottom: 2),
                  indicatorColor: AppColors.grey2,
                  indicator: decoration.copyWith(
                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                    boxShadow: [new BoxShadow(
                      color: Color.fromRGBO(255,255,255, 0.2),
                      offset: Offset(0, 5),
                      blurRadius: 4,
                    )]
                  ),
                  controller: _tabcontroller,
                  tabs: [
                    Tab(
                      height: 30,
                      child: Text('(28)',
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                    Tab(
                      height: 30,
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: width,
                        height: 30,
                        decoration: decoration.copyWith(
                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                              // : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                            boxShadow: [new BoxShadow(
                              color: Color.fromRGBO(0,0,0, 0.3),
                              offset: Offset(0, 5),
                              blurRadius: 6,
                            )]
                        ),
                        child: Text('(10)',
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black
                          ),
                        ),
                      )
                    ),
                    Tab(
                      height: 30,
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: width,
                        height: 30,
                        decoration: decoration.copyWith(
                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                            boxShadow: [new BoxShadow(
                              color: Color.fromRGBO(0,0,0, 0.3),
                              offset: Offset(0, 5),
                              blurRadius: 6,
                            )]
                        ),
                        child: Text('(09)',
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black
                          ),
                        ),
                      )
                    )
                ]
              ),
            ),
            SizedBox(height: height*0.02),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                  )
                ),
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 50),
                width: width,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabcontroller,
                  children: [
                    NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowGlow();
                          return;
                        },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: height*0.02),
                            buildCard(height,decoration1),
                            SizedBox(height: height*0.02),
                            buildCard(height,decoration2),
                            SizedBox(height: height*0.02),
                            buildCard(height,decoration3),
                            SizedBox(height: height*0.02),
                            buildCard(height,decoration1),
                            SizedBox(height: height*0.02),
                            buildCard(height,decoration2),
                            SizedBox(height: height*0.02),
                            buildCard(height,decoration3),
                            SizedBox(height: height*0.03),
                          ],
                        ),
                      ),
                    ),
                    Text("Page 2",
                        style: textStyle.copyWith(
                            color: Colors.black
                        )
                    ),
                    Text("Page 3",
                        style: textStyle.copyWith(
                            color: Colors.black
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Card buildCard(double height, var Deco) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: round1.copyWith()
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: ListTile(
          title: Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: Deco.copyWith(),
              ),
              SizedBox(width: 10),
              Text(
                'Product Delivered',
                style: textStyle.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              SizedBox(height: height*0.01,),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: textStyle.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Text(
                '9:30 AM',
                overflow: TextOverflow.ellipsis,
                style: textStyle.copyWith(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: height*0.015,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/home/person1.png",width: 20,height: 20),
                  Image.asset("assets/images/home/person2.png",width: 20,height: 20),
                  Image.asset("assets/images/home/person3.png",width: 20,height: 20),
                  Image.asset("assets/images/home/person4.png",width: 20,height: 20),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}