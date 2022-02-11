import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

  }

  TextEditingController nameController = TextEditingController();
  TextEditingController addressCotroller = TextEditingController();

  String name,email,mobileNumber,address,image;
  getData() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString("name");
    email = sharedPreferences.getString("email");
    mobileNumber = sharedPreferences.getString("mobile");
    address = sharedPreferences.getString("address");
    image = sharedPreferences.getString("image");

    nameController = TextEditingController(text: name);
    addressCotroller = TextEditingController(text: address);

  }


  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height,
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

                              setState(() {
                                isEdit = false;
                              });

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
                          onPressed: () {


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



                                },
                                child: Image.asset("assets/images/notes/edit.png",width: 20,height: 20,color: AppColors.white,)
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
