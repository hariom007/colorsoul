import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Provider/note_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AddNotes extends StatefulWidget {
  const AddNotes({Key key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  bool isVisible = false;
  String selectedColor = "FFFFFF";

  Future getImage(ImageSource source) async {
    File _image;
    final _picker = ImagePicker();

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
      sendImage(_image);
    });
  }

  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteController = TextEditingController();


  List imageUrls = [];
  bool isUploaded = true;
  sendImage(image) async {

    setState(() {
      isUploaded = false;
    });

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "4ccda7514adc0f13595a585205fb9761"
    };

    final uri = 'https://colorsoul.koffeekodes.com/admin/Api/imageUpload';
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(headers);

      request.fields['folder'] = "note";
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      request.send().then((response) async {
        var res = await response.stream.bytesToString();
        print(res);
        var body = json.decode(res);

        if (response.statusCode == 200 && body['st'] == "success") {
          imageUrls.add(body['file']);
        }
        else{
          print("Image Upload Error");
        }

        setState(() {
          isUploaded = true;
        });

      });

  }

  addNote() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    var data = {
      "id":"",
      "uid":"$userId",
      "title":"${noteTitleController.text}",
      "note":"${noteController.text}",
      "color_code":"#$selectedColor",
      "image_url": imageUrls
    };

    print(data);

    _noteProvider.noteList.clear();
    await _noteProvider.insertNote(data,'/createNote');
    if(_noteProvider.isSuccess == true){
      Navigator.pop(context,'Refresh');
    }

  }

  NoteProvider _noteProvider;

  @override
  void initState() {
    super.initState();
    _noteProvider = Provider.of<NoteProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _noteProvider = Provider.of<NoteProvider>(context, listen: true);

    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: isVisible,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "FFFFFF";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 0.5,
                                  color: AppColors.black
                                )
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "8DF8FF";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.blue4,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "AEFFF5";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.blue1,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "ADC9FF";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.blue2,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "F7ACD2";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.pink1,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "FF86EC";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.pink2,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "D5FF7C";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.green1,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "76FFAD";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.green2,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "8DF8FF";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.blue4,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "AC79FF";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.purple,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "FFED90";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.gold,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectedColor = "FFCB7C";
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: Color.fromRGBO(185, 185, 185, 0.75),
                  thickness: 2,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 5),
                    PopupMenuButton(
                      elevation: 2,
                      offset: Offset(-3,-3),
                      shape: RoundedRectangleBorder(
                          borderRadius: round1.copyWith()
                      ),
                      color: AppColors.grey1,
                      child: Image.asset("assets/images/notes/add1.png",width: 24,height: 24),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            getImage(ImageSource.gallery);
                          },
                          value: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("assets/images/notes/scene.png",width: 20,height: 20),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("assets/images/notes/camera.png",width: 20,height: 20),
                              Text(
                                "Take Photo",
                                style: textStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isVisible =! isVisible;
                        });
                      },
                      child: Image.asset("assets/images/notes/paint.png",width: 24,height: 24)
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 160,
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/notes/bin1.png",width: 20,height: 20),
                                      SizedBox(width: 10),
                                      Text(
                                        "Delete",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset("assets/images/notes/copy.png",width: 18,height: 18),
                                      SizedBox(width: 10),
                                      Text(
                                        "Make a Copy",
                                        style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/notes/share.png",width: 19,height: 19),
                                        SizedBox(width: 10),
                                        Text(
                                          "Send",
                                          style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Image.asset("assets/images/details/menu1.png",width: 20,height: 20,color: AppColors.black)
                    ),
                    SizedBox(width: 5),
                  ],
                ),

                _noteProvider.isLoaded == false || isUploaded == false
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
                      padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                      child:SizedBox(
                          height: 50,
                          width: width,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                borderRadius: round.copyWith()
                            ),
                            child: ElevatedButton(
                              onPressed: () async {

                                addNote();

                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: Colors.transparent,
                                  shape: StadiumBorder()
                              ),
                              child: Text('Add Note',
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
        ),
        backgroundColor: Colors.white,
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
                          "Add Note",
                          style: textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Expanded(child: Container()),
                        Image.asset("assets/images/notes/attach.png",width: 20,height: 20),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.01),
                Expanded(
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: HexColor(selectedColor),
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
                                  TextFormField(
                                    controller: noteTitleController,
                                    style: textStyle.copyWith(
                                      fontSize: 16,
                                      color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter Note’s title",
                                      hintStyle: textStyle.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.black,
                                  ),
                                  TextFormField(
                                    controller: noteController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Note",
                                        hintStyle: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.black,
                                  ),

                                  SizedBox(height: 30),

                                  StaggeredGridView.countBuilder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 15,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: imageUrls.length,
                                    staggeredTileBuilder: (index) {
                                      return StaggeredTile.fit(1);
                                    },
                                    itemBuilder: (BuildContext context, int index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitWidth,
                                          imageUrl: "${imageUrls[index]}",
                                          placeholder: (context, url) =>
                                              Center(
                                                child: SpinKitThreeBounce(
                                                  color: AppColors.black,
                                                  size: 25.0,
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                                child: Icon(Icons.error),
                                              ),
                                        ),
                                      );
                                    },

                                  ),

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
