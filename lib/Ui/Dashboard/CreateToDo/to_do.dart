import 'package:colorsoul/Provider/todo_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key key}) : super(key: key);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  TextEditingController _textEditingController1 = new TextEditingController();
  TextEditingController _textEditingController2 = new TextEditingController();
  DateTime _selectedDate;
  TimeOfDay time = TimeOfDay.now();
  DateTime _selectedstarttime = DateTime.now();

  TodoProvider _todoProvider;

  @override
  void initState(){
    super.initState();

    _todoProvider = Provider.of<TodoProvider>(context, listen: false);

  }

  String pickDate = "Select Date",pickTime = "Select Time",pickAmPm;

  addTodo() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    var data = {
      "id":"",
      "uid":"$userId",
      "title":"${_textEditingController1.text}",
      "description":"${_textEditingController2.text}",
      "date_time":"$pickedDate",
      "priority":"$priority"

    };

    print(data);

    await _todoProvider.insertTOdo(data,'/createTodo');
    if(_todoProvider.isSuccess == true){

      var data = {
        "uid":"$userId",
        "status":""
      };

      _todoProvider.allTodoList.clear();

      await _todoProvider.getAllTodo(data,'/getTodo/1');
      Navigator.pop(context,'Refresh');
    }

  }

  String priority;

  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _todoProvider = Provider.of<TodoProvider>(context, listen: true);

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
            child: Form(
              key: _formkey,
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
                                      controller: _textEditingController1,
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),
                                      validator: (String value) {
                                        if(value.isEmpty)
                                        {
                                          return "Please Enter Title";
                                        }
                                        return null;
                                      },
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
                                      controller: _textEditingController2,
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
                                      "Select Prority",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                    SizedBox(height: height*0.01),
                                   /* TextFormField(
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),
                                      cursorHeight: 22,
                                      cursorColor: Colors.grey,
                                      decoration: fieldStyle1.copyWith(
                                          isDense: true
                                      ),
                                    ),*/

                                    Container(
                                        height: 50,
                                        width: width-30,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
                                            borderRadius: round.copyWith(),
                                            boxShadow: [new BoxShadow(
                                              color: Color.fromRGBO(0,0,0,0.2),
                                              offset: Offset(0, 5),
                                              blurRadius: 5,
                                            )
                                            ]
                                        ),
                                        child:  Padding(
                                          padding: EdgeInsets.only(left: 20,right: 20),
                                          child: DropdownButton<String>(
                                            icon: Image.asset('assets/images/locater/down.png',width: 16),
                                            isExpanded: true,
                                            value: priority,
                                            borderRadius: round.copyWith(),
                                            style: textStyle.copyWith(
                                                fontSize: 16,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold
                                            ),
                                            underline: SizedBox(),
                                            items: [
                                              DropdownMenuItem(
                                                  value: "high",
                                                  child: Text("High")
                                              ),
                                              DropdownMenuItem(
                                                  value: "medium",
                                                  child: Text("Medium")
                                              ),
                                              DropdownMenuItem(
                                                  value: "low",
                                                  child: Text("Low")
                                              ),
                                            ],
                                            onChanged: (_value) {
                                              setState((){
                                                priority = _value;
                                              });
                                            },
                                            hint: Text(
                                              "Select Priority",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        )
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
                                                    hintText: "$pickDate",
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
                                                    hintText: "$pickTime $pickAmPm",
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

                                    _todoProvider.isLoaded == false
                                        ?
                                    Container(
                                      height: 100,
                                      child: Center(
                                          child: SpinKitThreeBounce(
                                            color: AppColors.black,
                                            size: 25.0,
                                          )
                                      ),
                                    )
                                        :
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

                                            if(_formkey.currentState.validate()){
                                              addTodo();
                                            }

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
              ),
            )
        )
    );
  }


  DateTime pickedDate = DateTime.now();
  DateTime newSelectedDate;
  _selecttDate(BuildContext context) async {
    newSelectedDate = await showDatePicker(
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

    if (newSelectedDate != null){
      setState(() {
        this.pickedDate = DateTime(
            newSelectedDate.year,
            newSelectedDate.month,
            newSelectedDate.day,
            time.hour,
            time.minute
        );
        setState(() {
          pickDate = DateFormat('yyyy-MM-dd').format(newSelectedDate);
        });

      });

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

    if (t != null){
      setState(() {
        this.pickedDate = DateTime(
            newSelectedDate.year,
            newSelectedDate.month,
            newSelectedDate.day,
            time.hour,
            time.minute
        );
        setState(() {
          pickTime = "${t.hour}:${t.minute}";
          pickAmPm = t.period == "DayPeriod.pm" ? "PM":"AM";
        });

      });

    }

  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}