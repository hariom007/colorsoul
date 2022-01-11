import 'dart:io';
import 'package:colorsoul/Ui/Dashboard/Distributers/feedback_page.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'details.dart';

class Distributors extends StatefulWidget {
  @override
  _DistributorsState createState() => _DistributorsState();
}

class _DistributorsState extends State<Distributors> {

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
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                    "Distributors",
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
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 10,bottom: 40),
                              itemCount: 10,
                              shrinkWrap: true,
                              itemBuilder:(context, index){
                                return buildCard(height,index);
                              },
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

  Widget buildCard(double height,int index) {
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
                "Shoppers Stop",
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
                          "Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)",
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
                  Column(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                      }
                    },
                    child: Image.asset("assets/images/details/menu1.png",width: 24,height: 24,color: AppColors.black),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          getImage(ImageSource.gallery);
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
                          getImage(ImageSource.camera);
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
                      )
                    ]
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details()
                  )
                );
              },
            ),
          )
      ),
    );
  }

}