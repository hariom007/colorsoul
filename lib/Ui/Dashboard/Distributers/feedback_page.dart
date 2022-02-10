import 'package:colorsoul/Provider/feedback_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackPage extends StatefulWidget {

  String distributorId;
  FeedbackPage({Key key,this.distributorId}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  FeedBackProvider _feedBackProvider;

  @override
  void initState() {
    super.initState();
    _feedBackProvider = Provider.of<FeedBackProvider>(context, listen: false);
  }

  addFeedback() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    var data = {
      "uid":"$userId",
      "title":"${titleController.text}",
      "retailer_id":"${widget.distributorId}",
      "feedback_detail":"${feedbackController.text}"
    };

    print(data);

    _feedBackProvider.feedBackList.clear();
    await _feedBackProvider.insertFeedBack(data,'/add_feedback_detail');
    if(_feedBackProvider.isSuccess == true){
      Navigator.pop(context,'Refresh');
    }

  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _feedBackProvider = Provider.of<FeedBackProvider>(context, listen: true);

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

                        _feedBackProvider.isLoaded == false
                            ?
                        SpinKitThreeBounce(
                          color: AppColors.white,
                          size: 25.0,
                        )
                            :
                        InkWell(
                          onTap: () {

                            addFeedback();
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
                                    controller: titleController,
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
                                    controller: feedbackController,
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
