import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class ProductsFilter extends StatefulWidget {
  const ProductsFilter({Key key}) : super(key: key);

  @override
  _ProductsFilterState createState() => _ProductsFilterState();
}

class _ProductsFilterState extends State<ProductsFilter> {

  String selected = 'categories';

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    // gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0,0,0,0.9],colors: [AppColors.grey1,AppColors.grey1,AppColors.grey1,AppColors.grey2]),
                    borderRadius: round1.copyWith(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0)
                    ),
                    boxShadow: [new BoxShadow(
                      color: Color.fromRGBO(0,0,0, 0.5),
                      offset: Offset(0, -5),
                      blurRadius: 10,
                    )
                  ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: width/2.8,
                            child: Text(
                              "Clear All",
                              style: textStyle.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 50,
                          width: width/1.8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                borderRadius: round.copyWith()
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: Colors.transparent,
                                  shape: StadiumBorder()
                              ),
                              child: Text('Apply',
                                textAlign: TextAlign.center,
                                style: textStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.white,
          body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return;
              },
            child: Column(
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
                        SizedBox(width: 20),
                        Text(
                          "Filter By",
                          style: textStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/productsdata/cancel.png",width: 14,height: 14),
                          )
                        ),
                        SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'categories';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='categories' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Categories",
                                style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'price';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='price' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Price Range",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'color';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='color' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Color",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'discount';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='discount' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Discount",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'speciality';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='speciality' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Speciality",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'finish';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='finish' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Finish",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'availability';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='availability' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Availability",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'rating';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='rating' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Customer Ratings",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'gst';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='gst' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "GST Invoice",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'offer';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='offer' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Offer",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selected = 'age';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              width: width/2.8,
                              color: selected=='age' ? AppColors.white : AppColors.grey2,
                              child: Text(
                                "Target Age",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(14),
                      child: SingleChildScrollView(
                        child: selected=='categories' ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.black : Colors.grey,
                                      border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Nail Polish",
                                  style: textStyle.copyWith(
                                    color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Regular Nail Polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Matte Nail Polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Glitter Nail Polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Acrylic Nail Polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Gel nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "PolyGel Nail Polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Breathable Nail Polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "2 Combo nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "3 Combo nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "6 Combo nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.black : Colors.grey,
                                      border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "chip-resistant nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Longwear nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Quick dry nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Glitter Nail Polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Dip Powder nail polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        border: Border.all(color: Colors.grey,width: 3)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Shellac polish",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ) : selected=='price' ?
                        Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                     isSelected =! isSelected;
                                  });
                                },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "₹1000 - ₹2000",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "₹2000 - ₹3000",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "₹3000 - ₹4000",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "₹4000 - ₹5000",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ) : selected =='color' ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Red",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Brown",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Pink",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      isSelected =! isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Violet",
                                  style: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ) : Row(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  isSelected =! isSelected;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(3),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      gradient: isSelected ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : LinearGradient(colors: [Colors.transparent])
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Hello"),
                          ],
                        )
                      ),
                    )
                  ],
                ),
              )
            ]
          ),
        )
      )
    );
  }
}
