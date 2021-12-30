import 'dart:async';

import 'package:colorsoul/components.dart';
import 'package:colorsoul/location.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'appColors.dart';
import 'location_card.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

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
              position: LatLng(21.175397, 72.830902),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height/3,
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      onMapCreated: _onMapCreated,
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                          target:  LatLng(21.175397, 72.830902),
                          zoom: 16
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Be Shoppers Stop",
                              style: textStyle.copyWith(
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              child: Image.asset("assets/images/details/menu1.png",height: 20,width: 20,)
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset("assets/images/details/location5.png",height: 20,width: 20),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle.copyWith(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    width: width,
                    decoration: BoxDecoration(
                    color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "Shop Details",
                          style: textStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Today",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Open Until 9:00 PM",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Phone",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "(+91) 85649 58779",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Distance",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "3.6 Km Away",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Working Hours",
                          style: textStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Monday",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "10:00 AM - 9:00 PM",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Tuesday",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "10:00 AM - 9:00 PM",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Wednesday",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "10:00 AM - 9:00 PM",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Thursday",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "10:00 AM - 9:00 PM",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Friday",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "10:00 AM - 9:00 PM",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Saturday",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "10:00 AM - 9:00 PM",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Sunday",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Off",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              child: Image.asset("assets/images/details/image1.png",width: width/4)
                            ),
                            Card(
                              elevation: 10,
                              child: Image.asset("assets/images/details/image2.png",width: width/4)
                            ),
                            Card(
                              elevation: 10,
                              child: Image.asset("assets/images/details/image3.png",width: width/4)
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                            height: 50,
                            width: width-30,
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
                                child: Text('Direction',
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}