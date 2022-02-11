import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Provider/auth_provider.dart';
import 'package:colorsoul/Ui/Login/login.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Values/components.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isNotification = true;
  bool isEmail = true;
  bool isBiometric = true;

  AuthProvider _authProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    getData();

  }

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String id,name,email,mobileNumber,address,image;
  getData() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      id = sharedPreferences.getString("userId");
      name = sharedPreferences.getString("name");
      email = sharedPreferences.getString("email");
      mobileNumber = sharedPreferences.getString("mobile");
      address = sharedPreferences.getString("address");
      image = sharedPreferences.getString("image");

      nameController = TextEditingController(text: name);
      addressController = TextEditingController(text: address);
    });

  }

  dailogeMethod(){

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.only(left: 0,right: 0),
          insetPadding: EdgeInsets.zero,
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
    sendImage(_image);
  }

  sendImage(file) async {

    dailogeMethod();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "4ccda7514adc0f13595a585205fb9761"
    };

    final uri = 'https://colorsoul.koffeekodes.com/admin/Api/imageUpload';
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(headers);

    request.fields['folder'] = "profile";
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    request.send().then((response) async {
      var res = await response.stream.bytesToString();
      print(res);
      var body = json.decode(res);

      if (response.statusCode == 200 && body['st'] == "success") {
        image = body['file'];

        Navigator.pop(context);
        editMethod();
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

  editMethod() async {

    dailogeMethod();

    var data = {

      "sales_id": "$id",
      "sales_name": "${nameController.text}",
      "sales_address": "${addressController.text}",
      "image": "$image"

    };

    await _authProvider.editProfile(data,'/update_profile');
    if(_authProvider.isSuccess == true){

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      print(_authProvider.editData);
      var body = _authProvider.editData['data'];
      sharedPreferences.setString('name', '${body['sales_name']}');
      sharedPreferences.setString('address', '${body['sales_address']}');
      sharedPreferences.setString('image', '${body['image']}');

      Navigator.pop(context);
      getData();

      setState(() {
        isEdit = false;
      });

    }
  }


  bool isEdit = false;

  @override
  Widget build(BuildContext context) {

    _authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Rectangle17.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
              height: MediaQuery.of(context).size.height+30,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: AppColors.black
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 80,bottom: 30,left: 20,right: 20),
                        child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image.asset("assets/images/tasks/back.png",width: 20,height: 20,)
                        ),
                      ),

                      Expanded(child: SizedBox()),

                      isEdit == true
                          ?
                      Padding(
                        padding: EdgeInsets.only(top: 75,bottom: 25,left: 20,right: 20),
                        child: InkWell(
                            onTap: (){

                             editMethod();

                            },
                            child: Icon(Icons.check,size: 27,color: AppColors.white)
                        ),
                      )
                      :
                      Padding(
                        padding: EdgeInsets.only(top: 80,bottom: 30,left: 20,right: 20),
                        child: InkWell(
                            onTap: (){

                              setState(() {
                                isEdit = true;
                              });

                            },
                            child: Image.asset("assets/images/notes/edit.png",width: 20,height: 20,color: AppColors.white,)
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Center(
                    child: Column(
                      children: [

                        isEdit == true
                            ?
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 10,bottom: 15,top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  center: Alignment.topLeft,
                                  focal: Alignment.centerLeft,
                                  radius: 4,
                                  colors: [
                                    AppColors.grey2,
                                    AppColors.grey4,
                                    AppColors.grey2,
                                  ],
                                ),
                                borderRadius: round.copyWith(),
                                boxShadow: [new BoxShadow(
                                  color: Color.fromRGBO(0,0,0, 0.2),
                                  offset: Offset(0, 5),
                                  blurRadius: 5,
                                )
                                ]
                            ),
                            child: TextFormField(
                                controller: nameController,
                                style: textStyle.copyWith(
                                    color: AppColors.black
                                ),
                                cursorColor: AppColors.black,
                                textAlign: TextAlign.center,
                                decoration: fieldStyle3.copyWith(
                                  errorStyle: TextStyle(height: 0),
                                  hintText: "Enter Your Name",
                                  hintStyle: textStyle.copyWith(
                                      color: AppColors.black
                                  ),
                                  isDense: true,
                                ),
                            ),
                          ),
                        )
                        :
                        Text(
                          "Hii ${name}",
                          style: textStyle.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            color: AppColors.black
                          ),
                        ),

                        Text(
                            "$mobileNumber",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Divider(
                  color: AppColors.grey2,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: Row(
                    children: [

                      Image.asset("assets/images/profile_icon.png",width: 25,height: 25,),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "Account info",
                          style: textStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black
                          ),
                        ),
                      ),

                      Image.asset("assets/images/down_icon.png",width: 15,height: 15,)


                    ],
                  ),
                ),

                Divider(
                  color: AppColors.grey2,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                            "Mobile Number",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),
                      ),

                      Text(
                          "$mobileNumber",
                          style: textStyle.copyWith(
                              fontSize: 15,
                              color: AppColors.black,
                            fontWeight: FontWeight.bold
                          )
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                            "Email Id",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),
                      ),

                      Text(
                          "$email",
                          style: textStyle.copyWith(
                              fontSize: 15,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold
                          )
                      ),

                    ],
                  ),
                ),

                isEdit == true
                ?
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10,bottom: 15,top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          focal: Alignment.centerLeft,
                          radius: 4,
                          colors: [
                            AppColors.grey2,
                            AppColors.grey4,
                            AppColors.grey2,
                          ],
                        ),
                        borderRadius: round.copyWith(),
                        boxShadow: [new BoxShadow(
                          color: Color.fromRGBO(0,0,0, 0.2),
                          offset: Offset(0, 5),
                          blurRadius: 5,
                        )
                        ]
                    ),
                    child: TextFormField(
                      controller: addressController,
                      style: textStyle.copyWith(
                          color: AppColors.black
                      ),
                      cursorColor: AppColors.black,
                      textAlign: TextAlign.center,
                      decoration: fieldStyle3.copyWith(
                        errorStyle: TextStyle(height: 0),
                        hintText: "Enter Your Name",
                        hintStyle: textStyle.copyWith(
                            color: AppColors.black
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                )
                :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                            "Address",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),
                      ),

                      SizedBox(width: 30),

                      Text(
                          "$address",
                          style: textStyle.copyWith(
                              fontSize: 15,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold
                          )
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 10),

                Divider(
                  color: AppColors.grey2,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: Row(
                    children: [

                      Image.asset("assets/images/bell.png",width: 25,height: 25,color: AppColors.black),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "Notification",
                          style: textStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black
                          ),
                        ),
                      ),

                      Image.asset("assets/images/down_icon.png",width: 15,height: 15,)


                    ],
                  ),
                ),

                Divider(
                  color: AppColors.grey2,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                            "App Notification",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),
                      ),

                      Switch(
                        onChanged: (value){
                          setState(() {
                          isNotification = value;
                          });
                        },
                        value: isNotification,
                        activeColor: AppColors.black,
                        activeTrackColor: AppColors.grey1,
                        inactiveThumbColor: AppColors.grey1,
                        inactiveTrackColor: AppColors.black,
                      )

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                            "Email Notification",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),
                      ),

                      Switch(
                        onChanged: (value){
                          setState(() {
                            isEmail = value;
                          });
                        },
                        value: isEmail,
                        activeColor: AppColors.black,
                        activeTrackColor: AppColors.grey1,
                        inactiveThumbColor: AppColors.grey1,
                        inactiveTrackColor: AppColors.black,
                      )

                    ],
                  ),
                ),

                SizedBox(height: 10),

                Divider(
                  color: AppColors.grey2,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: Row(
                    children: [

                      Image.asset("assets/images/setting_icon.png",width: 25,height: 25,color: AppColors.black),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "Setting",
                          style: textStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black
                          ),
                        ),
                      ),

                      Image.asset("assets/images/down_icon.png",width: 15,height: 15,)


                    ],
                  ),
                ),

                Divider(
                  color: AppColors.grey2,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                            "Change Password",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                            "Enables biometric access",
                            style: textStyle.copyWith(
                                fontSize: 15,
                                color: AppColors.black
                            )
                        ),
                      ),

                      Switch(
                        onChanged: (value){
                          setState(() {
                            isBiometric = value;
                          });
                        },
                        value: isBiometric,
                        activeColor: AppColors.black,
                        activeTrackColor: AppColors.grey1,
                        inactiveThumbColor: AppColors.grey1,
                        inactiveTrackColor: AppColors.black,
                      )

                    ],
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width-60,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                            borderRadius: round.copyWith()
                        ),
                        child: ElevatedButton(
                          onPressed: () async {

                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            sharedPreferences.clear();

                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));


                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: Colors.transparent,
                              shape: StadiumBorder()
                          ),
                          child: Text('Logout',
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                  ),
                ),

                SizedBox(height: 20),

              ],
            ),

            Column(
              children: [

                SizedBox(height: 70),

                Center(
                  child: Stack(
                    children: [

                      DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [AppColors.grey1,AppColors.grey2]
                            ),
                          borderRadius: BorderRadius.circular(300),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: CachedNetworkImage(
                              imageUrl: "$image",
                              placeholder: (context, url) => SpinKitThreeBounce(
                                color: AppColors.black,
                                size: 25.0,
                              ),
                              errorWidget: (context, url, error) => Image.asset("assets/images/profile.png"),
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                          ),
                            color: AppColors.black
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){

                                  getImage(ImageSource.gallery);

                                },
                                child: Image.asset("assets/images/notes/camera.png",width: 20,height: 20,color: AppColors.white,)
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            )


          ],
        ),
      ),
    );
  }
}
