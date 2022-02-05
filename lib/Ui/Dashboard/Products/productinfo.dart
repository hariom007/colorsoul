import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Model/Product_Model.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../Values/colorselect.dart';
import '../../../Values/components.dart';
import 'preview.dart';


class ProductInfo extends StatefulWidget {

  String name,shortDecs,longDesc;
  List<ApiColor> colors;
  List<ClProductImg> images;
  List<Pattribute> specification;

  ProductInfo({Key key,this.name,this.images,this.colors,this.shortDecs,this.longDesc,this.specification}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();

}

class _ProductInfoState extends State<ProductInfo> {
  int currentPage = 0;
  PageController _controller;

  List ProductImg = [];

  @override
  void initState(){
    _controller = PageController(initialPage: 0);
    super.initState();

    for(int i = 0;i<widget.images.length;i++){
      ProductImg.add("${widget.images[i].hPath}"+"${widget.images[i].imageName}");
    }

  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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
                SizedBox(height: 10),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset("assets/images/productsdata/back1.png",width: 20,height: 20),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: InkWell(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Preview(imgname: widget.imgname)));
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
                                  image: ProductImg[index],
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
                SizedBox(height: 3),

                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.colors.length > 10 ? 10 : widget.colors.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: Container(
                          padding: EdgeInsets.all(2.5),
                          height: 23,
                          width: 23,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor("${widget.colors[index].hexCode}"),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 10),

                Container(
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
                            "${widget.name.toUpperCase()}",
                            style: textStyle.copyWith(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:
                          Html(
                            shrinkWrap: true,
                            data: '${widget.shortDecs}'
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
                              expanded:
                              GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 9,
                                      crossAxisSpacing: 15.0,
                                      mainAxisSpacing: 15.0,
                                      childAspectRatio: 1
                                  ),
                                  shrinkWrap: true,
                                  itemCount: widget.colors.length,
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  itemBuilder: (context, index){
                                    return Container(
                                      padding: EdgeInsets.all(2.5),
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor("${widget.colors[index].hexCode}"),
                                      ),
                                    );
                                  }
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
                            expanded:
                            SizedBox(
                              child: Html(
                                data: '${widget.longDesc}',
                                style: {
                                  '#': Style(
                                      fontSize: FontSize(14),
                                      maxLines: 5,
                                      color: AppColors.black,
                                      textOverflow: TextOverflow.ellipsis,
                                      fontFamily: "Roboto-Regular"
                                  ),
                                },
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


                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 10),
                                shrinkWrap: true,
                                itemCount: widget.specification.length,
                                itemBuilder: (context, index){
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                        children: [
                                          Text(
                                            "${widget.specification[index].key}:",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            "${widget.specification[index].value}",
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                  );
                                },
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
    return CachedNetworkImage(
      imageUrl: "$image",
      placeholder: (context, url) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: SpinKitThreeBounce(
              color: AppColors.black,
              size: 25.0,
            )
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
    );
  }
}