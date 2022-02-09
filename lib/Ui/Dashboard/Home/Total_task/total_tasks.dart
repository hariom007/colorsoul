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

    getTask();

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {

          isScrollingDown = true;
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
      _taskProvider.taskList.clear();
      _taskProvider.rescheduleTaskList.clear();
      _taskProvider.completedTaskList.clear();
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
                                            actions: [
                                              Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.black,
                                                ),
                                                child: Center(
                                                    child: Image.asset("assets/images/tasks/time.png",width: 20,height: 20,color: AppColors.white)
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
                                                      children: [
                                                        Text(
                                                          "${DateFormat('dd, MMM yyyy').format(_taskProvider.taskList[index].date)}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "${_taskProvider.taskList[index].time}",
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
                                            actions: [
                                              Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.black,
                                                ),
                                                child: Center(
                                                    child: Image.asset("assets/images/tasks/time.png",width: 20,height: 20,color: AppColors.white)
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
                                                      children: [
                                                        Text(
                                                          "${DateFormat('dd, MMM yyyy').format(_taskProvider.rescheduleTaskList[index].date)}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "${_taskProvider.rescheduleTaskList[index].time}",
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
                                                          "${DateFormat('dd, MMM yyyy').format(_taskProvider.completedTaskList[index].date)}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "${_taskProvider.completedTaskList[index].time}",
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
