import 'dart:io';

import 'package:colorsoul/Ui/Dashboard/NewOrder/location_page.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddDistributers extends StatefulWidget {
  @override
  _AddDistributersState createState() => _AddDistributersState();
}

class _AddDistributersState extends State<AddDistributers> {
  TextEditingController _textEditingController1 = new TextEditingController();
  TextEditingController _textEditingController2 = new TextEditingController();
  TimeOfDay time;
  DateTime _selectedstarttime = DateTime.now();
  bool isvisible = true;
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
            toolbarWidgetColor: AppColors.white
        )
    );
    setState(() {
      _image = File(cropped.path);
    });
  }

  @override
  void initState(){
    super.initState();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                            Navigator.pop(context);
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
                      child: Padding(
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
                                  Text(
                                    "Distributor Business Name",
                                    style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(height: height*0.01),
                                  TextFormField(
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
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
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
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
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage()));
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
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: height*0.02),
                                          Row(
                                            children: [
                                              Text(
                                                "Chandanvan society",
                                                style: textStyle.copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isvisible = false;
                                                    });
                                                  },
                                                  child: Image.asset("assets/images/productsdata/cancel.png",width: 10,height: 10)
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Image.asset("assets/images/locater/location4.png",width: 20,height: 20),
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
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
                                    ),
                                  ),
                                  SizedBox(height: height*0.01),
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
                                    keyboardType: TextInputType.number,
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
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
                                    keyboardType: TextInputType.number,
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
                                    ),
                                  ),
                                  SizedBox(height: height*0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
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
                                            width: width/2.4,
                                            child: TextField(
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
                                              controller: _textEditingController1,
                                              onTap: () {
                                                _pickTime();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "To",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "",
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            height: height*0.08,
                                            width: width/2.4,
                                            child: TextField(
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
                                              controller: _textEditingController2,
                                              onTap: () {
                                                _pickTime();
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height*0.01),
                                  Text(
                                    "Add Photos",
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
                                      height: _image==null ? 100 : 200,
                                      width: _image==null ? 100 : 200,
                                      decoration: BoxDecoration(
                                        borderRadius: round.copyWith(),
                                        border: _image==null ? Border.all(
                                          color: AppColors.black
                                        ) : null
                                      ),
                                      child: _image==null ? Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset("assets/images/distributors/scene1.png",width: 30,height: 30),
                                          SizedBox(height: 10),
                                          Text(
                                            "Select Photo",
                                            style: textStyle.copyWith(
                                              color: AppColors.black,
                                            ),
                                          )
                                        ],
                                      ) : Image.file(_image)
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
      if(_textEditingController1.text.isEmpty)
      {
        setState(() {
          time = t;
          _selectedstarttime = DateTime(0, 0, 0, t.hour, t.minute);
          String starttime = DateFormat("hh : mm a").format(_selectedstarttime);
          _textEditingController1 = TextEditingController(text: "$starttime");
        });
      }
      else
      {
        setState(() {
          time = t;
          _selectedstarttime = DateTime(0, 0, 0, t.hour, t.minute);
          String starttime = DateFormat("hh : mm a").format(_selectedstarttime);
          _textEditingController2 = TextEditingController(text: "$starttime");
        });
      }
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}