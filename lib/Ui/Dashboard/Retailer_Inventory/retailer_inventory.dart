import 'dart:async';

import 'package:colorsoul/Model/Distributor_Model.dart';
import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Distributers/details.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/product_order.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}


class RetailerInventory extends StatefulWidget {
  const RetailerInventory({Key key}) : super(key: key);

  @override
  State<RetailerInventory> createState() => _RetailerInventoryState();
}

class _RetailerInventoryState extends State<RetailerInventory> {


  DistributorProvider _distributorProvider;

  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();

    _distributorProvider = Provider.of<DistributorProvider>(context, listen: false);

    _distributorProvider.distributorList.clear();
    getDistributor();

  }

  int page = 1;
  TextEditingController searchDistributor = TextEditingController();

  List<DistributorModel> searchNewDistributor = [];
  final _debouncer = Debouncer(milliseconds: 10);
  getDistributor() async {

    var data = {
      "type":"Retailer"
    };

    _distributorProvider.onlyDistributorList.clear();
    await _distributorProvider.getOnlyDistributor(data,'/getDistributorRetailerByType');
    if(_distributorProvider.isSuccess == true) {
      searchNewDistributor = _distributorProvider.onlyDistributorList;
    }
  }

  Future<Position> getGeoLocationPosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        Fluttertoast.showToast(
            msg: "Location permissions are denied. !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return Future.error('Location permissions are denied');
      }
      else{
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }

    }

    if (permission == LocationPermission.deniedForever) {

      Fluttertoast.showToast(
          msg: "Location permissions are permanently denied, we cannot request permissions. !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  }

  @override
  Widget build(BuildContext context) {
    _distributorProvider = Provider.of<DistributorProvider>(context, listen: true);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.05),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
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

                      SizedBox(width: 10),

                      Text(
                        "Select Retailer",
                        style: textStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.01),
                Expanded(
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: Column(
                            children: [

                              SizedBox(height: 20),

                              TextField(
                                onSubmitted: (value){
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                },
                                onChanged: (value){

                                  setState((){

                                    _debouncer.run(() {
                                      setState(() {
                                        _distributorProvider.onlyDistributorList = searchNewDistributor.where((u) {
                                          return (u.name.toLowerCase().contains(value.toLowerCase()) || u.businessName.toLowerCase().contains(value.toLowerCase()));
                                        }).toList();
                                      });
                                    });

                                  });

                                },
                                style: textStyle.copyWith(
                                    color: AppColors.black
                                ),
                                controller: searchDistributor,
                                cursorColor: AppColors.black,
                                cursorHeight: 22,
                                decoration: fieldStyle1.copyWith(
                                    hintText: "Search Retailer",
                                    hintStyle: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                    isDense: true
                                ),
                              ),

                              Expanded(
                                child: NotificationListener<OverscrollIndicatorNotification>(
                                  onNotification: (OverscrollIndicatorNotification overscroll) {
                                    overscroll.disallowGlow();
                                    return;
                                  },
                                  child: SingleChildScrollView(
                                    controller: _scrollViewController,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          itemCount: _distributorProvider.onlyDistributorList.length,
                                          shrinkWrap: true,
                                          itemBuilder:(context, index){
                                            var distributorData = _distributorProvider.onlyDistributorList[index];
                                            return InkWell(
                                              onTap: (){

                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductOrder()));

                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 10),
                                                child: Card(
                                                    elevation: 10,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: round1.copyWith()
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 5,bottom: 6),
                                                      child:  ListTile(
                                                        title: Text(
                                                          "${distributorData.businessName}",
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
                                                            Row(
                                                              children: [
                                                                Image.asset("assets/images/tasks/location1.png",width: 15),
                                                                SizedBox(width: 10),
                                                                Flexible(
                                                                  child: Text(
                                                                    "${distributorData.address}",
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: textStyle.copyWith(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Icon(Icons.chevron_right_rounded,color: AppColors.black,size: 25,)
                                                      ),
                                                    )
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        _distributorProvider.isDistributorLoaded == false
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
                                ),
                              ),
                            ],
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
