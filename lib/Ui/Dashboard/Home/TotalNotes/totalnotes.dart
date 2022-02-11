import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Provider/note_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalNotes extends StatefulWidget {
  @override
  _TotalNotesState createState() => _TotalNotesState();
}

class _TotalNotesState extends State<TotalNotes> {

  NoteProvider _noteProvider;

  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _noteProvider = Provider.of<NoteProvider>(context, listen: false);

    setState(() {
      _noteProvider.noteList.clear();
    });
    getNote();

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {

          setState(() {
            isScrollingDown = true;
          });

          setState(() {
            page = page + 1;
            getNote();
          });
        }
      }
    });

  }

  int page = 1;
  getNote() async {

    setState(() {
      isScrollingDown = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      //"from_date":"",
      //"to_date":"",
      //"status":""
    };
    await _noteProvider.getAllNote(data,'/getNote/$page');

    setState(() {
      isScrollingDown = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _noteProvider = Provider.of<NoteProvider>(context, listen: true);

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
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.062),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/images/tasks/back.png",height: 20,width: 20)
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: width/1.5,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0,0,0,0.9],colors: [AppColors.grey1,AppColors.grey1,AppColors.grey1,AppColors.grey2]),
                              borderRadius: round.copyWith(),
                              boxShadow: [new BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                offset: Offset(0, 10),
                                blurRadius: 20,
                              )
                              ]
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  cursorColor: AppColors.black,
                                  cursorHeight: 24,
                                  decoration: InputDecoration(
                                    hintText: "Search your notes",
                                    hintStyle: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                    prefixIcon: new IconButton(
                                      icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                      onPressed: null,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        )
                                    ),
                                    isDense: true
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Image.asset("assets/images/notes/grid.png",width: 25,height: 25)
                    ],
                  ),
                ),
                SizedBox(height: height*0.03),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollViewController,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 10),

                              ListView.builder(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                itemCount: _noteProvider.noteList.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:(context, index){
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: round1.copyWith()
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius: round1.copyWith(),
                                          color: HexColor("${_noteProvider.noteList[index].colorCode}"),
                                        ),
                                        width: width,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_noteProvider.noteList[index].title}",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "${_noteProvider.noteList[index].note}",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  height: 1.4
                                              ),
                                            ),

                                            SizedBox(height: 10),

                                            StaggeredGridView.countBuilder(
                                              physics: NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 15,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              itemCount: _noteProvider.noteList[index].imageUrl.length,
                                              staggeredTileBuilder: (index) {
                                                return StaggeredTile.fit(1);
                                              },
                                              itemBuilder: (BuildContext context, int index1) {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fitWidth,
                                                    imageUrl: "${_noteProvider.noteList[index].imageUrl[index1]}",
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
                                    ),
                                  );
                                },
                              ),

                              _noteProvider.isLoaded == false
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

                            ],
                          ),
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
