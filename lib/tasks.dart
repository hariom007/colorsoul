import 'dart:ffi';
import 'package:colorsoul/components.dart';
import 'package:colorsoul/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'appColors.dart';
import 'location_card.dart';
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
            SizedBox(height: height*0.08),
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
                          child: Image.asset("assets/images/tasks/back.png",height: height*0.025)
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Create a New Task",
                      style: textStyle.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.04),
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
                            "Titles",
                            style: textStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                          SizedBox(height: height*0.02),
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
                          SizedBox(height: height*0.03),
                          Text(
                            "Description",
                            style: textStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          SizedBox(height: height*0.02),
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
                          SizedBox(height: height*0.03),
                          Text(
                            "Choose Start Date & Time",
                            style: textStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          SizedBox(height: height*0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              SizedBox(
                                height: height*0.08,
                                width: width/2.4,
                                child: TextField(
                                  decoration: fieldStyle1.copyWith(
                                    prefixIcon: new IconButton(
                                      icon: new Image.asset('assets/images/tasks/time.png',width: 20,height: 20),
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
                          SizedBox(height: height*0.02),
                          Text(
                            "Choose End Date & Time",
                            style: textStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          SizedBox(height: height*0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              SizedBox(
                                height: height*0.08,
                                width: width/2.4,
                                child: TextField(
                                  decoration: fieldStyle1.copyWith(
                                      prefixIcon: new IconButton(
                                        icon: new Image.asset('assets/images/tasks/time.png',width: 20,height: 20),
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
                          SizedBox(height: height*0.01),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Assignee & Location",
                                  style: textStyle.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 30,
                                  width: 38,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                        borderRadius: round.copyWith()
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        shadowColor: Color.fromRGBO(0,0,0,.3),
                                        primary: Colors.transparent,
                                        shape: StadiumBorder()
                                      ),
                                      child: Text('+',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            itemCount: LocationModel.location.length,
                            itemBuilder: (context, index){
                              return LocationCard(location: LocationModel.location[index]);
                            },
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