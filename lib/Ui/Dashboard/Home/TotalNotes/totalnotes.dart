import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class TotalNotes extends StatefulWidget {
  @override
  _TotalNotesState createState() => _TotalNotesState();
}

class _TotalNotesState extends State<TotalNotes> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.062),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/images/tasks/back.png",height: 20,width: 20)
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: width/1.5,
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
                                    hintText: "Search your notes",
                                    hintStyle: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                    prefixIcon: new IconButton(
                                      icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
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
                      Expanded(child: Container()),
                      Image.asset("assets/images/notes/grid.png",width: 25,height: 25)
                    ],
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
                          padding: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: round1.copyWith()
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Chandanvan society",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.asset("assets/images/tasks/location1.png",width: 20,height: 20),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              "Silicon Shoppers, F4, 1st Floor,  Chandanvan Society, Udhna, Surat, Gujarat 394210",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  height: 1.4
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: round1.copyWith()
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Payment",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam arcu sodales eget lacus orci dignissim. Nec nunc eu massa eu. At lectus sit arcu tincidunt felis hendrerit lectus fames ut. Sed vel senectus iaculis neque malesuada.",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          height: 1.4
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Card(
                                color: Color.fromRGBO(246, 172, 210, 1),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: round1.copyWith()
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Incomplete Work",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dignissim posuere ac mauris, suscipit justo volutpat nibh in. Dignissim in euismod lacus, ut habitasse at. Elementum ultricies id velit vulputate. Non vitae sed sed aenean. Tincidunt pellentesque sapien ultrices eget dignissim sapien, malesuada eu, nunc. Nunc id mollis lectus blandit risus dui arcu. Massa.",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            height: 1.4
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: round1.copyWith()
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Shop image",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Udhna shops image",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Card(
                                              elevation: 10,
                                              child: Image.asset("assets/images/details/image1.png",width: width/4.5)
                                          ),
                                          Card(
                                              elevation: 10,
                                              child: Image.asset("assets/images/details/image2.png",width: width/4.5)
                                          ),
                                          Card(
                                              elevation: 10,
                                              child: Image.asset("assets/images/details/image3.png",width: width/4.5)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Card(
                                color: Color.fromRGBO(255, 237, 144, 1),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: round1.copyWith()
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Next Meeting",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Meeting with amit office visit",
                                        style: textStyle.copyWith(
                                          color: AppColors.black
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Image.asset("assets/images/notes/clock1.png",width: 20,height: 20),
                                          SizedBox(width: 10),
                                          Text(
                                            "3:00 PM"
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
