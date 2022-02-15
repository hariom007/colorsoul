import 'package:colorsoul/Model/location.dart';
import 'package:colorsoul/Provider/location_card.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/currentlocation.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';


class LocationPage extends StatefulWidget {
  const LocationPage({Key key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  String kGoogleApiKey = "AIzaSyDMFjsFu-RTGRYCHsGV10Cl2UzP22FRkGU";
  // String kGoogleApiKey = "AIzaSyDMFjsFu-RTGRYCHsGV10Cl2UzP22FRkGU";
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  // Position _currentPosition;
  TextEditingController addressController=TextEditingController();

  Future<Position> getGeoLocationPosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        Fluttertoast.showToast(
            msg: "Location permissions are denied. !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return Future.error('Location permissions are denied');
      }
      else{
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }

    }

    if (permission == LocationPermission.deniedForever) {

      Fluttertoast.showToast(
          msg: "Location permissions are permanently denied, we cannot request permissions. !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  }

  Future<void> getAddressFromLatLong(Position position)async {
    final coordinates = new Coordinates(position.latitude, position.longitude);

    var fullAddress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = fullAddress.first;

    String finalAddress = "${first.addressLine},${first.locality}/${first.subAdminArea}/${first.adminArea}/${first.postalCode}/${coordinates.latitude}/${coordinates.longitude}";

    Navigator.pop(context,"$finalAddress");
   // Navigator.pop(context,"$finalAddress");

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
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
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Image.asset("assets/images/tasks/back.png",height: 20,width: 20)
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 50,
                          width: width/1.2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0,0,0,0.9],colors: [AppColors.grey1,AppColors.grey1,AppColors.grey1,AppColors.grey2]),
                              borderRadius: round.copyWith(),
                              boxShadow: [new BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                offset: Offset(0, 10),
                                blurRadius: 20,
                              )]
                            ),
                            child: TextFormField(
                                readOnly: true,
                                onTap: _handlePressButton,
                                cursorColor: AppColors.black,
                                cursorHeight: 24,
                                decoration: InputDecoration(
                                    hintText: "Search for area, street name...",
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.02),
                  Divider(
                    color: Color.fromRGBO(185, 185, 185, 0.75),
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () async {

                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Center(
                              child: SpinKitThreeBounce(
                                color: AppColors.white,
                                size: 25.0,
                              ),
                            ),
                          )
                      );

                      Position position = await getGeoLocationPosition();
                      getAddressFromLatLong(position);

                    },
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: Row(
                        children: [
                          Image.asset("assets/images/neworder/traget.png",width: 30,height: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Use Current Location",
                                style: textStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Using GPS",
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.01),

                  /*Expanded(
                    child: Container(
                      color: AppColors.white,
                      padding: EdgeInsets.only(left: 15,right: 15,bottom: 50),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount: LocationModel1.location1.length,
                        itemBuilder: (context, index){
                          return LocationCard1(location1: LocationModel1.location1[index]);
                        },
                      ),
                    ),
                  )
                  */

                ],
              ),
            ),
          )
      ),
    );
  }

  Future<void> _handlePressButton() async {

/*
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(
            child: SpinKitThreeBounce(
              color: AppColors.white,
              size: 25.0,
            ),
          ),
        )
    );
*/

    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      radius: 10000000,
      mode: Mode.overlay,
      language: "en",
      types: [],
      strictbounds: false,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [
        Component(Component.country, "in"),
      ],
    );
    displayPrediction(p, homeScaffoldKey.currentState);
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      final coordinates = new Coordinates(lat, lng);

      var fullAddress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = fullAddress.first;

      String finalAddress = "${first.addressLine},${first.locality}/${first.subAdminArea}/${first.adminArea}/${first.postalCode}/${coordinates.latitude}/${coordinates.longitude}";
      Navigator.pop(context,"$finalAddress");
      //Navigator.pop(context,"$finalAddress");

    }
  }
}

