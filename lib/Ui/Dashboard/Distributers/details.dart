import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Values/appColors.dart';

class Details extends StatefulWidget {

  String distributor_name,distributor_address,distributor_image,latitude,longitude,
      person_name,person_mobile,person_tel,time,business_type;

  Details({Key key, this.distributor_name,this.distributor_address,this.distributor_image,this.latitude,this.longitude,
    this.person_name,this.person_mobile,this.person_tel,this.time,this.business_type
  }) : super(key: key);

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
              position: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
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
            "${widget.distributor_name}",
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
                        target: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
                        zoom: 15
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
                          '${widget.distributor_address}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle.copyWith(),
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

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
                                    "${widget.person_name}",
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
                                    "(+91) ${widget.person_mobile}",
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
                                    "0261 ${widget.person_tel}",
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
                                    "${widget.time}",
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
                                    "${widget.business_type}",
                                    style: textStyle.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: "${widget.distributor_image}",
                                  placeholder: (context, url) => Center(
                                      child: SpinKitThreeBounce(
                                        color: AppColors.black,
                                        size: 25.0,
                                      )
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
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

              ],
            ),
          ),
        )
    );
  }
}