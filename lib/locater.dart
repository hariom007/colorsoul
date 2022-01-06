import 'package:colorsoul/Values/components.dart';
import 'package:colorsoul/Model/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Values/appColors.dart';
import 'Provider/location_card.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  void setCustomMarker() async{
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/locater/location4.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void _onMapCreated(GoogleMapController controller){
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('1'),
            position: LatLng(21.173838, 72.835619),
            icon: mapMarker
        ),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('2'),
            position: LatLng(21.165725,72.826256),
            icon: mapMarker
        )
      );
      _markers.add(
          Marker(
              markerId: MarkerId('3'),
              position: LatLng(21.171510, 72.826349),
              icon: mapMarker
          )
      );
      _markers.add(
          Marker(
              markerId: MarkerId('4'),
              position: LatLng(21.175397, 72.830902),
              icon: mapMarker
          )
      );
      _markers.add(
          Marker(
              markerId: MarkerId('5'),
              position: LatLng(21.169075, 72.837086),
              icon: mapMarker
          )
      );
      _markers.add(
          Marker(
              markerId: MarkerId('6'),
              position: LatLng(21.164557, 72.835134),
              icon: mapMarker
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          leading: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset("assets/images/locater/menu.png"),
          ),
          title: Image.asset("assets/images/Colorsoul_final-022(Traced).png",height: 22),
          actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                  onTap: (){},
                  child: Image.asset("assets/images/locater/cart.png",height: 20)
              ),
            )
          ],
        ),
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
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                    height: height/2.6,
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      onMapCreated: _onMapCreated,
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(21.1702,72.8311),
                        zoom: 15
                      ),
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
                              color: Color.fromRGBO(255, 255, 255, 0.3),
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
                            SizedBox(
                                height: 50,
                                width: 80,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                      borderRadius: round.copyWith()
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return SimpleCustomAlert();
                                          }
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        shadowColor: Color.fromRGBO(0,0,0,.3),
                                        primary: Colors.transparent,
                                        shape: StadiumBorder()
                                    ),
                                    child: Image.asset("assets/images/locater/filter.png",width: 24,)
                                  ),
                                )
                            )
                          ],
                        ),
                    ),
                  ),
                  SizedBox(height: height*0.02),
                  Text(
                    "Showing results 1 - 6",
                    style: textStyle.copyWith(),
                  ),
                  SizedBox(height: height*0.01),
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: Container(
                      //height: height*0.36,
                      padding: EdgeInsets.only(left: 15,right: 15,bottom: 50),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount: LocationModel1.location1.length,
                        itemBuilder: (context, index){
                          return LocationCard1(location1: LocationModel1.location1[index]);
                        },
                      ),
                    ),
                  )
                ],
              ),
          ),
        ),
        )
    );
  }
}

class SimpleCustomAlert extends StatefulWidget {
  @override
  State<SimpleCustomAlert> createState() => _SimpleCustomAlertState();
}

class _SimpleCustomAlertState extends State<SimpleCustomAlert> {

  String value;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
          borderRadius: round.copyWith(),
        ),
        height: height/2.65,
        width: width/2,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 20
                ),
              ),
              SizedBox(height: height*0.03),
              Container(
                height: 50,
                width: width-30,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
                        borderRadius: round.copyWith(),
                        boxShadow: [new BoxShadow(
                          color: Color.fromRGBO(0,0,0,0.2),
                          offset: Offset(0, 5),
                          blurRadius: 5,
                        )
                    ]
                ),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.black,
                    cursorHeight: 24,
                    decoration: fieldStyle.copyWith(
                        hintText: "Enter Zipcode",
                        hintStyle: textStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold
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
                )
              ),
              SizedBox(height: height*0.02),
              Container(
                height: 50,
                width: width-30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
                    borderRadius: round.copyWith(),
                    boxShadow: [new BoxShadow(
                      color: Color.fromRGBO(0,0,0,0.2),
                      offset: Offset(0, 5),
                      blurRadius: 5,
                    )
                  ]
                ),
                child:  Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: DropdownButton<String>(
                    icon: Image.asset('assets/images/locater/down.png',width: 16),
                    isExpanded: true,
                    value: value,
                    borderRadius: round.copyWith(),
                    style: textStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold
                    ),
                    underline: SizedBox(),
                    items: [
                      DropdownMenuItem(
                          value: "1",
                          child: Text("5 Km")
                      ),
                      DropdownMenuItem(
                          value: "2",
                          child: Text("10 Km")
                      ),
                      DropdownMenuItem(
                          value: "3",
                          child: Text("15 Km")
                      ),
                      DropdownMenuItem(
                          value: "4",
                          child: Text("20 Km")
                      ),
                      DropdownMenuItem(
                          value: "5",
                          child: Text("25 Km")
                      ),
                      DropdownMenuItem(
                          value: "6",
                          child: Text("30 Km")
                      ),
                    ],
                    onChanged: (_value) {
                      setState((){
                        value = _value;
                      });
                    },
                    hint: Text(
                      "Select Distance",
                      style: textStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                   ),
                )
              ),
              SizedBox(height: height*0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: height*0.06,
                      width: width/4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                            borderRadius: round.copyWith()
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                shadowColor: Color.fromRGBO(0,0,0,.3),
                                primary: Colors.transparent,
                                shape: StadiumBorder()
                            ),
                            child: Text(
                              "Done",
                              style: textStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            )
                        ),
                      )
                  ),
                  SizedBox(
                      height: height*0.06,
                      width: width/4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                            borderRadius: round.copyWith()
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                shadowColor: Color.fromRGBO(0,0,0,.3),
                                primary: Colors.transparent,
                                shape: StadiumBorder()
                            ),
                           child: Text(
                          "Cancel",
                          style: textStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
