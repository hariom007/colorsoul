import 'dart:convert';
import 'dart:io';
import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Provider/feedback_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Distributers/feedback_page.dart';
import 'package:colorsoul/Ui/Dashboard/Edit_Distributor/edit_distributor.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'details.dart';
import 'package:http/http.dart' as http;


class Distributors extends StatefulWidget {
  @override
  _DistributorsState createState() => _DistributorsState();
}

class _DistributorsState extends State<Distributors> {

  File _image;
  final _picker = ImagePicker();
  Future getImage(ImageSource source,id) async {
    final XFile photo = await _picker.pickImage(source: source);
    File cropped = await ImageCropper.cropImage(
        sourcePath: photo.path,
        // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            toolbarWidgetColor: AppColors.white
        )
    );
    setState(() {
      _image = File(cropped.path);
    });
    sendImage(_image,id);
  }

  List imageUrls = [];

  dailogeMethod(){

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

  }

  sendImage(image,id) async {

    dailogeMethod();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "4ccda7514adc0f13595a585205fb9761"
    };

    final uri = 'https://colorsoul.koffeekodes.com/admin/Api/imageUpload';
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(headers);

    request.fields['folder'] = "feedback";
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    request.send().then((response) async {
      var res = await response.stream.bytesToString();
      print(res);
      var body = json.decode(res);

      if (response.statusCode == 200 && body['st'] == "success") {
        imageUrls.add(body['file']);

        addFeedback(id);
      }
      else{
        Navigator.pop(context);

        Fluttertoast.showToast(
            msg: "Image Upload Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    });

  }

  addFeedback(id) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    var data = {
      "uid":"$userId",
      "retailer_id":"$id",
      "image_url": imageUrls
    };

    print(data);

    await _feedBackProvider.insertFeedBack(data,'/add_feedbackimage_detail');

   Navigator.pop(context);
  }


  DistributorProvider _distributorProvider;
  FeedBackProvider _feedBackProvider;

  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();

    _distributorProvider = Provider.of<DistributorProvider>(context, listen: false);
    _feedBackProvider = Provider.of<FeedBackProvider>(context, listen: false);

    _distributorProvider.distributorList.clear();
    getDistributor();

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {

          setState(() {
            isScrollingDown = true;
          });
          setState(() {
            page = page + 1;
            getDistributor();
          });
        }
      }
    });


  }

  int page = 1;
  getDistributor() async {

    setState(() {
      isScrollingDown = true;
    });

    await _distributorProvider.getDistributor('/getDistributorRetailer/$page');

    setState(() {
      isScrollingDown = false;
    });

  }

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


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _distributorProvider = Provider.of<DistributorProvider>(context, listen: true);
    _feedBackProvider = Provider.of<FeedBackProvider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.black,
        body:Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Flesh2.png"),
                  fit: BoxFit.fill,
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.05),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Distributors & Retailers",
                    style: textStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: height*0.01),
                Expanded(
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (OverscrollIndicatorNotification overscroll) {
                              overscroll.disallowGlow();
                              return;
                            },
                            child: SingleChildScrollView(
                              controller: _scrollViewController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        top: 10,
                                    ),
                                    itemCount: _distributorProvider.distributorList.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var distributorData = _distributorProvider.distributorList[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: round1.copyWith()
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 5,bottom: 6),
                                              child:  ListTile(
                                                title: Text(
                                                  "${distributorData.businessName}",
                                                  style: textStyle.copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: height*0.012),
                                                    Row(
                                                      children: [
                                                        Image.asset("assets/images/tasks/location1.png",width: 15),
                                                        SizedBox(width: 10),
                                                        Flexible(
                                                          child: Text(
                                                            "${distributorData.address}",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: textStyle.copyWith(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                trailing: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [

                                                    InkWell(
                                                      onTap: () async {

                                                        Position position = await getGeoLocationPosition();

                                                        String url ='https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=${distributorData.latitude},${distributorData.longitude}&travelmode=driving&dir_action=navigate';
                                                        launch(url);


                                                      },
                                                      child: Column(
                                                        children: [
                                                          SizedBox(height: 5),
                                                          Image.asset("assets/images/locater/direction.png",width: 22),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            "Direction",
                                                            style: textStyle.copyWith(
                                                                fontWeight: FontWeight.bold,
                                                                color: AppColors.black
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(width: 5),

                                                    PopupMenuButton(
                                                        elevation: 2,
                                                        offset: Offset(3,-10),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: round1.copyWith()
                                                        ),
                                                        color: AppColors.grey1,
                                                        onSelected: (index) {
                                                          if(index==3)
                                                          {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage(
                                                              distributorId: distributorData.id,
                                                            )));
                                                          }
                                                          if(index==4)
                                                          {
                                                            var lat = distributorData.latitude;
                                                            var lon = distributorData.longitude;

                                                            if(distributorData.latitude == '' || distributorData.longitude == ''){
                                                              lat = '19.0760';
                                                              lon = '72.8777';
                                                            }


                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => EditDistributers(
                                                                  distributor_name: distributorData.businessName,
                                                                  distributor_address: distributorData.address,
                                                                  distributor_image: distributorData.image,
                                                                  distributor_gst: distributorData.gstNo,
                                                                  latitude: lat,
                                                                  longitude: lon,
                                                                  home_address: distributorData.homeAddress,
                                                                  landmark: distributorData.landmark,
                                                                  person_name: distributorData.name,
                                                                  person_mobile: distributorData.mobile,
                                                                  person_tel: distributorData.telephone,
                                                                  business_type: distributorData.businessType,
                                                                  opentime: "${distributorData.openTime}",
                                                                  closetime: "${distributorData.closeTime}",
                                                                  type: "${distributorData.type}",
                                                                  id: distributorData.id,
                                                                ))
                                                            );

                                                          }

                                                        },
                                                        child: Image.asset("assets/images/details/menu1.png",width: 24,height: 24,color: AppColors.black),
                                                        itemBuilder: (context) => [
                                                          PopupMenuItem(
                                                            onTap: () {
                                                              getImage(ImageSource.gallery,distributorData.id);
                                                            },
                                                            value: 1,
                                                            child: Row(
                                                              children: [
                                                                Image.asset("assets/images/notes/scene.png",width: 20,height: 20),
                                                                SizedBox(width: 10),
                                                                Text(
                                                                  "Add Image",
                                                                  style: textStyle.copyWith(
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem(
                                                            onTap: () {
                                                              getImage(ImageSource.camera,distributorData.id);
                                                            },
                                                            value: 2,
                                                            child: Row(
                                                              children: [
                                                                Image.asset("assets/images/notes/camera.png",width: 20,height: 20),
                                                                SizedBox(width: 10),
                                                                Text(
                                                                  "Take Photo",
                                                                  style: textStyle.copyWith(
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem(
                                                            value: 3,
                                                            child: Row(
                                                              children: [
                                                                Image.asset("assets/images/distributors/feedback.png",width: 21,height: 21),
                                                                SizedBox(width: 10),
                                                                Text(
                                                                  "Feedback",
                                                                  style: textStyle.copyWith(
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem(
                                                            value: 4,
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.edit,color: AppColors.black,size: 21,),
                                                                SizedBox(width: 10),
                                                                Text(
                                                                  "Edit",
                                                                  style: textStyle.copyWith(
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ]
                                                    )
                                                  ],
                                                ),
                                                onTap: () {

                                                  var lat = distributorData.latitude;
                                                  var lon = distributorData.longitude;

                                                  if(lat == "" || lat == null){
                                                    lat = "0.0";
                                                    lon = "0.0";
                                                  }

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => Details(
                                                        distributor_name: distributorData.businessName,
                                                        distributor_address: distributorData.address,
                                                        distributor_image: distributorData.image,
                                                        distributor_gst: distributorData.gstNo,
                                                        latitude: lat,
                                                        longitude: lon,
                                                        home_address:distributorData.homeAddress,
                                                        person_name: distributorData.name,
                                                        person_mobile: distributorData.mobile,
                                                        person_tel: distributorData.telephone,
                                                        business_type: distributorData.businessType,
                                                        time: "${distributorData.openTime} - ${distributorData.closeTime}",
                                                        opentime: "${distributorData.openTime}",
                                                        closetime: "${distributorData.closeTime}",
                                                        type: "${distributorData.type}",
                                                        id: "${distributorData.id}",
                                                      ))
                                                  );

                                                },
                                              ),
                                            )
                                        ),
                                      );
                                    },
                                  ),

                                  _distributorProvider.isLoaded == false
                                      ?
                                  Container(
                                    height: 100,
                                    child: Center(
                                        child: SpinKitThreeBounce(
                                          color: AppColors.black,
                                          size: 25.0,
                                        )
                                    ),
                                  )
                                      :
                                      SizedBox(),

                                  SizedBox(height: 40),

                                ],
                              ),
                            ),
                          )
                      ),
                    )
                )
              ],
            )
        )
    );
  }

}