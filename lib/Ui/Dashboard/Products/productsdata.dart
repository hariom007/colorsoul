import 'package:colorsoul/Ui/Dashboard/Products/productsfilter.dart';
import 'package:flutter/material.dart';
import '../../../Values/appColors.dart';
import '../../../Values/colorselect.dart';
import '../../../Values/components.dart';
import 'productinfo.dart';

class ProductsData extends StatefulWidget {
  const ProductsData({Key key}) : super(key: key);

  @override
  _ProductsDataState createState() => _ProductsDataState();
}

class _ProductsDataState extends State<ProductsData> {
  String value = '1';
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0,0,0,0.9],colors: [AppColors.grey1,AppColors.grey1,AppColors.grey1,AppColors.grey2]),
                    borderRadius: round1.copyWith(
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(0)
                    ),
                    boxShadow: [new BoxShadow(
                      color: Color.fromRGBO(0,0,0, 0.5),
                      offset: Offset(0, 6),
                      blurRadius: 5,
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
                              hintText: "Regular Nail Polish",
                              hintStyle: textStyle.copyWith(
                                  color: AppColors.black
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                      Navigator.pop(context);
                                      },
                                      icon: Image.asset('assets/images/productsdata/back1.png',width: 20,height: 20),
                                    ),
                                    SizedBox(width: 10),
                                    Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                  ],
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Image.asset('assets/images/productsdata/mic.png',width: 26,height: 26),
                                onPressed: null,
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
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                children: [
                  Container(
                      height: height*0.04,
                      width: width/2.8,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                          borderRadius: round.copyWith()
                      ),
                      child:  Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: DropdownButton<String>(
                          icon: Image.asset('assets/images/productsdata/down1.png',width: 16),
                          isExpanded: true,
                          value: value,
                          borderRadius: round.copyWith(),
                          dropdownColor: AppColors.black,
                          style: textStyle.copyWith(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold
                          ),
                          underline: SizedBox(),
                          items: [
                            DropdownMenuItem(
                                value: "1",
                                child: Text("Popularity")
                            ),
                            DropdownMenuItem(
                                value: "2",
                                child: Text("Relevance")
                            ),
                            DropdownMenuItem(
                                value: "3",
                                child: Text("Low to High")
                            ),
                            DropdownMenuItem(
                                value: "4",
                                child: Text("High to Low")
                            ),
                            DropdownMenuItem(
                                value: "5",
                                child: Text("Newest First")
                            ),
                          ],
                          onChanged: (_value) {
                            setState((){
                              value = _value;
                            });
                          },
                        ),
                      )
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductsFilter()
                          )
                      );
                    },
                    child: Image.asset("assets/images/productsdata/filter1.png",width: 26,height: 26)
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 5),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 20,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(name: 'product1',imgname: "assets/images/productsdata/nail-polish7.png")));
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: round1.copyWith()
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Hero(
                                              tag: 'product1',
                                              child: Image.asset("assets/images/productsdata/nail-polish7.png",width: width/5)
                                            ),
                                          ),
                                          ColorAndSize(),
                                          SizedBox(height: 10),
                                          Text(
                                            "GEL NAIL POLISH",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Lorem ipsum dolor sit amet.",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "₹263",
                                                style: textStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black,
                                                  fontSize: 20
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "₹720",
                                                style: textStyle.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5,right: 10),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 20,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(name: 'product2',imgname: "assets/images/productsdata/nail-polish8.png")));
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: round1.copyWith()
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Hero(
                                            tag: 'product2',
                                            child: Center(child: Image.asset("assets/images/productsdata/nail-polish8.png",width: width/3))
                                          ),
                                          SizedBox(height: 5),
                                          ColorAndSize(),
                                          SizedBox(height: 10),
                                          Text(
                                            "TANNING",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Lorem ipsum dolor sit amet.",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "₹263",
                                                style: textStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black,
                                                    fontSize: 20
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "₹720",
                                                style: textStyle.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ),
                                  ),
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
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 5),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 20,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(name: 'product3',imgname: "assets/images/productsdata/nail-polish7.png")));
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: round1.copyWith()
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Hero(
                                                tag: 'product3',
                                                child: Image.asset("assets/images/productsdata/nail-polish7.png",width: width/5)
                                            ),
                                          ),
                                          ColorAndSize(),
                                          SizedBox(height: 10),
                                          Text(
                                            "GEL NAIL POLISH",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Lorem ipsum dolor sit amet.",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "₹263",
                                                style: textStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black,
                                                    fontSize: 20
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "₹720",
                                                style: textStyle.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5,right: 10),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 20,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(name: 'product4',imgname: "assets/images/productsdata/nail-polish8.png")));
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: round1.copyWith()
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Hero(
                                              tag: 'product4',
                                              child: Center(child: Image.asset("assets/images/productsdata/nail-polish8.png",width: width/3))
                                          ),
                                          SizedBox(height: 5),
                                          ColorAndSize(),
                                          SizedBox(height: 10),
                                          Text(
                                            "TANNING",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Lorem ipsum dolor sit amet.",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "₹263",
                                                style: textStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black,
                                                    fontSize: 20
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "₹720",
                                                style: textStyle.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ),
                                  ),
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
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 5),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 20,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(name: 'product5',imgname: "assets/images/productsdata/nail-polish7.png")));
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: round1.copyWith()
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Hero(
                                                tag: 'product5',
                                                child: Image.asset("assets/images/productsdata/nail-polish7.png",width: width/5)
                                            ),
                                          ),
                                          ColorAndSize(),
                                          SizedBox(height: 10),
                                          Text(
                                            "GEL NAIL POLISH",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Lorem ipsum dolor sit amet.",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "₹263",
                                                style: textStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black,
                                                    fontSize: 20
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "₹720",
                                                style: textStyle.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5,right: 10),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 20,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(name: 'product6',imgname: "assets/images/productsdata/nail-polish8.png")));
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: round1.copyWith()
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Hero(
                                              tag: 'product6',
                                              child: Center(child: Image.asset("assets/images/productsdata/nail-polish8.png",width: width/3))
                                          ),
                                          SizedBox(height: 5),
                                          ColorAndSize(),
                                          SizedBox(height: 10),
                                          Text(
                                            "TANNING",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Lorem ipsum dolor sit amet.",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 14
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "₹263",
                                                style: textStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black,
                                                    fontSize: 20
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "₹720",
                                                style: textStyle.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    decoration: TextDecoration.lineThrough
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}