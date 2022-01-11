import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Values/appColors.dart';

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
            padding: EdgeInsets.all(20),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset("assets/images/tasks/back.png")
            ),
          ),
          title: Text(
            "Be Shoppers Stop",
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                  onTap: (){},
                  child: Image.asset("assets/images/details/menu1.png",height: 20)
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
                    child: Row(
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
                              "Person Name",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Sagar Sham",
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
                              "Tel.",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "0261 66622616",
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
                              "Store Timings",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "9:00 AM - 10:00 PM",
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
                              "Bussiness Type",
                              style: textStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Cosmetic Shop",
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
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(40, 10, 20, 10),
                                width: width/1.2,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: round.copyWith(),
                                  border: Border.all(
                                      color: AppColors.black
                                  )
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Good Storage",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        "sit amet, consectetur adipiscing elit. Tellus odio tincidunt lacus lorem mi arcu quisque risus. Etiam malesuada justo sem donec malesuada et. ",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                width: 50,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                    borderRadius: round2.copyWith()
                                ),
                                child: Image.asset("assets/images/locater/message.png"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(40, 10, 20, 10),
                                width: width/1.2,
                                height: 110,
                                decoration: BoxDecoration(
                                    borderRadius: round.copyWith(),
                                    border: Border.all(
                                        color: AppColors.black
                                    )
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Good Storage",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        "sit amet, consectetur adipiscing elit. Tellus odio tincidunt lacus lorem mi arcu quisque risus. Etiam malesuada justo sem donec malesuada et. ",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                width: 50,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                    borderRadius: round2.copyWith()
                                ),
                                child: Image.asset("assets/images/locater/message.png"),
                              ),
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