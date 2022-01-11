import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                          "Feedback",
                          style: textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              width: 50,
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                  borderRadius: round1.copyWith(),
                                  boxShadow: [new BoxShadow(
                                    color: Color.fromRGBO(255, 255, 255, 0.15),
                                    offset: Offset(0, 5),
                                    blurRadius: 5,
                                  )]
                              ),
                              child: Image.asset("assets/images/notes/tick.png")
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
                                  TextFormField(
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Enter title",
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
                                        hintText: "Type text hear",
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
