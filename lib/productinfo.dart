import 'package:colorsoul/appColors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'colorselect.dart';
import 'components.dart';
import 'preview.dart';


class ProductInfo extends StatefulWidget {

  ProductInfo({Key key,this.name,this.imgname}) : super(key: key);

  String name;
  String imgname;

  @override
  _ProductInfoState createState() => _ProductInfoState();

}

class _ProductInfoState extends State<ProductInfo> {
  int currentPage = 0;
  PageController _controller;

  @override
  void initState(){
    _controller = PageController(initialPage: 0);
    super.initState();

    ProductImg = [
      {
        "image": widget.imgname
      },
      {
        "image": widget.imgname
      },
      {
        "image": widget.imgname
      }
    ];

  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  List<Map<String,String>> ProductImg;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Container(
        //       height: 70,
        //       decoration: BoxDecoration(
        //           color: Color.fromRGBO(185, 185, 185, 0.6),
        //           // gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0,0,0,0.9],colors: [AppColors.grey1,AppColors.grey1,AppColors.grey1,AppColors.grey2]),
        //           boxShadow: [new BoxShadow(
        //             color: Color.fromRGBO(0,0,0, 0.2),
        //             offset: Offset(0, -5),
        //             blurRadius: 10,
        //           )
        //         ]
        //       ),
        //       child: Padding(
        //         padding: EdgeInsets.all(10),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(width: 10),
        //             Container(
        //               padding: EdgeInsets.only(right: 5),
        //               height: 50,
        //               width: 80,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: AppColors.black),
        //                 gradient: LinearGradient(colors: [AppColors.grey1,AppColors.grey2,]),
        //                 borderRadius: round.copyWith(),
        //               ),
        //               child: IconButton(
        //                 splashColor: Colors.transparent,
        //                 highlightColor: Colors.transparent,
        //                 hoverColor: Colors.transparent,
        //                 icon: Image.asset("assets/images/locater/cart.png",color: AppColors.black,width: 30,height: 30),
        //                 onPressed: (){},
        //               ),
        //             ),
        //             SizedBox(width: 15),
        //             SizedBox(
        //               height: 50,
        //               width: width/1.5,
        //               child: DecoratedBox(
        //                 decoration: BoxDecoration(
        //                     gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
        //                     borderRadius: round.copyWith()
        //                 ),
        //                 child: ElevatedButton(
        //                   onPressed: () {},
        //                   style: ElevatedButton.styleFrom(
        //                       primary: Colors.transparent,
        //                       shape: StadiumBorder()
        //                   ),
        //                   child: Text('Apply',
        //                     textAlign: TextAlign.center,
        //                     style: textStyle.copyWith(
        //                       fontSize: 20,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //               )
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset("assets/images/productsdata/back1.png",width: 20,height: 20),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Preview(imgname: widget.imgname)));
                    },
                    child: Hero(
                        tag: widget.name,
                        child: Container(
                          height: height/2.4,
                          child: PageView.builder(
                              controller: _controller,
                              onPageChanged: (value) {
                                setState(() {
                                  currentPage = value;
                                });
                              },
                              itemCount: ProductImg.length,
                              itemBuilder: (context,index) => ProductContent(
                                  image: ProductImg[index]["image"],
                              )
                          ),
                        ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      ProductImg.length,
                          (index) => buildDot(index: index)
                  ),
                ),
                SizedBox(height: 15),
                ColorAndSize1(),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Row(
                        children: [
                          Text(
                            "₹720",
                            style: textStyle.copyWith(
                                color: Colors.grey,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "3% off",
                            style: textStyle.copyWith(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(185, 185, 185, 0.6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  "PRODUCT DETAILS",
                                  style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontSize: 12
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  "Colorsoul Gel Nail Lacquer",
                                  style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                  style: textStyle.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 14),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 60,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                            borderRadius: round.copyWith()
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "4.4",
                                              style: textStyle.copyWith(),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(right: 4,bottom: 2),
                                              child: Image.asset("assets/images/productsdata/star.png",width: 12,height: 12),
                                            )
                                          ],
                                        )
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "(57,164) ratings and 5,609 reviews",
                                      style: textStyle.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: Color.fromRGBO(185, 185, 185, 0.75),
                                thickness: 2
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "SHADE",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black
                                      ),
                                    ),
                                  ),
                                  iconColor: AppColors.black,
                                  expanded: Column(
                                    children: [
                                      ColorAndSize2(),
                                      SizedBox(height: 10),
                                      ColorAndSize2(),
                                      SizedBox(height: 10),
                                      ColorAndSize2(),
                                      SizedBox(height: 10),
                                      ColorAndSize2(),
                                    ],
                                  )
                                ),
                              ),
                              Divider(
                                  color: Color.fromRGBO(185, 185, 185, 0.75),
                                  thickness: 2
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "PRODUCT DESCRIPTION",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black
                                      ),
                                    ),
                                  ),
                                  iconColor: AppColors.black,
                                  expanded: Text(
                                    "DeBelle naturally enriched range of Gel Nail Lacquer. It gives a rich salon shine finish with good staying power and gives a very rich and elegant nails. Enriched with anti-oxidant rich seaweed extract, this gel nail polish helps to promote nail growth and to maintain healthy nails by preventing yellowing of nails.  nail polishes can be used in various nail art concepts. This Gel Nail Polish dries naturally. Paint away with 5 free Gel Nail Lacquer free from toxic chemicals. Get your professional manicure/pedicure right at the comfort of your home with DeBelle range of Gel Nail Lacquer. This nail polish shade is perfect summer nail shade.", softWrap: true,
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                      height: 1.4
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Color.fromRGBO(185, 185, 185, 0.75),
                                thickness: 2
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  "BENEFITS",
                                  style: textStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  '• Strengthens The Nails',
                                  style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  '• High Color Payoff',
                                  style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  '• Chip Resistant',
                                  style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  '• Long Lasting',
                                  style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  '• Consistent Shade',
                                  style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: Color.fromRGBO(185, 185, 185, 0.75),
                                thickness: 2
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "SPECIFICATIONS",
                                      style: textStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black
                                      ),
                                    ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Item Form:",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Gel",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                       ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Brand:",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "LAKMÉ",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Model Name:",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "True Wear Nail Color",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Color:",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Burgundy",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Shade:",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Red & Maroons 401",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Finish Type:",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Matte",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Age Range (Description):",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Adult",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Liquid Volume:",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "6 Milliliters",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "Maximum Shelf Life:",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "24 Months",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                  color: Color.fromRGBO(185, 185, 185, 0.75),
                                  thickness: 2
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "RATINGS & REVIEWS",
                                      style: textStyle.copyWith(
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    SizedBox(
                                      height: 30,
                                      width: width/4.5,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                            borderRadius: round.copyWith()
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.transparent,
                                              shape: StadiumBorder()
                                          ),
                                          child: Text('Rate Us',
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 60,
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                              borderRadius: round.copyWith()
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "4.4",
                                                style: textStyle.copyWith(),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 4,bottom: 2),
                                                child: Image.asset("assets/images/productsdata/star.png",width: 12,height: 12),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "(57,164) ratings and 5,609 reviews",
                                      style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Text(
                                  "Images uploaded by customers:",
                                  style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10)
                                        )
                                      ),
                                      child: Image.asset("assets/images/productsdata/image5.png",width: 80,height: 80),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10)
                                          )
                                      ),
                                      child: Image.asset("assets/images/productsdata/image6.png",width: 80,height: 80),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10)
                                          )
                                      ),
                                      child: Image.asset("assets/images/productsdata/image5.png",width: 80,height: 80),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10)
                                          )
                                      ),
                                      child: Image.asset("assets/images/productsdata/image6.png",width: 80,height: 80),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10)
                                          )
                                      ),
                                      child: Image.asset("assets/images/productsdata/image5.png",width: 80,height: 80),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10)
                                          )
                                      ),
                                      child: Image.asset("assets/images/productsdata/image6.png",width: 80,height: 80),
                                    ),
                                    SizedBox(width: 15)
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                  color: Color.fromRGBO(185, 185, 185, 0.75),
                                  thickness: 2
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 24,
                                            backgroundImage: AssetImage("assets/images/productsdata/person5.png")
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Ruchira",
                                          style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 60,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                  borderRadius: round.copyWith()
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "4.4",
                                                    style: textStyle.copyWith(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 4,bottom: 2),
                                                    child: Image.asset("assets/images/productsdata/star.png",width: 12,height: 12),
                                                  )
                                                ],
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Worth every penny.",
                                          style: textStyle.copyWith(
                                            fontSize: 16,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Reviewed in India on 12 October 2019"
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/productsdata/certified.png",width: 15,height: 15),
                                        SizedBox(width: 10),
                                        Text(
                                          "Certified Buyer, Butibori",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                              )
                                          ),
                                          child: Image.asset("assets/images/productsdata/image5.png",width: 80,height: 80),
                                        ),
                                        SizedBox(width: 15),
                                        Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                              )
                                          ),
                                          child: Image.asset("assets/images/productsdata/image6.png",width: 80,height: 80),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Very very dim and transparent even after applying 4 to 5 times. TAKES LONG to dry. Not worth. Looks really bad and ugly. And it's not even too cheap either. Like I've bought nai l polishes from normal shops around the same price and they look so much better.",
                                      style: textStyle.copyWith(
                                        color: AppColors.black,
                                        height: 1.4
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "Was this review helpful ?",
                                          style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          height: 24,
                                          width: 60,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                  borderRadius: round.copyWith()
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "17",
                                                    style: textStyle.copyWith(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 4,bottom: 2),
                                                    child: Image.asset("assets/images/productsdata/like.png",width: 14,height: 14),
                                                  )
                                                ],
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          height: 24,
                                          width: 60,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                  borderRadius: round.copyWith()
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "06",
                                                    style: textStyle.copyWith(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 4,bottom: 2),
                                                    child: Image.asset("assets/images/productsdata/dislike.png",width: 14,height: 14),
                                                  )
                                                ],
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                  color: Color.fromRGBO(185, 185, 185, 0.75),
                                  thickness: 2
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 24,
                                            backgroundImage: AssetImage("assets/images/productsdata/person5.png")
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Ruchira",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 60,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                  borderRadius: round.copyWith()
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "4.4",
                                                    style: textStyle.copyWith(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 4,bottom: 2),
                                                    child: Image.asset("assets/images/productsdata/star.png",width: 12,height: 12),
                                                  )
                                                ],
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Worth every penny.",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                        "Reviewed in India on 12 October 2019"
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/productsdata/certified.png",width: 15,height: 15),
                                        SizedBox(width: 10),
                                        Text(
                                          "Certified Buyer, Butibori",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                              )
                                          ),
                                          child: Image.asset("assets/images/productsdata/image5.png",width: 80,height: 80),
                                        ),
                                        SizedBox(width: 15),
                                        Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                              )
                                          ),
                                          child: Image.asset("assets/images/productsdata/image6.png",width: 80,height: 80),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Very very dim and transparent even after applying 4 to 5 times. TAKES LONG to dry. Not worth. Looks really bad and ugly. And it's not even too cheap either. Like I've bought nai l polishes from normal shops around the same price and they look so much better.",
                                      style: textStyle.copyWith(
                                          color: AppColors.black,
                                          height: 1.4
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "Was this review helpful ?",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          height: 24,
                                          width: 60,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                  borderRadius: round.copyWith()
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "17",
                                                    style: textStyle.copyWith(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 4,bottom: 2),
                                                    child: Image.asset("assets/images/productsdata/like.png",width: 14,height: 14),
                                                  )
                                                ],
                                              )
                                          ),
                                        ),SizedBox(width: 10),
                                        SizedBox(
                                          height: 24,
                                          width: 60,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                  borderRadius: round.copyWith()
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "06",
                                                    style: textStyle.copyWith(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 4,bottom: 2),
                                                    child: Image.asset("assets/images/productsdata/dislike.png",width: 14,height: 14),
                                                  )
                                                ],
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 40,
                      child: SizedBox(
                        height: 60,
                        width: 120,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                              borderRadius: round1.copyWith(),
                              boxShadow: [new BoxShadow(
                                color: Color.fromRGBO(0,0,0, 0.5),
                                offset: Offset(0, 4),
                                blurRadius: 5,
                              )
                            ]
                          ),
                          child: Center(
                            child: Text(
                              "₹263",
                              style: textStyle.copyWith(
                                fontSize: 26,
                              ),
                            ),
                          )
                        )
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          gradient: currentPage == index ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.white,Colors.black,Colors.black]) : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.white,Colors.grey]),
          borderRadius: BorderRadius.circular(6)
      ),
    );
  }
}

class ProductContent extends StatelessWidget {
  ProductContent({Key key, this.image}) : super(key: key);

  final image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image);
  }
}