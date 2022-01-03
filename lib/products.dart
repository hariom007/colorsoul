import 'package:flutter/material.dart';

import 'appColors.dart';
import 'components.dart';
import 'productsdata.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body:Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Flesh2.png"),
                fit: BoxFit.fill,
              )
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: Column(
              children: [
                SizedBox(height: height*0.062),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Image.asset("assets/images/locater/menu.png",width: 16),
                      SizedBox(width: 37),
                      Image.asset("assets/images/Colorsoul_final-022(Traced).png",height: 22),
                      Expanded(
                          child: Container()
                      ),
                      InkWell(
                          onTap: (){},
                          child: Image.asset("assets/images/locater/cart.png",height: 20)
                      )
                    ],
                  ),
                ),
                SizedBox(height: height*0.03),
                Container(
                  height: 50,
                  width: width-30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0,0,0,0.9],colors: [AppColors.grey1,AppColors.grey1,AppColors.grey1,AppColors.grey2]),
                        borderRadius: round.copyWith(),
                        boxShadow: [new BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        )
                      ]
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              cursorColor: AppColors.black,
                              cursorHeight: 24,
                              decoration: InputDecoration(
                                  hintText: "Search Location",
                                  hintStyle: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )
                                  ),
                                  isDense: true
                              )
                          ),
                        ),
                        SizedBox(
                            height: 50,
                            width: 80,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                  borderRadius: round.copyWith()
                              ),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      shadowColor: Color.fromRGBO(0,0,0,.2),
                                      primary: Colors.transparent,
                                      shape: StadiumBorder()
                                  ),
                                  child: Image.asset("assets/images/products/search1.png",width: 24,)
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.03),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Image.asset("assets/images/products/design1.png",height: 25),
                      SizedBox(width: 5),
                      Text(
                        "BEST SELLERS",
                        style: textStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5),
                      Image.asset("assets/images/products/design2.png",height: 25),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  color: Colors.transparent,
                                  elevation: 20,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductsData()
                                          )
                                      );
                                    },
                                    child: Container(
                                      height: width/2.5,
                                      width: width/2.5,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: round1.copyWith()
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset("assets/images/products/nail-polish1.png",height: 80),
                                          SizedBox(height: 10),
                                          Text(
                                            "Enamel",
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.transparent,
                                  elevation: 20,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductsData()
                                          )
                                      );
                                    },
                                    child: Container(
                                      height: width/2.5,
                                      width: width/2.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: round1.copyWith()
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset("assets/images/products/nail-polish2.png",height: 80),
                                          SizedBox(height: 10),
                                          Text(
                                            "Enamel",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  color: Colors.transparent,
                                  elevation: 20,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductsData()
                                          )
                                      );
                                    },
                                    child: Container(
                                      height: width/2.5,
                                      width: width/2.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: round1.copyWith()
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset("assets/images/products/nail-polish3.png",height: 80),
                                          SizedBox(height: 10),
                                          Text(
                                            "Enamel",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.transparent,
                                  elevation: 20,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductsData()
                                          )
                                      );
                                    },
                                    child: Container(
                                      height: width/2.5,
                                      width: width/2.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: round1.copyWith()
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset("assets/images/products/nail-polish4.png",height: 80),
                                          SizedBox(height: 10),
                                          Text(
                                            "Enamel",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  color: Colors.transparent,
                                  elevation: 20,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductsData()
                                          )
                                      );
                                    },
                                    child: Container(
                                      height: width/2.5,
                                      width: width/2.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: round1.copyWith()
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset("assets/images/products/nail-polish5.png",height: 80),
                                          SizedBox(height: 10),
                                          Text(
                                            "Enamel",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.transparent,
                                  elevation: 20,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductsData()
                                          )
                                      );
                                    },
                                    child: Container(
                                      height: width/2.5,
                                      width: width/2.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: round1.copyWith()
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 25),
                                          Image.asset("assets/images/products/nail-polish6.png",height: 70),
                                          SizedBox(height: 15),
                                          Text(
                                            "Enamel",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
