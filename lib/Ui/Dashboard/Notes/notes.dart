import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
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
                        SizedBox(
                            height: 40,
                            width: 50,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                  borderRadius: round.copyWith(),
                                  boxShadow: [new BoxShadow(
                                    color: Color.fromRGBO(255,255,255,0.2),
                                    offset: Offset(0, 5),
                                    blurRadius: 5,
                                  ),
                                ]
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      primary: Colors.transparent,
                                      shape: StadiumBorder()
                                  ),
                                  child: Image.asset("assets/images/notes/tick.png",width: 18,height: 18)
                              ),
                            )
                        )
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
                                  TextFormField(
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
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Note",
                                        hintStyle: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.black,
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
