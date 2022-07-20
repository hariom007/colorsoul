import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Provider/feedback_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Edit_Distributor/edit_distributor.dart';
import 'package:colorsoul/Ui/Dashboard/Products/preview.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Values/appColors.dart';

class Details extends StatefulWidget {

  String id;

  Details({Key key, this.id}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  void setCustomMarker() async{
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/locater/location4.png');
  }

  void _onMapCreated(GoogleMapController controller){
    setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId('1'),
              position: LatLng(double.parse(latitude), double.parse(longitude)),
              icon: mapMarker
          )
      );
    });
  }

  Future<Position> getGeoLocationPosition() async {

    setState(() {
     _distributorProvider.isCheckLoading = true;
    });

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

  FeedBackProvider _feedBackProvider;

  DistributorProvider _distributorProvider;


  @override
  void initState() {
    super.initState();

    _feedBackProvider = Provider.of<FeedBackProvider>(context, listen: false);
    _distributorProvider = Provider.of<DistributorProvider>(context, listen: false);

    getFeedback();
    setCustomMarker();
    getDistributorDetails();
  }

  int page = 1;
  getFeedback() async {

    setState(() {
      _feedBackProvider.feedBackList.clear();
      _feedBackProvider.imageFeedBackList.clear();
    });

    var data = {
      "retailer_id":"${widget.id}",
    };

    await _feedBackProvider.getFeedBack(data,'/getFeedback/$page');
    await _feedBackProvider.getImageFeedBack(data,'/getFeedbackimage/$page');

  }

  String name;

  String distributor_name,
      distributor_address,
      latitude = "19.0760",
      longitude = "72.8777",
      home_address,
      distributor_gst,
      landmark,
      city,
      state,
      person_name,
      person_mobile,
      person_tel,
      time,
      business_type,
      opentime,
      closetime,
      type;

  List distributor_image;

  getDistributorDetails() async {

    var data = {
      "id":"${widget.id}",
    };

    await _distributorProvider.getDistributorDetails(data, "/get_distributer_detail");


    distributor_name = _distributorProvider.distributorData['business_name'];
    distributor_address = _distributorProvider.distributorData['address'];
    distributor_image = _distributorProvider.distributorData['image'] == "" ? [] : _distributorProvider.distributorData['image'];
    distributor_gst = _distributorProvider.distributorData['gst_no'];
    latitude = _distributorProvider.distributorData['latitude'];
    longitude = _distributorProvider.distributorData['longitude'];
    home_address = _distributorProvider.distributorData['home_address'];
    person_name = _distributorProvider.distributorData['name'];
    person_mobile = _distributorProvider.distributorData['mobile'];
    person_tel = _distributorProvider.distributorData['telephone'];
    business_type = _distributorProvider.distributorData['business_type'];
    time = "${_distributorProvider.distributorData['open_time']} - ${_distributorProvider.distributorData['close_time']}";
    opentime = "${_distributorProvider.distributorData['open_time']}";
    closetime = "${_distributorProvider.distributorData['close_time']}";
    type = "${_distributorProvider.distributorData['business_type']}";
    city = "${_distributorProvider.distributorData['city']}";
    state = "${_distributorProvider.distributorData['state']}";

    //print("long $longitude");
    //print("lat $latitude");

  }

  bool isShowCheck = true;
  getRetailerCheckIn(String lat,String long,String address,String city,String state) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
        "r_id": "${widget.id}",
        "user_id": userId,
        "name": "$distributor_name",
        "address": "$address",
        "city":"$city",
        "state":"$state",
        "in_lat": "$lat",
        "in_long": "$long",
        "out_lat": "$lat",
        "out_long": "$long",
        "type": "in"
    };

    await _distributorProvider.getRetailerCheckIn(data, "/salesman_log");
    if(_distributorProvider.isCheckIn == true){
      setState(() {
        isShowCheck = false;
      });
    }

  }

  Future<void> getAddressFromLatLong(Position position)async {
    final coordinates = new Coordinates(position.latitude, position.longitude);

    var fullAddress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = fullAddress.first;

    String finalAddress = "${first.addressLine},${first.locality},${first.subAdminArea},${first.adminArea},${first.postalCode}";

    //print(first.adminArea);
   getRetailerCheckIn("${position.latitude}","${position.longitude}","$finalAddress","${first.subAdminArea}","${first.adminArea}");

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _feedBackProvider = Provider.of<FeedBackProvider>(context, listen: true);
    _distributorProvider = Provider.of<DistributorProvider>(context, listen: true);

    return
      _distributorProvider.isDistributorDataLoaded == false
          ?
      Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child:  SpinKitThreeBounce(
            color: AppColors.white,
            size: 25.0,
          ),
        ),
      )
      :
      Scaffold(
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
            "${distributor_name}",
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),
          actions: [

            isShowCheck == false
                ?
            SizedBox()
                :
            _distributorProvider.isCheckLoading == true
                ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: AppColors.white),
            )
                :
            InkWell(
              onTap: () async {

                Position position = await getGeoLocationPosition();
                getAddressFromLatLong(position);

              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Text(
                      "Check In",
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () async {
                  var lat = latitude;
                  var lon = longitude;

                  if(latitude == '' || longitude == ''){
                    lat = '19.0760';
                    lon = '72.8777';
                  }

                  final value = await  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditDistributers(
                        distributor_name: "${distributor_name}",
                        distributor_address: "${distributor_address}",
                        distributor_image: distributor_image,
                        latitude: lat,
                        longitude: lon,
                        person_name: "${person_name}",
                        home_address: "${home_address}",
                        landmark: "${landmark}",
                        person_mobile: "${person_mobile}",
                        person_tel: "${person_tel}",
                        business_type: "${business_type}",
                        distributor_gst: "${distributor_gst}",
                        opentime: "${opentime}",
                        closetime: "${closetime}",
                        type: "${type}",
                        id: "${widget.id}",
                        state: "${state}",
                        city:"${city}"
                      ))
                  );

                  if(value != null){
                    getDistributorDetails();
                  }

                },
                  child: Icon(Icons.edit,color: AppColors.white,size: 23,)
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
                        target: LatLng(
                            latitude == null || latitude == "" || latitude == "null"
                            ?
                            19.0760
                                :
                            double.parse(latitude),
                            longitude == null || longitude == "" || longitude == "null"
                                ?
                            72.8777
                            :
                            double.parse(longitude)
                            // double.parse(widget.latitude) == null ? 19.0760 : double.parse(widget.latitude),
                            // double.parse(widget.longitude) == null ? 72.8777 : double.parse(widget.longitude)
                        ),
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
                          '${distributor_address}',
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
                          padding: EdgeInsets.only(left: 20,right: 20),
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
                                    "${person_name}",
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
                                    "(+91) ${person_mobile}",
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
                                    "0261 ${person_tel}",
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
                                    "${time}",
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
                                    "${business_type}",
                                    style: textStyle.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),

                              StaggeredGridView.countBuilder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: distributor_image.length,
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.fit(1);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: "${distributor_image[index]}",
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
                                  );
                                },

                              ),



                              SizedBox(height: 20),

                              _feedBackProvider.imageFeedBackList.length == 0 && _feedBackProvider.feedBackList.length == 0
                              ?
                                  SizedBox()
                              :
                              Text(
                                "Feedbacks",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),

                              SizedBox(height: 15),

                              _feedBackProvider.isLoaded == false
                                  ?
                              SizedBox(
                                height: 70,
                                child: SpinKitThreeBounce(
                                  color: AppColors.black,
                                  size: 25.0,
                                ),
                              )
                                  :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      _feedBackProvider.imageFeedBackList.length != 0
                                      ?
                                      Expanded(
                                          child:  InkWell(
                                            onTap: (){

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Preview(
                                                    imgname: "${_feedBackProvider.imageFeedBackList[0]}",
                                                  ))
                                              );

                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: "${_feedBackProvider.imageFeedBackList[0]}",
                                                placeholder: (context, url) => Center(
                                                    child: SpinKitThreeBounce(
                                                      color: AppColors.black,
                                                      size: 25.0,
                                                    )
                                                ),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          )
                                      ):
                                          SizedBox(),

                                      SizedBox(width: 10),

                                      _feedBackProvider.imageFeedBackList.length > 1
                                          ?
                                      Expanded(
                                          child:  InkWell(
                                            onTap: (){

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Preview(
                                                    imgname: "${_feedBackProvider.imageFeedBackList[1]}",
                                                  ))
                                              );

                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: "${_feedBackProvider.imageFeedBackList[1]}",
                                                placeholder: (context, url) => Center(
                                                    child: SpinKitThreeBounce(
                                                      color: AppColors.black,
                                                      size: 25.0,
                                                    )
                                                ),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          )
                                      )
                                          :
                                      SizedBox(),

                                      SizedBox(width: 10),

                                      _feedBackProvider.imageFeedBackList.length > 2
                                          ?
                                      Expanded(
                                          child:  InkWell(
                                            onTap: (){

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Preview(
                                                    imgname: "${_feedBackProvider.imageFeedBackList[2]}",
                                                  ))
                                              );

                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: "${_feedBackProvider.imageFeedBackList[2]}",
                                                placeholder: (context, url) => Center(
                                                    child: SpinKitThreeBounce(
                                                      color: AppColors.black,
                                                      size: 25.0,
                                                    )
                                                ),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          )
                                      )
                                          :
                                      SizedBox(),


                                    ],
                                  ),

                                  SizedBox(height: 15),

                                  ListView.builder(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    itemCount: _feedBackProvider.feedBackList.length > 3 ? 3 : _feedBackProvider.feedBackList.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var allFeedback = _feedBackProvider.feedBackList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(40, 15, 20, 15),
                                                width: width/1.2,
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
                                                        "${allFeedback.title}",
                                                        style: textStyle.copyWith(
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "${allFeedback.feedbackDetail}",
                                                        maxLines: 3,
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
                                      );
                                    },
                                  ),

                                ],
                              ),

                              SizedBox(
                                  height: 50,
                                  width: width-30,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                        borderRadius: round.copyWith()
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {

                                        Position position = await getGeoLocationPosition();

                                        String url ='https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=${latitude},${longitude}&travelmode=driving&dir_action=navigate';
                                        launch(url);

                                      },
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