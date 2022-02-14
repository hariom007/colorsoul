import 'package:colorsoul/Provider/task_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalTasks extends StatefulWidget {
  @override
  _TotalTasksState createState() => _TotalTasksState();
}

class _TotalTasksState extends State<TotalTasks> with TickerProviderStateMixin{

  TabController _tabController;
  int isSelected = 0;

  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _taskProvider = Provider.of<TaskProvider>(context, listen: false);

    setState(() {
      _taskProvider.taskList.clear();
      _taskProvider.rescheduleTaskList.clear();
      _taskProvider.completedTaskList.clear();
    });
    getTask();

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {

          setState(() {
            isScrollingDown = true;
          });

          setState(() {
            page = page + 1;
            getTask();
          });
        }
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  TaskProvider _taskProvider;

  int page = 1;
  getTask() async {

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
    await _taskProvider.getAllTask(data,'/getTask/$page');


    var data1 = {
       "uid":"$userId",
      // "from_date":"",
      // "to_date":"",
      "status":"reschedule"
    };
    await _taskProvider.getRescheduleTask(data1,'/getTask/$page');


    var data2 = {
       "uid":"$userId",
      // "from_date":"",
      // "to_date":"",
      "status":"complete"
    };
    await _taskProvider.getCompletedTask(data2,'/getTask/$page');

    setState(() {
      isScrollingDown = false;
    });

  }

  completeTask(String taskId) async {

    var data = {
      "id":"$taskId"
    };
    await _taskProvider.completeTask(data,'/completeTask');

    if(_taskProvider.isComplete == true){
      setState(() {
        _taskProvider.taskList.clear();
        _taskProvider.rescheduleTaskList.clear();
        _taskProvider.completedTaskList.clear();
        page = 1;
      });

      getTask();
    }

  }


  DateTime date;
  TimeOfDay time;

  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();

  String formattedDate = '',formattedtime = '';

  dateTimeSelect(id) async {
    date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
      builder: (context,child){
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
      },
    );

    time = await showTimePicker(
      context: context,
      initialTime: pickedTime,
      builder: (context,child){
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
      },
    );

    if (date != null){
      setState(() {
        this.pickedDate = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute
        );
        setState(() {
          formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          formattedtime = DateFormat('hh:mm a').format(pickedDate);
        });

      });

