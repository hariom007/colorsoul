import 'dart:convert';
import 'dart:io';

import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/location_page.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class TypeModel{
  String id;
  String name;
  String number;
  String business_name;

  TypeModel(this.id, this.name,this.business_name,this.number);
}

class AddDistributers extends StatefulWidget {
  @override
  _AddDistributersState createState() => _AddDistributersState();
}

class _AddDistributersState extends State<AddDistributers> {

  TextEditingController businessNameController = new TextEditingController();
  TextEditingController businessTypeController = new TextEditingController();
  TextEditingController businessGSTController = new TextEditingController();
  TextEditingController _openTimeController = new TextEditingController();
  TextEditingController _closeTimeController = new TextEditingController();
  TextEditingController _addressNoController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();

  TextEditingController _personNameController = new TextEditingController();
  TextEditingController _personMobileController = new TextEditingController();
  TextEditingController _personTelephoneController = new TextEditingController();

  String address = "",city = "",state = "",latitude = "0.0",logitude = "0.0",pincode = "";

  TimeOfDay time;
  DateTime _selectedstarttime = DateTime.now();
  bool isvisible = false;
  int selectValue = 1;

  File _image;
  final _picker = ImagePicker();
  Future getImage(ImageSource source) async {
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
            toolbarWidgetColor: AppColors.black
        )
    );
    setState(() {
      _image = File(cropped.path);
    });
  }

  DistributorProvider _distributorProvider;

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    _distributorProvider = Provider.of<DistributorProvider>(context, listen: false);

    getDistributor();

  }

  String imageUrl = "";

  sendImage() async {

    _distributorProvider.isLoaded == false;

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "4ccda7514adc0f13595a585205fb9761"
    };

    final uri = 'https://colorsoul.koffeekodes.com/admin/Api/imageUpload';
    var request = await http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(headers);

    if(_image != null){
      request.fields['folder'] = selectValue == 1 ? "distributor" : "retailer";
      request.files.add(await http.MultipartFile.fromPath('file', _image.path));

      request.send().then((response) async {
        var res = await response.stream.bytesToString();
        print(res);
        var body = json.decode(res);

        if (response.statusCode == 200 && body['st'] == "success") {
          imageUrl = body['file'];
          addDistributor();

        }
        else{
          print("Image Upload Error");
          addDistributor();
        }

      });

    }
    else{
      addDistributor();
    }

  }

  addDistributor() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    var data = {
      "uid":"$userId",
      "type": selectValue == 1 ? "Distributor" : "Retailer",
      "parent_id": selectValue == 1 ? "" : "$selectedDistributorId",
      "business_name":businessNameController.text,
      "business_type":"${businessTypeController.text}",
      "gst_no":"${businessGSTController.text}",
      "address":address,
      "home_address":_addressNoController.text,
      "landmark":_addressController.text,
      "city":city,
      "state":state,
      "pincode":"$pincode",
      "latitude":"$latitude",
      "longitude":"$logitude",
      "name":_personNameController.text,
      "mobile":_personMobileController.text,
      "telephone":"${_personTelephoneController.text}",
      "open_time":"${_openTimeController.text}",
      "close_time":"${_closeTimeController.text}",
      "image":"$imageUrl"
    };

    _distributorProvider.distributorList.clear();
    await _distributorProvider.insertDistributor(data,'/createDistributorRetailer');
    if(_distributorProvider.isSuccess == true){
      Navigator.pop(context,'Refresh');
    }

  }


  String selectedDistributor,selectedDistributorId;

  TypeModel distributorList;
  List<TypeModel> distributor_List = <TypeModel>[];

  getDistributor() async {

    var data = {
      "type":"Distributor"
    };

    _distributorProvider.onlyDistributorList.clear();
    await _distributorProvider.getOnlyDistributor(data,'/getDistributorRetailerByType');
    if(_distributorProvider.isSuccess == true){

      var result  = _distributorProvider.onlyDistributorList;

      var singleDistributor;

      for (var abc in result) {
        singleDistributor = TypeModel(abc.id,abc.name,abc.businessName,abc.mobile);
        distributor_List.add(singleDistributor);
      }
    }

  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _distributorProvider = Provider.of<DistributorProvider>(context, listen: true);

    return Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _distributorProvider.isLoaded == false
            ?
            SpinKitThreeBounce(
              color: AppColors.black,
              size: 25.0,
            )
                :
            Container(
                height: 70,
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child:SizedBox(
                      height: 50,
                      width: width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                            borderRadius: round.copyWith()
                        ),
                        child: ElevatedButton(
                          onPressed: () {

                            sendImage();

                            /*if(_formkey.currentState.validate()){

                              if(address == null){

                                Fluttertoast.showToast(
                                    msg: "Please Enter Address.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                              }
                              else{

                                if(selectValue == 2){

                                  if(selectedDistributorId == null){

                                    Fluttertoast.showToast(
                                        msg: "Please Select Distributor.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                  }
                                  else{
                                    sendImage();
                                  }

                                }
                                else{
                                  sendImage();
                                }

                              }
                            }*/
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: Colors.transparent,
                              shape: StadiumBorder()
                          ),
                          child: Text('Done',
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                  ),
                )
            )
          ]
        ),
        backgroundColor: AppColors.white,
        body:Form(
          key: _formkey,
          child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Flesh2.png"),
                    fit: BoxFit.fill,
                  )
              ),
              child: Column(
                children: [
                  SizedBox(height: height*0.05),
                  Padding(
                    padding: EdgeInsets.only(right: 20,left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Image.asset("assets/images/tasks/back.png",height: 16)
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Add new distributor/Retailer",
                            style: textStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.01),
                  Expanded(
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)
                            )
                        ),
                        child:

                        _distributorProvider.isDistributorLoaded == false
                            ?
                        Center(
                            child: SpinKitThreeBounce(
                              color: AppColors.black,
                              size: 25.0,
                            )
                        )
                            :
                        Padding(
                            padding: EdgeInsets.only(right: 20,left: 20),
                            child: NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (OverscrollIndicatorNotification overscroll) {
                                overscroll.disallowGlow();
                                return;
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: height*0.03),
                                    Text(
                                      "Select Type",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                    SizedBox(height: height*0.01),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectValue=1;
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            width: width/2.4,
                                            padding: EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(
                                                gradient:  selectValue==1 ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : null,
                                                border: selectValue==1 ? null : Border.all(color: AppColors.black),
                                                borderRadius: round.copyWith()
                                            ),
                                            child: Text('Distributor',
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                color:  selectValue==1 ? AppColors.white : AppColors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectValue=2;
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            width: width/2.4,
                                            padding: EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(
                                              gradient: selectValue==2 ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]) : null,
                                              borderRadius: round.copyWith(),
                                              border: selectValue==2 ? null : Border.all(color: AppColors.black)
                                            ),
                                            child: Text('Retailer',
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                color: selectValue==2 ? AppColors.white : AppColors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: height*0.02),


                                    selectValue == 1
                                        ?
                                    SizedBox()
                                    :
                                    Text(
                                      "Select Distributor",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),

                                    selectValue == 1
                                        ?
                                    SizedBox()
                                        :
                                    SizedBox(height: height*0.01),

                                    selectValue == 1
                                        ?
                                    SizedBox()
                                        :
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.black
                                          ),
                                          borderRadius: round,
                                        ),
                                        child: Listener(
                                          onPointerDown: (_) {
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: DropdownBelow<TypeModel>(
                                              itemWidth: width/1.3,
                                              isDense: true,
                                              itemTextstyle:textStyle.copyWith(
                                                fontSize: 16,
                                                color: AppColors.black,
                                              ),
                                              boxTextstyle: textStyle.copyWith(
                                                fontSize: 16,
                                                color: AppColors.black,
                                              ),
                                              boxWidth: width,
                                              boxHeight: 50,
                                              icon: Image.asset('assets/images/locater/down.png',width: 14),
                                              hint: Text('Select Distributor'),
                                              value: distributorList,
                                              onChanged: (TypeModel t){

                                                setState(()  {
                                                  distributorList = t;
                                                  print(t.id);
                                                  selectedDistributorId = t.id;
                                                  selectedDistributor = t.name;
                                                });

                                              },
                                              items: distributor_List.map((TypeModel t) {
                                                return DropdownMenuItem<TypeModel>(
                                                  value: t,
                                                  child: Text(
                                                      t.name != ''
                                                          ?
                                                      t.name
                                                          :
                                                      t.business_name != ''
                                                          ?
                                                      t.business_name
                                                          :
                                                      t.number

                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        )
                                    ),

                                    selectValue == 1
                                        ?
                                    SizedBox()
                                        :
                                    SizedBox(height: height*0.02),

                                    selectValue == 1
                                        ?
                                      Text(
                                        "Distributor Business Name",
                                        style: textStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      )
                                    :
                                      Text(
                                        "Retailer Business Name",
                                        style: textStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),

                                        SizedBox(height: height*0.01),
                                        TextFormField(
                                          controller: businessNameController,
                                          validator: (String value) {
                                            if(value.isEmpty)
                                            {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                          cursorHeight: 22,
                                          cursorColor: Colors.grey,
                                          decoration: fieldStyle1.copyWith(
                                              isDense: true,
                                            errorStyle: TextStyle(height: 0,fontSize: 0)
                                          ),
                                        ),
                                        SizedBox(height: height*0.02),
                                        Text(
                                          "Business Type",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),
                                        TextFormField(
                                          controller: businessTypeController,
                                          validator: (String value) {
                                            if(value.isEmpty)
                                            {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black,
                                          ),
                                          cursorHeight: 22,
                                          cursorColor: Colors.grey,
                                          decoration: fieldStyle1.copyWith(
                                              isDense: true,
                                              errorStyle: TextStyle(height: 0,fontSize: 0)
                                          ),
                                        ),
                                        SizedBox(height: height*0.02),
                                        Text(
                                          "Business GST No",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),
                                        TextFormField(
                                          controller: businessGSTController,
                                          validator: (String value) {
                                            if(value.isEmpty)
                                            {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                          cursorHeight: 22,
                                          cursorColor: Colors.grey,
                                          decoration: fieldStyle1.copyWith(
                                              isDense: true,
                                              errorStyle: TextStyle(height: 0,fontSize: 0)
                                          ),
                                        ),
                                        SizedBox(height: height*0.02),

                                    Text(
                                      "Flat no or House no",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                    SizedBox(height: height*0.01),
                                    TextFormField(
                                      controller: _addressNoController,
                                      keyboardType: TextInputType.number,
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),
                                      cursorHeight: 22,
                                      cursorColor: Colors.grey,
                                      decoration: fieldStyle1.copyWith(
                                          isDense: true,
                                          errorStyle: TextStyle(height: 0,fontSize: 0)
                                      ),
                                    ),
                                    SizedBox(height: height*0.02),

                                    Text(
                                      "Address",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                    SizedBox(height: height*0.01),
                                    TextFormField(
                                      controller: _addressController,
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),
                                      cursorHeight: 22,
                                      cursorColor: Colors.grey,
                                      decoration: fieldStyle1.copyWith(
                                          isDense: true,
                                          errorStyle: TextStyle(height: 0,fontSize: 0)
                                      ),
                                    ),
                                    SizedBox(height: height*0.02),


                                    Text(
                                          "Add Location",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),
                                        TextFormField(
                                            style: textStyle.copyWith(
                                                color: AppColors.black
                                            ),
                                            onTap: () async {

                                              final value = await Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage()));
                                              if(value != null){
                                                print(value);

                                                var fullAddress = value.split("/");
                                                address = fullAddress[0];
                                                city = fullAddress[1];
                                                state = fullAddress[2];
                                                pincode = "${fullAddress[3]}";
                                                latitude = fullAddress[4];
                                                logitude = fullAddress[5];

                                                setState(() {
                                                  isvisible = true;
                                                });
                                              }

                                            },
                                            cursorColor: AppColors.black,
                                            cursorHeight: 22,
                                            readOnly: true,
                                            decoration: fieldStyle1.copyWith(
                                                hintText: "Search Location",
                                                hintStyle: textStyle.copyWith(
                                                    color: AppColors.black
                                                ),
                                                prefixIcon: new IconButton(
                                                  icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                                  onPressed: null,
                                                ),
                                                isDense: true
                                            )
                                        ),
                                        Visibility(
                                          visible: isvisible,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10,right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: height*0.02),
                                                Row(
                                                  children: [
                                                    Image.asset("assets/images/locater/location4.png",width: 20,height: 20),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: Text(
                                                        "$address",
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: textStyle.copyWith(
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold,
                                                            height: 1.4
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            isvisible = false;
                                                            address = null;
                                                            logitude = null;
                                                            latitude = null;
                                                            pincode = null;
                                                          });
                                                        },
                                                        child: Image.asset("assets/images/productsdata/cancel.png",width: 10,height: 10)
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height*0.02),
                                        Text(
                                          "Person Name",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),
                                        TextFormField(
                                          controller: _personNameController,
                                          validator: (String value) {
                                            if(value.isEmpty)
                                            {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                          cursorHeight: 22,
                                          cursorColor: Colors.grey,
                                          decoration: fieldStyle1.copyWith(
                                              isDense: true,
                                              errorStyle: TextStyle(height: 0,fontSize: 0)
                                          ),
                                        ),
                                        SizedBox(height: height*0.02),
                                        Text(
                                          "Mobile Number",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),
                                        TextFormField(
                                          controller: _personMobileController,
                                          keyboardType: TextInputType.number,
                                          validator: (String value) {
                                            if(value.isEmpty)
                                            {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                          cursorHeight: 22,
                                          cursorColor: Colors.grey,
                                          decoration: fieldStyle1.copyWith(
                                              isDense: true,
                                              errorStyle: TextStyle(height: 0,fontSize: 0)
                                          ),
                                        ),
                                        SizedBox(height: height*0.02),
                                        Text(
                                          "Telephone Number",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),
                                        TextFormField(
                                          controller: _personTelephoneController,
                                          validator: (String value) {
                                            if(value.isEmpty)
                                            {
                                              return "";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                          cursorHeight: 22,
                                          cursorColor: Colors.grey,
                                          decoration: fieldStyle1.copyWith(
                                              isDense: true,
                                              errorStyle: TextStyle(height: 0,fontSize: 0)
                                          ),
                                        ),
                                        SizedBox(height: height*0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Time",
                                                    style: textStyle.copyWith(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  SizedBox(
                                                    height: height*0.08,
                                                    child: TextFormField(
                                                      validator: (String value) {
                                                        if(value.isEmpty)
                                                        {
                                                          return "";
                                                        }
                                                        return null;
                                                      },
                                                      decoration: fieldStyle1.copyWith(
                                                          prefixIcon: new IconButton(
                                                            icon: new Image.asset('assets/images/tasks/clock.png',width: 20,height: 20),
                                                            onPressed: null,
                                                          ),
                                                          hintText: "Open Time",
                                                          hintStyle: textStyle.copyWith(
                                                              color: Colors.black
                                                          ),
                                                          isDense: true
                                                      ),
                                                      textAlign: TextAlign.center,
                                                      style: textStyle.copyWith(
                                                          fontSize: 14,
                                                          color: Colors.black
                                                      ),
                                                      focusNode: AlwaysDisabledFocusNode(),
                                                      controller: _openTimeController,
                                                      onTap: () {
                                                        _pickTime();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "To",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "",
                                                  ),
                                                  SizedBox(height: 10),
                                                  SizedBox(
                                                    height: height*0.08,
                                                    child: TextFormField(
                                                      validator: (String value) {
                                                        if(value.isEmpty)
                                                        {
                                                          return "";
                                                        }
                                                        return null;
                                                      },
                                                      decoration: fieldStyle1.copyWith(
                                                          prefixIcon: new IconButton(
                                                            icon: new Image.asset('assets/images/tasks/clock.png',width: 20,height: 20),
                                                            onPressed: null,
                                                          ),
                                                          hintText: "Close Time",
                                                          hintStyle: textStyle.copyWith(
                                                              color: Colors.black
                                                          ),
                                                          isDense: true
                                                      ),
                                                      textAlign: TextAlign.center,
                                                      style: textStyle.copyWith(
                                                          fontSize: 14,
                                                          color: Colors.black
                                                      ),
                                                      focusNode: AlwaysDisabledFocusNode(),
                                                      controller: _closeTimeController,
                                                      onTap: () {
                                                        _pickTime();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: height*0.01),
                                        Text(
                                          "Add Photo",
                                          style: textStyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        SizedBox(height: height*0.01),
                                        InkWell(
                                          onTap: () {
                                            getImage(ImageSource.gallery);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: round.copyWith(),
                                              border: _image==null ? Border.all(
                                                color: AppColors.black
                                              ) : null
                                            ),
                                            child: _image==null
                                                ?
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Column(
                                                children: [
                                                  Image.asset("assets/images/distributors/scene1.png",width: 30,height: 30),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Select Photo",
                                                    style: textStyle.copyWith(
                                                      color: AppColors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                                :
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                                child: Image.file(_image,width: MediaQuery.of(context).size.width,fit: BoxFit.fill)
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ),

                      )
                      )
                ],
              )
          ),
        )
    );
  }

  _pickTime() async{
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: time,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.grey,
                onPrimary: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: AppColors.white,
            ),
            child: child,
          );
        }
    );

    if(t != null)
    {
      if(_openTimeController.text.isEmpty)
      {
        setState(() {
          time = t;
          _selectedstarttime = DateTime(0, 0, 0, t.hour, t.minute);
          String starttime = DateFormat("hh : mm a").format(_selectedstarttime);
          _openTimeController = TextEditingController(text: "$starttime");
        });
      }
      else
      {
        setState(() {
          time = t;
          _selectedstarttime = DateTime(0, 0, 0, t.hour, t.minute);
          String starttime = DateFormat("hh : mm a").format(_selectedstarttime);
          _closeTimeController = TextEditingController(text: "$starttime");
        });
      }
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}