import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  TextEditingController _textEditingController1 = new TextEditingController();
  TextEditingController _textEditingController2 = new TextEditingController();
  DateTime _selectedDate;
  TimeOfDay time;
  DateTime _selectedstarttime = DateTime.now();

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
                      "Create To Do",
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
                            "Title",
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
                            "Description",
                            style: textStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                          SizedBox(height: height*0.01),
                          TextFormField(
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
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
                            "Add Catagory name",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
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
                                          icon: new Image.asset('assets/images/tasks/donedate.png',width: 20,height: 20),
                                          onPressed: null,
                                        ),
                                        hintText: "Select Date",
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
                                        _selecttDate(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                                        hintText: "Select Time",
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
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          SizedBox(
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
                          SizedBox(height: height*0.02),
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

  _selecttDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2100),
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

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      initializeDateFormatting('es');
      _textEditingController1
        ..text = DateFormat.yMd('es').format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController1.text.length,
            affinity: TextAffinity.upstream
        )
      );
    }
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
      setState(() {
        time = t;
        _selectedstarttime = DateTime(0,0,0,t.hour,t.minute);
        String starttime = DateFormat("hh : mm a").format(_selectedstarttime);
        _textEditingController2 = TextEditingController(text: "$starttime");
      });
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}