import 'package:colorsoul/Values/appColors.dart';
import 'package:flutter/material.dart';
import '../../../Values/components.dart';
import 'productsdata.dart';

class Products extends StatefulWidget {
   @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              content: Container(
                height: 100,
                width: width/1.2,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: round1.copyWith()
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Are you sure you want to exit?',
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
                              'Yes, exit',
                              style: textStyle.copyWith(
                                  color: AppColors.black
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
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
        return value == true;
      },
      child: Scaffold(
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
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Product List",
                        style: textStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: height*0.02),
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
                                    hintText: "Search Product",
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
                                    child: Image.asset("assets/images/products/search1.png",width: 20)
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.03),
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
      ),
    );
  }
}
