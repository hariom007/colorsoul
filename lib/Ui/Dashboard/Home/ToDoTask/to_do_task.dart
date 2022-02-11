import 'package:colorsoul/Provider/todo_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class ToDoTasks extends StatefulWidget {
  @override
  _ToDoTasksState createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> with TickerProviderStateMixin{
  TabController _tabController;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  int isSelected = 0;


  TodoProvider _todoProvider;
  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;
  int page = 1;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);

    setState(() {
      _todoProvider.allTodoList.clear();
      _todoProvider.rescheduleTodoList.clear();
      _todoProvider.completedTodoList.clear();
    });
    getTodo();

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {

          setState(() {
            isScrollingDown = true;
          });

          setState(() {
            page = page + 1;
            getTodo();
          });
        }
      }
    });

  }

  getTodo() async {

    setState(() {
      isScrollingDown = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      //"from_date":"",
      //"to_date":"",
      "status":""
    };
    await _todoProvider.getAllTodo(data,'/getTodo/$page');


    var data1 = {
      "uid":"$userId",
      // "from_date":"",
      // "to_date":"",
      "status":"reschedule"
    };
    await _todoProvider.getRescheduleTodo(data1,'/getTodo/$page');


    var data2 = {
      "uid":"$userId",
      // "from_date":"",
      // "to_date":"",
      "status":"complete"
    };
    await _todoProvider.getCompleteTodo(data2,'/getTodo/$page');

    setState(() {
      isScrollingDown = false;
    });

  }

  completeTodo(String taskId) async {

    var data = {
      "id":"$taskId"
    };
    await _todoProvider.completeTodo(data,'/completeTodo');

    if(_todoProvider.isComplete == true){
      setState(() {
        _todoProvider.allTodoList.clear();
        _todoProvider.rescheduleTodoList.clear();
        _todoProvider.completedTodoList.clear();
        page = 1;
      });

      getTodo();
    }

  }


  TimeOfDay time =  TimeOfDay.now();
  String pickDate,pickTime,pickAmPm;

  _pickDate(BuildContext context,String id) async {
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

    if(newSelectedDate != null){
      pickDate = DateFormat('yyyy-MM-dd').format(newSelectedDate);
      //print(pickDate);
      _pickTime(id);
    }

  }

  _pickTime(String id) async{
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

      pickTime = "${t.hour}:${t.minute}";
      pickAmPm = t.period == "DayPeriod.pm" ? "PM":"AM";

      rescheduleTodo(id);

    }
  }

  rescheduleTodo(String taskId) async {

    var data = {
      "old_schedule_id":"$taskId",
      "date":"$pickDate",
      "time":"$pickTime",
      "am_pm":"$pickAmPm"
    };
    await _todoProvider.rescheduleTodo(data,'/rescheduleTodo');

    if(_todoProvider.isComplete == true){
      setState(() {
        _todoProvider.allTodoList.clear();
        _todoProvider.rescheduleTodoList.clear();
        _todoProvider.completedTodoList.clear();
        page = 1;
      });
      getTodo();
    }

  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _todoProvider = Provider.of<TodoProvider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.black,
        body:  NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return;
          },
          child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Rectangle17.png"),
                    fit: BoxFit.fill,
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.05),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset("assets/images/tasks/back.png",width: 20,height: 20,color: AppColors.black)
                        ),
                        SizedBox(width: 10),
                        Text(
                          "To do Task",
                          style: textStyle.copyWith(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            _selecttDate(context);
                          },
                          child: Container(
                              height: 35,
                              width: 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                  borderRadius: round1.copyWith(),
                                  boxShadow: [new BoxShadow(
                                    color: Color.fromRGBO(255, 255, 255, 0.15),
                                    offset: Offset(0, 5),
                                    blurRadius: 5,
                                  )]
                              ),
                              child: Image.asset("assets/images/tasks/donedate.png",width: 20,height: 20,color: AppColors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                  TableCalendar(
                    focusedDay: _selectedDay,
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2050),
                    calendarFormat: CalendarFormat.week,
                    onDaySelected: (DateTime selectday,DateTime focusday){
                      setState(() {
                        _selectedDay = selectday;
                        _focusedDay = focusday;
                      });
                    },
                    selectedDayPredicate: (DateTime date){
                      return isSameDay(_selectedDay, date);
                    },
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.black,
                        shape: BoxShape.circle
                      ),
                      selectedTextStyle: textStyle.copyWith(
                        color: AppColors.white
                      )
                    ),
                    headerStyle: HeaderStyle(
                      headerPadding: EdgeInsets.only(top: 0,bottom: 6),
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: textStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.01),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)
                          )
                      ),
                      child: Column(
                        children: [
                          TabBar(
                              onTap: (index) {
                                setState(() {
                                  isSelected = index;
                                });
                              },
                              labelPadding: EdgeInsets.only(left: 4,right: 4),
                              labelStyle: textStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                              indicatorPadding: EdgeInsets.only(left: 4,right: 4,bottom: 2),
                              indicatorColor: Colors.transparent,
                              controller: _tabController,
                              tabs: [
                                Tab(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 9),
                                      width: width,
                                      height: 35,
                                      decoration: decoration.copyWith(
                                          gradient: isSelected==0
                                              ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black])
                                              : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                          boxShadow: [new BoxShadow(
                                            color: Color.fromRGBO(0,0,0, 0.3),
                                            offset: Offset(0, 5),
                                            blurRadius: 5,
                                          )]
                                      ),
                                      child: Text('All To Do',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected==0 ? AppColors.white : AppColors.black
                                        ),
                                      ),
                                    )
                                ),
                                Tab(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 9),
                                      width: width,
                                      height: 35,
                                      decoration: decoration.copyWith(
                                          gradient: isSelected==1
                                              ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black])
                                              : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                          boxShadow: [new BoxShadow(
                                            color: Color.fromRGBO(0,0,0, 0.3),
                                            offset: Offset(0, 5),
                                            blurRadius: 5,
                                          )]
                                      ),
                                      child: Text('In Progress',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected==1 ? AppColors.white : AppColors.black
                                        ),
                                      ),
                                    )
                                ),
                                Tab(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 9),
                                      width: width,
                                      height: 35,
                                      decoration: decoration.copyWith(
                                          gradient: isSelected==2
                                              ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black])
                                              : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2,AppColors.grey2]),
                                          boxShadow: [new BoxShadow(
                                            color: Color.fromRGBO(0,0,0, 0.3),
                                            offset: Offset(0, 5),
                                            blurRadius: 5,
                                          )]
                                      ),
                                      child: Text('Done',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected==2 ? AppColors.white : AppColors.black
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [

                                SingleChildScrollView(
                                  controller: _scrollViewController,
                                  child: Column(
                                    children: [

                                      ListView.builder(
                                        padding: EdgeInsets.only(top: 10,bottom: 10),
                                        itemCount: _todoProvider.allTodoList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:(context, index){
                                          var todoDetails = _todoProvider.allTodoList[index];
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Slidable(
                                              actionExtentRatio: 0.12,
                                              actionPane: SlidableDrawerActionPane(),
                                              actions:
                                              todoDetails.status == "Completed"
                                              ?
                                              []
                                              :
                                              [
                                                InkWell(
                                                  onTap: (){

                                                    showDialog<bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            insetPadding: EdgeInsets.all(0),
                                                            contentPadding: EdgeInsets.all(0),
                                                            backgroundColor: Colors.transparent,
                                                            content: Container(
                                                              width: MediaQuery.of(context).size.width/1.2,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.white,
                                                                  borderRadius: round1.copyWith()
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      'Are you sure you want to Reschedule Todo?',
                                                                      style: textStyle.copyWith(
                                                                          fontSize: 16,
                                                                          color: AppColors.black
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 13),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Text(
                                                                            'No',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop(false);
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child: Text(
                                                                            'Yes, Reschedule',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {

                                                                            Navigator.of(context).pop();
                                                                            _pickDate(context,"${_todoProvider.allTodoList[index].id}");
                                                                            //rescheduleTask(_taskProvider.taskList[index].id);


                                                                          },
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    );

                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.black,
                                                    ),
                                                    child: Center(
                                                        child: Image.asset("assets/images/tasks/progress.png",width: 20,height: 20,color: AppColors.white)
                                                    ),
                                                  ),
                                                )
                                              ],
                                              secondaryActions:
                                              todoDetails.status == "Completed"
                                                  ?
                                              []
                                                  :
                                              [
                                                InkWell(
                                                  onTap: (){

                                                    showDialog<bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            insetPadding: EdgeInsets.all(0),
                                                            contentPadding: EdgeInsets.all(0),
                                                            backgroundColor: Colors.transparent,
                                                            content: Container(
                                                              width: MediaQuery.of(context).size.width/1.2,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.white,
                                                                  borderRadius: round1.copyWith()
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      'Are you sure you want to Complete Todo?',
                                                                      style: textStyle.copyWith(
                                                                          fontSize: 16,
                                                                          color: AppColors.black
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 13),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Text(
                                                                            'No',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop(false);
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child: Text(
                                                                            'Yes, Confirm',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {

                                                                            Navigator.of(context).pop();
                                                                            completeTodo(_todoProvider.allTodoList[index].id);


                                                                          },
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    );

                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.black,
                                                    ),
                                                    child: Center(
                                                        child: Image.asset("assets/images/notes/tick.png",width: 20,height: 20)
                                                    ),
                                                  ),
                                                )
                                              ],
                                              child: Card(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: round2.copyWith()
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                                    child: ListTile(
                                                      title: Text(
                                                        todoDetails.title,
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
                                                          Text(
                                                            todoDetails.time,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: textStyle.copyWith(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            todoDetails.status == "New_schedule" ? "New schedule" : todoDetails.status,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: textStyle.copyWith(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          SizedBox(height: 6),
                                                          Icon(Icons.star,color: Colors.orange),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                      ),

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
                                      SizedBox(),

                                      SizedBox(height: 40),

                                    ],
                                  ),
                                ),

                                SingleChildScrollView(
                                  controller: _scrollViewController,
                                  child: Column(
                                    children: [

                                      ListView.builder(
                                        padding: EdgeInsets.only(top: 10,bottom: 10),
                                        itemCount: _todoProvider.rescheduleTodoList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:(context, index){
                                          var todoDetails = _todoProvider.rescheduleTodoList[index];
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Slidable(
                                              actionExtentRatio: 0.12,
                                              actionPane: SlidableDrawerActionPane(),
                                              actions: [
                                                InkWell(
                                                  onTap: (){

                                                    showDialog<bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            insetPadding: EdgeInsets.all(0),
                                                            contentPadding: EdgeInsets.all(0),
                                                            backgroundColor: Colors.transparent,
                                                            content: Container(
                                                              width: MediaQuery.of(context).size.width/1.2,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.white,
                                                                  borderRadius: round1.copyWith()
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      'Are you sure you want to Reschedule Todo?',
                                                                      style: textStyle.copyWith(
                                                                          fontSize: 16,
                                                                          color: AppColors.black
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 13),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Text(
                                                                            'No',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop(false);
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child: Text(
                                                                            'Yes, Reschedule',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {

                                                                            Navigator.of(context).pop();
                                                                            _pickDate(context,"${_todoProvider.rescheduleTodoList[index].id}");
                                                                            //rescheduleTask(_taskProvider.taskList[index].id);


                                                                          },
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    );

                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.black,
                                                    ),
                                                    child: Center(
                                                        child: Image.asset("assets/images/tasks/progress.png",width: 20,height: 20,color: AppColors.white)
                                                    ),
                                                  ),
                                                )
                                              ],
                                              secondaryActions: [
                                                InkWell(
                                                  onTap: (){

                                                    showDialog<bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            insetPadding: EdgeInsets.all(0),
                                                            contentPadding: EdgeInsets.all(0),
                                                            backgroundColor: Colors.transparent,
                                                            content: Container(
                                                              width: MediaQuery.of(context).size.width/1.2,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.white,
                                                                  borderRadius: round1.copyWith()
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      'Are you sure you want to Complete Todo?',
                                                                      style: textStyle.copyWith(
                                                                          fontSize: 16,
                                                                          color: AppColors.black
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 13),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Text(
                                                                            'No',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop(false);
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child: Text(
                                                                            'Yes, Confirm',
                                                                            style: textStyle.copyWith(
                                                                                color: AppColors.black
                                                                            ),
                                                                          ),
                                                                          onPressed: () {

                                                                            Navigator.of(context).pop();
                                                                            completeTodo(_todoProvider.rescheduleTodoList[index].id);


                                                                          },
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    );

                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.black,
                                                    ),
                                                    child: Center(
                                                        child: Image.asset("assets/images/notes/tick.png",width: 20,height: 20)
                                                    ),
                                                  ),
                                                )
                                              ],
                                              child: Card(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: round2.copyWith()
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                                    child: ListTile(
                                                      title: Text(
                                                        todoDetails.title,
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
                                                          Text(
                                                            todoDetails.time,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: textStyle.copyWith(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Icon(Icons.star,color: Colors.orange),
                                                    ),
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                      ),

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
                                      SizedBox(),

                                      SizedBox(height: 40),

                                    ],
                                  ),
                                ),

                                SingleChildScrollView(
                                  controller: _scrollViewController,
                                  child: Column(
                                    children: [

                                      ListView.builder(
                                        padding: EdgeInsets.only(top: 10,bottom: 10),
                                        itemCount: _todoProvider.completedTodoList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:(context, index){
                                          var todoDetails = _todoProvider.completedTodoList[index];
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Slidable(
                                              actionExtentRatio: 0.12,
                                              actionPane: SlidableDrawerActionPane(),
                                              child: Card(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: round2.copyWith()
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                                    child: ListTile(
                                                      title: Text(
                                                        todoDetails.title,
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
                                                          Text(
                                                            todoDetails.time,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: textStyle.copyWith(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Icon(Icons.star,color: Colors.orange),
                                                    ),
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                      ),

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
                                      SizedBox(),

                                      SizedBox(height: 40),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

  Widget buildCard(double height,int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Slidable(
        actionExtentRatio: 0.12,
        actionPane: SlidableDrawerActionPane(),
        actions: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.black,
            ),
            child: Center(
                child: Image.asset("assets/images/tasks/progress.png",width: 20,height: 20,color: AppColors.white)
            ),
          )
        ],
        secondaryActions: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.black,
            ),
            child: Center(
                child: Image.asset("assets/images/notes/tick.png",width: 20,height: 20)
            ),
          )
        ],
        child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: round1.copyWith()
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 5,bottom: 6),
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    'Be Shoppers Stop',
                    style: textStyle.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                subtitle: Column(
                  children: [
                    SizedBox(height: height*0.01,),
                    Text(
                      'Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                          height: 1.4
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '18, Dec 2021',
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '9:30 AM',
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
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

    // if (newSelectedDate != null) {
    //   _selectedDate = newSelectedDate;
    //   _textEditingController1
    //     ..text = DateFormat.yMMMd().format(_selectedDate)
    //     ..selection = TextSelection.fromPosition(TextPosition(
    //         offset: _textEditingController1.text.length,
    //         affinity: TextAffinity.upstream
    //     )
    //     );
    // }
  }

}