      rescheduleTask(id);

    }
  }

  rescheduleTask(String taskId) async {

    print(pickedDate);

    var data = {
      "old_schedule_id":"$taskId",
      "date_time": "${pickedDate}",
    };
    await _taskProvider.rescheduleTask(data,'/rescheduleTask');

    if(_taskProvider.isComplete == true){
      setState(() {
        _taskProvider.taskList.clear();
        _taskProvider.rescheduleTaskList.clear();
        _taskProvider.completedTaskList.clear();
        page = 1;
      });
      getTask();
    }

  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _taskProvider = Provider.of<TaskProvider>(context, listen: true);

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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/images/tasks/back.png",width: 20,height: 20)
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Task",
                        style: textStyle.copyWith(
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
                          width: 45,
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
                          // indicator: decoration.copyWith(
                          //   gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                          //   boxShadow: [new BoxShadow(
                          //     color: Color.fromRGBO(255,255,255, 0.2),
                          //     offset: Offset(0, 5),
                          //     blurRadius: 4,
                          //   )]
                          // ),
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
                                  child: Text('All Task',
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
                                  child: Text('Reschedule',
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
                                child: Text('Complete',
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
                                      itemCount: _taskProvider.taskList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:(context, index){
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Slidable(
                                            actionExtentRatio: 0.12,
                                            actionPane: SlidableDrawerActionPane(),
                                            actions:
                                            _taskProvider.taskList[index].status == "Completed"
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
                                                                    'Are you sure you want to Reschedule Task?',
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
                                                                          dateTimeSelect("${_taskProvider.taskList[index].id}");
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
                                                      child: Image.asset("assets/images/tasks/time.png",width: 20,height: 20,color: AppColors.white)
                                                  ),
                                                ),
                                              )
                                            ],
                                            secondaryActions:
                                            _taskProvider.taskList[index].status == "Completed"
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
                                                                    'Are you sure you want to Complete Task?',
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
                                                                          completeTask(_taskProvider.taskList[index].id);


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
                                                    borderRadius: round1.copyWith()
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(top: 5,bottom: 6),
                                                  child: ListTile(
                                                    title: Padding(
                                                      padding: EdgeInsets.only(top: 6),
                                                      child: Text(
                                                        '${_taskProvider.taskList[index].title}',
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
                                                        Html(
                                                          shrinkWrap: true,
                                                          data: "${_taskProvider.taskList[index].description}",
                                                          style: {
                                                            '#': Style(
                                                                fontSize: FontSize(14),
                                                                maxLines: 2,
                                                                color: AppColors.black,
                                                                textOverflow: TextOverflow.ellipsis,
                                                                fontFamily: "Roboto-Regular"
                                                            ),
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "${DateFormat('dd, MMM yyyy').format(_taskProvider.taskList[index].dateTime)}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "${DateFormat('hh:mm').format(_taskProvider.taskList[index].dateTime)}",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),

                                                        SizedBox(height: 10),

                                                        _taskProvider.taskList[index].status == "Completed"
                                                            ?
                                                        Icon(Icons.star,color: Colors.green)
                                                            :
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color:
                                                              _taskProvider.taskList[index].status == "New_schedule"
                                                              ?
                                                                  Colors.green
                                                                  :
                                                                  _taskProvider.taskList[index].status == "Over_time"
                                                              ?
                                                                  Colors.red
                                                                      :
                                                                  _taskProvider.taskList[index].status == "Rescheduled"
                                                                      ?
                                                                  Colors.amberAccent
                                                                      :
                                                                  Colors.white

                                                          ),
                                                          width: 8,height: 8,
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    _taskProvider.isLoaded == false
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
                                      itemCount: _taskProvider.rescheduleTaskList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:(context, index){
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Slidable(
                                            actionExtentRatio: 0.12,
                                            actionPane: SlidableDrawerActionPane(),
                                            actions:
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
                                                                    'Are you sure you want to Reschedule Task?',
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
                                                                          dateTimeSelect("${_taskProvider.rescheduleTaskList[index].id}");
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
                                                      child: Image.asset("assets/images/tasks/time.png",width: 20,height: 20,color: AppColors.white)
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
                                                                    'Are you sure you want to Complete Task?',
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
                                                                          completeTask(_taskProvider.rescheduleTaskList[index].id);


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
                                                    borderRadius: round1.copyWith()
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(top: 5,bottom: 6),
                                                  child: ListTile(
                                                    title: Padding(
                                                      padding: EdgeInsets.only(top: 6),
                                                      child: Text(
                                                        '${_taskProvider.rescheduleTaskList[index].title}',
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
                                                        Html(
                                                          shrinkWrap: true,
                                                          data: "${_taskProvider.rescheduleTaskList[index].description}",
                                                          style: {
                                                            '#': Style(
                                                                fontSize: FontSize(14),
                                                                maxLines: 2,
                                                                color: AppColors.black,
                                                                textOverflow: TextOverflow.ellipsis,
                                                                fontFamily: "Roboto-Regular"
                                                            ),
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "${DateFormat('dd, MMM yyyy').format(_taskProvider.rescheduleTaskList[index].dateTime)}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "${DateFormat('HH:mm').format(_taskProvider.rescheduleTaskList[index].dateTime)}",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),

                                                        SizedBox(height: 10),

                                                        Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color:
                                                              _taskProvider.rescheduleTaskList[index].status == "New_schedule"
                                                                  ?
                                                              Colors.green
                                                                  :
                                                              _taskProvider.rescheduleTaskList[index].status == "Over_time"
                                                                  ?
                                                              Colors.red
                                                                  :
                                                              _taskProvider.rescheduleTaskList[index].status == "Rescheduled"
                                                                  ?
                                                              Colors.amberAccent
                                                                  :
                                                              Colors.white

                                                          ),
                                                          width: 8,height: 8,
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    _taskProvider.isLoaded == false
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
                                      itemCount: _taskProvider.completedTaskList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:(context, index){
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Slidable(
                                            actionExtentRatio: 0.12,
                                            actionPane: SlidableDrawerActionPane(),
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
                                                        '${_taskProvider.completedTaskList[index].title}',
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
                                                        Html(
                                                          shrinkWrap: true,
                                                          data: "${_taskProvider.completedTaskList[index].description}",
                                                          style: {
                                                            '#': Style(
                                                                fontSize: FontSize(14),
                                                                maxLines: 2,
                                                                color: AppColors.black,
                                                                textOverflow: TextOverflow.ellipsis,
                                                                fontFamily: "Roboto-Regular"
                                                            ),
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "${DateFormat('dd, MMM yyyy').format(_taskProvider.completedTaskList[index].dateTime)}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "${DateFormat('HH:mm').format(_taskProvider.completedTaskList[index].dateTime)}",
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
                                      },
                                    ),

                                    _taskProvider.isLoaded == false
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
                              )

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
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
