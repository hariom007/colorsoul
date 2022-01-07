import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({Key key}) : super(key: key);

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
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
              position: LatLng(21.172160, 72.838998),
              icon: mapMarker
          )
      );
    });
  }

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
                    height: 200,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        ),
                        boxShadow: [new BoxShadow(
                          color: Color.fromRGBO(0,0,0, 0.2),
                          offset: Offset(0, -5),
                          blurRadius: 5,
                        ),
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Select Location",
                            style: textStyle.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Chandanvan society",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                  height: 30,
                                  width: 80,
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
                                          primary: Colors.transparent,
                                          shape: StadiumBorder()
                                      ),
                                      child: Text('Change',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset("assets/images/details/location5.png",width: 20,height: 20,color: AppColors.black),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  "Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 14),
                          SizedBox(
                              height: 50,
                              width: width,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                    borderRadius: round.copyWith()
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      primary: Colors.transparent,
                                      shape: StadiumBorder()
                                  ),
                                  child: Text('Confirm Location',
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    )
                )
              ]
          ),
          body:GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target:  LatLng(21.172160, 72.838998),
              zoom: 18
            ),
          )
      ),
    );
  }
}