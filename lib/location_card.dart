import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'appColors.dart';
import 'components.dart';
import 'location.dart';
import 'details.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
          borderRadius: round2.copyWith()
        ),
        child: Slidable(
          actionExtentRatio: 0.20,
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: [
            Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)
                ),
                color: AppColors.black,
              ),
              child: Center(
                child: Image.asset("assets/images/tasks/bin.png",width: 20,),
              ),
            )
        ],
        child: Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: ListTile(
            leading: Image.asset(location.img),
            title: Text(
                  location.title,
                  style: textStyle.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.01,),
                Row(
                  children: [
                    Image.asset("assets/images/tasks/location1.png",width: 15),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        location.add,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle.copyWith(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              children: [
                Image.asset("assets/images/tasks/location2.png",width: 20),
                SizedBox(height: height*0.015),
                Text(
                  location.dist,
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}

// ListView.builder(
//   physics: NeverScrollableScrollPhysics(),
//   padding: EdgeInsets.only(top: 10),
//   shrinkWrap: true,
//   itemCount: LocationModel.location.length,
//   itemBuilder: (context, index){
//     return LocationCard(location: LocationModel.location[index]);
//   },
// ),

class LocationCard1 extends StatelessWidget {
  final Location1 location1;

  LocationCard1({Key key, @required this.location1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: round2.copyWith()
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child: ListTile(
              title: Text(
                location1.title,
                style: textStyle.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.01),
                  Row(
                    children: [
                      Image.asset("assets/images/tasks/location1.png",width: 15),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          location1.add,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle.copyWith(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/images/tasks/location2.png",width: 20),
                      SizedBox(height: height*0.015),
                      Text(
                        location1.dist,
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Image.asset("assets/images/locater/direction.png",width: 22),
                      SizedBox(height: height*0.015),
                      Text(
                        "Direction",
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black
                        ),
                      )
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details()
                  )
                );
              },
            ),
          )
      ),
    );
  }
}
