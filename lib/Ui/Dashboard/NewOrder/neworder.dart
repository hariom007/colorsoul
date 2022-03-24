import 'dart:async';

import 'package:colorsoul/Model/Distributor_Model.dart';
import 'package:colorsoul/Model/Product_Model.dart';
import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/confirmorder.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/location_page.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/normal_order.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Values/appColors.dart';
import '../../../Values/components.dart';


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

class NewOrder extends StatefulWidget  {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class TypeModel {
  String id;
  String name;
  String address;
  String state;
  String mobile;
  String business_name;

  TypeModel({this.id, this.address, this.name, this.state,this.mobile,this.business_name});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TypeModel(
      id: json["id"],
      name: json["name"],
      address: json["createdAt"],
      state: json["name"],
      mobile: json["avatar"],
      business_name: json["avatar"],
    );
  }

  static List<TypeModel> fromJsonList(items) {
    if (items == null) return null;

    List client = items as List;
    return client.map<TypeModel>((json) => TypeModel.fromJson(json)).toList();
  }

  @override
  String toString() => name;
}

class _NewOrderState extends State<NewOrder> {

  TextEditingController _textEditingController1 = new TextEditingController();
  DateTime _selectedDate;
  String value;
  int count = 1;
  bool isvisible = false;
  bool isvisible1 = false;

  TypeModel distributorList;
  List<TypeModel> distributor_List = <TypeModel>[];

  DistributorProvider _distributorProvider;
  ProductProvider _productProvider;

  @override
  void initState() {
    super.initState();
    _distributorProvider = Provider.of<DistributorProvider>(context, listen: false);
    _productProvider = Provider.of<ProductProvider>(context, listen: false);

    getRetailer();

  }

  bool isLoaded = false;
  String selectedRetailerId,selectedRetailerName = "Select Retailer",selectedRetailerAddress,orderAddress,selectedRetailerMobile;
  getRetailer() async {

    setState(() {
      isLoaded = false;
    });

    var data = {
      "type":"Retailer"
    };

    _distributorProvider.onlyDistributorList.clear();
    await _distributorProvider.getOnlyDistributor(data,'/getDistributorRetailerByType');
    if(_distributorProvider.isSuccess == true){

      searchNewDistributor = _distributorProvider.onlyDistributorList;

      // var result  = _distributorProvider.distributorValue;
      //
      setState(() {
        isLoaded = true;
      });
      getGroup();
    }

    setState(() {
      isLoaded = true;
    });

  }

  getGroup() async {
    setState(() {
      isLoaded = false;
    });

    await _productProvider.getGroupList('/getProductGroup');

    setState(() {
      isLoaded = true;
    });
  }

  String groupId;

  List<ProductModel> searchNewProductList = [];
  List<ProductModel> showProductList = [];

  selectGroup(BuildContext context) {

    bool isLoading = false;

    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled:true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {


                  getProducts(context) async {

                    setState(() {
                      isLoading = true;
                      checkBoxList.clear();
                    });

                    var data ={
                      "search_term" : "",
                      "group_id":"$groupId"
                    };
                    print(data);
                    await _productProvider.getSearchProducts(data,'/searchProductByKeyword');
                    if(_productProvider.isSuccess == true){

                      setState(() {

                        showProductList = _productProvider.searchProductList;
                        searchNewProductList = _productProvider.searchProductList;

                        for(int i = 0;i<_productProvider.searchProductList.length;i++){
                          var data = {
                            "id":"${_productProvider.searchProductList[i].clProductId}",
                            "value": false
                          };
                          checkBoxList.add(data);
                        }
                        isLoading = false;

                      });

                      print(_productProvider.searchProductList.length);
                      print(viewProduct.length);

                      addNewItem();

                    }

                  }

                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      height: MediaQuery.of(context).size.height-100,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    "Select Product Group",
                                    style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){

                                    Navigator.pop(context);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.close),
                                  ),
                                )


                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          Expanded(
                            child:
                            isLoading == true
                                ?
                            SpinKitThreeBounce(
                              color: AppColors.black,
                              size: 25.0,
                            )
                                :
                            ListView.builder(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                              itemCount: _productProvider.groupList.length,
                              shrinkWrap: true,
                              itemBuilder:(context, index){
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: (){

                                      setState((){
                                        groupId = _productProvider.groupList[index].id;
                                      });
                                      getProducts(context);

                                    },
                                    child:
                                    Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: round1.copyWith()
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 5,bottom: 6),
                                          child: ListTile(
                                            leading: Text('${_productProvider.groupList[index].name}',
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black
                                              ),
                                            ),
                                            trailing: Icon(Icons.chevron_right),
                                          ),
                                        )

                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      )
                  );
                }
            ),
          );
        }
    ).whenComplete(() {
      setState(() {
        print("Group");
      });
    });
  }


  bool selectAll = false;
  List checkBoxList = [];

  List<ProductModel> selectedProductList = [];
  final _debouncer = Debouncer(milliseconds: 10);
  addNewItem() {

    bool isLoading = false;
    TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled:true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {

                  getProducts(String value) async {

                    setState((){
                      isLoading = true;
                    });

                    var data ={
                      "group_id":"$groupId",
                      "search_term" : "${value}"
                    };
                    await _productProvider.getSearchProducts(data,'/searchProductByKeyword');

                      isLoading = false;

                  }

                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      height: MediaQuery.of(context).size.height-100,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    "Add products",
                                    style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){

                                    Navigator.pop(context);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.close),
                                  ),
                                )


                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              children: [

                                Expanded(
                                  child: TextField(
                                    onSubmitted: (value){

                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      setState((){

                                        _debouncer.run(() {
                                          setState(() {
                                            _productProvider.searchProductList = searchNewProductList.where((u) => (u.clProductName.toLowerCase().contains(value.toLowerCase())))
                                                .toList();
                                            isLoaded == false;
                                          });
                                        });

                                      });

                                    },
                                    onChanged: (value){

                                      setState((){

                                        _debouncer.run(() {
                                          setState(() {
                                            _productProvider.searchProductList = searchNewProductList.where((u) => (u.clProductName.toLowerCase().contains(value.toLowerCase())))
                                                .toList();
                                            isLoaded == false;
                                          });
                                        });

                                      });


                                    },
                                    controller: searchController,
                                    style: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
                                    cursorColor: AppColors.black,
                                    cursorHeight: 22,
                                    decoration: fieldStyle1.copyWith(
                                        hintText: "Search Product",
                                        hintStyle: textStyle.copyWith(
                                            color: AppColors.black
                                        ),
                                        isDense: true
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                InkWell(
                                  onTap: (){

                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    setState((){

                                      _debouncer.run(() {
                                        setState(() {
                                          _productProvider.searchProductList = searchNewProductList.where((u) => (u.clProductName.toLowerCase().contains(searchController.text.toLowerCase())))
                                              .toList();
                                          isLoaded == false;
                                        });
                                      });

                                    });

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                      border: Border.all(color: AppColors.black)
                                    ),
                                    height: 50,width: 60,
                                    child: IconButton(
                                      icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                      onPressed: null,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(right: 30,left: 20,top: 15,bottom: 15),
                            child: Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    "Select All",
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),

                                Container(
                                  width: 25,
                                  height: 25,
                                  child: Checkbox(
                                      value: selectAll,
                                      checkColor: AppColors.white,
                                      activeColor: AppColors.black,
                                      onChanged: (value){

                                        setState((){

                                          checkBoxList.clear();

                                          selectAll = !selectAll;

                                          for(int i = 0;i<searchNewProductList.length;i++){
                                            var data = {
                                              "id":"${searchNewProductList[i].clProductId}",
                                              "value": selectAll
                                            };
                                            checkBoxList.add(data);
                                          }

                                        });

                                      })
                                ),

                              ],
                            ),
                          ),

                          Expanded(
                            child:
                            isLoading == true
                                ?
                            SpinKitThreeBounce(
                              color: AppColors.black,
                              size: 25.0,
                            )
                                :
                            ListView.builder(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                              itemCount: _productProvider.searchProductList.length,
                              shrinkWrap: true,
                              itemBuilder:(context, index){

                                var productData = _productProvider.searchProductList[index];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: (){

                                      checkBoxList[index]["value"] = !checkBoxList[index]["value"];

                                      setState((){
                                        var data = {
                                          "id":"${checkBoxList[index]["id"]}",
                                          "value":checkBoxList[index]["value"]
                                        };
                                        checkBoxList[index] = data;
                                      });


                                      if(checkBoxList[index]['value'] == true){

                                        for(int i=0;i<checkBoxList.length;i++){

                                          if(checkBoxList[i]["value"] == false){
                                            setState((){
                                              selectAll = false;
                                            });
                                            break;
                                          }
                                          else{
                                            selectAll = true;
                                          }

                                        }

                                      }
                                      else{

                                        for(int i=0;i<checkBoxList.length;i++){

                                          if(checkBoxList[i]["value"] == true){
                                            setState((){
                                              selectAll = false;
                                            });
                                            break;
                                          }

                                        }

                                      }


                                    },
                                    child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: round1.copyWith()
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                          child: Row(
                                            children: [

                                              Expanded(
                                                child: Text(
                                                  "${productData.clProductShortname}",
                                                  style: textStyle.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: 25,
                                                height: 25,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: checkBoxList.length,
                                                  itemBuilder: (context, index2) {

                                                    return
                                                      checkBoxList[index2]["id"] == productData.clProductId
                                                          ?
                                                      SizedBox(
                                                        height: 20,width: 20,
                                                        child: Checkbox(
                                                            value: checkBoxList[index2]["value"],
                                                            checkColor: AppColors.white,
                                                            activeColor: AppColors.black,
                                                            onChanged: (value){

                                                              setState((){
                                                                var data = {
                                                                  "id":"${checkBoxList[index2]["id"]}",
                                                                  "value":value
                                                                };
                                                                checkBoxList[index2] = data;
                                                              });

                                                              if(checkBoxList[index]['value'] == true){

                                                                for(int i=0;i<checkBoxList.length;i++){

                                                                  if(checkBoxList[i]["value"] == false){
                                                                    setState((){
                                                                      selectAll = false;
                                                                    });
                                                                    break;
                                                                  }
                                                                  else{
                                                                    selectAll = true;
                                                                  }

                                                                }

                                                              }
                                                              else{

                                                                for(int i=0;i<checkBoxList.length;i++){

                                                                  if(checkBoxList[i]["value"] == true){
                                                                    setState((){
                                                                      selectAll = false;
                                                                    });
                                                                    break;
                                                                  }

                                                                }

                                                              }


                                                            }),
                                                      )
                                                          :
                                                      SizedBox();

                                                  },
                                                ),
                                              ),

                                            ],
                                          ),
                                        )

                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                      borderRadius: round.copyWith()
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {

                                      for(int i=0;i<checkBoxList.length;i++){
                                        if(checkBoxList[i]['value'] == true){

                                          for(int j=0;j<  showProductList.length;j++){

                                            if(checkBoxList[i]['id'] == showProductList[j].clProductId){

                                              setState((){
                                                selectedProductList.add(showProductList[j]);
                                                selectedQuantity.add(TextEditingController());
                                                selectedAmount.add(TextEditingController());
                                              });

                                            }

                                          }

                                        }
                                      }

                                      selectColors();


                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        primary: Colors.transparent,
                                        shape: StadiumBorder()
                                    ),
                                    child: Text('Next',
                                      textAlign: TextAlign.center,
                                      style: textStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),

                        ],
                      )
                  );
                }
            ),
          );
        }
    ).whenComplete(() {
      setState(() {
        print("Product Added");
      });

    });
  }


  bool isSelectAll = false;
  TextEditingController allQuantity = TextEditingController();
  TextEditingController allPrice = TextEditingController();

  List<TextEditingController> selectedQuantity = [];
  List<TextEditingController> selectedAmount = [];

  selectColors() {

    final _formkey2 = GlobalKey<FormState>();

    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled:true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {

                  return Form(
                    key: _formkey2,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        height: MediaQuery.of(context).size.height-100,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                children: [

                                  Expanded(
                                    child: Text(
                                      "Select Products",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){

                                      Navigator.pop(context);

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.close),
                                    ),
                                  )


                                ],
                              ),
                            ),

                            SizedBox(height: 20),

                            Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                children: [

                                  Expanded(
                                    child: Text(
                                      "Select All",
                                      style: textStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  Container(
                                    width: 80,
                                    child: TextFormField(
                                      controller: allQuantity,
                                      keyboardType: TextInputType.number,
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      cursorHeight: 22,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                        isDense: true,
                                        hintText: "Quantity",
                                        errorStyle: TextStyle(height: 0,fontSize: 0),
                                      ),
                                      onChanged: (value){

                                        setState((){
                                          selectedQuantity.clear();
                                          for(int i =0;i<_productProvider.searchProductList.length;i++){
                                            TextEditingController controller = TextEditingController(text: "$value");
                                            selectedQuantity.add(controller);
                                          }
                                        });

                                      },
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  Container(
                                    width: 80,
                                    child: TextFormField(
                                      controller: allPrice,
                                      keyboardType: TextInputType.number,
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),
                                      cursorHeight: 22,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                        isDense: true,
                                        hintText: "Amount",
                                        errorStyle: TextStyle(height: 0,fontSize: 0),
                                      ),
                                      onChanged: (value){

                                        setState((){
                                          selectedAmount.clear();
                                          for(int i =0;i<_productProvider.searchProductList.length;i++){
                                            TextEditingController controller = TextEditingController(text: "$value");
                                            selectedAmount.add(controller);
                                          }
                                        });

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),

                            Expanded(
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Item Name",
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            "Quantity",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            "Amount",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),

                                  Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                                      itemCount: selectedProductList.length,
                                      shrinkWrap: true,
                                      itemBuilder:(context, index){
                                        var productData = selectedProductList[index];

                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            children: [

                                              Expanded(
                                                child: Text(
                                                  "${productData.clProductShortname}",
                                                  style: textStyle.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: 70,
                                                child: TextFormField(
                                                  controller: selectedQuantity[index],
                                                  keyboardType: TextInputType.number,
                                                  validator: (String value) {
                                                    if(value.isEmpty)
                                                    {
                                                      return "";
                                                    }
                                                    return null;
                                                  },
                                                  style: textStyle.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                  ),
                                                  cursorHeight: 22,
                                                  textAlign: TextAlign.center,
                                                  cursorColor: Colors.grey,
                                                  decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderRadius: BorderRadius.only(),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderRadius: BorderRadius.only(),
                                                    ),
                                                    isDense: true,
                                                    hintText: "Quantity",
                                                    errorStyle: TextStyle(height: 0,fontSize: 0),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(width: 15),

                                              Container(
                                                width: 70,
                                                child: TextFormField(
                                                  controller: selectedAmount[index],
                                                  keyboardType: TextInputType.number,
                                                  validator: (String value) {
                                                    if(value.isEmpty)
                                                    {
                                                      return "";
                                                    }
                                                    return null;
                                                  },
                                                  style: textStyle.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                  ),
                                                  cursorHeight: 22,
                                                  textAlign: TextAlign.center,
                                                  cursorColor: Colors.grey,
                                                  decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderRadius: BorderRadius.only(),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderRadius: BorderRadius.only(),
                                                    ),
                                                    isDense: true,
                                                    hintText: "Amount",
                                                    errorStyle: TextStyle(height: 0,fontSize: 0),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                            borderRadius: round.copyWith()
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {

                                           if(_formkey2.currentState.validate()){

                                             for(int i=0;i<selectedProductList.length;i++){

                                               var product = {
                                                 "pid":"${selectedProductList[i].clProductId}",
                                                 "short":"${selectedProductList[i].clProductShortname}",
                                                 "color_id":"${selectedProductList[i].colors[0].clColorId}",
                                                 "color_code":"${selectedProductList[i].colors[0].clColorCode}",
                                                 "sku":"${selectedProductList[i].colors[0].skuCode}",
                                                 "amount":"${selectedAmount[i].text}",
                                                 "qty":"${selectedQuantity[i].text}",
                                                 "hsnigst":"${selectedProductList[i].hsnIgst}",
                                                 "hsncgst":"${selectedProductList[i].hsnCgst}",
                                                 "hsnsgst":"${selectedProductList[i].hsnSgst}",
                                                 "hsn_code":"${selectedProductList[i].hsnCode}",
                                               };
                                               viewProduct.add(product);

                                               totalQuentity = totalQuentity + int.parse("${selectedQuantity[i].text}");

                                               double singleAmount = double.parse(selectedAmount[i].text) * double.parse(selectedQuantity[i].text);
                                               totalAmount = totalAmount + singleAmount;
                                             }

                                             setState((){
                                               allPrice.clear();
                                               allQuantity.clear();
                                               selectAll = false;
                                             });


                                             Navigator.pop(context);
                                             Navigator.pop(context);
                                             Navigator.pop(context);

                                           }

                                          },
                                          style: ElevatedButton.styleFrom(
                                              elevation: 10,
                                              primary: Colors.transparent,
                                              shape: StadiumBorder()
                                          ),
                                          child: Text('Add Products',
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                  ),

                                ],
                              )
                            ),

                          ],
                        )
                    ),
                  );
                }
            ),
          );
        }
    ).whenComplete(() {
      setState(() {
        selectedAmount.clear();
        selectedQuantity.clear();
        selectedProductList.clear();
        isSelectAll = false;
      });
    });
  }

  List viewProduct = [];

  double totalAmount = 0.0;
  int totalQuentity = 0;


  List finalProduct = [];
  double TotalAmount = 0.0;

  final _formkey = GlobalKey<FormState>();

  List<DistributorModel> searchNewDistributor = [];

  selectDistributor(){

    TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {

                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      height: MediaQuery.of(context).size.height-100,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    "Select Retailer",
                                    style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){

                                    Navigator.pop(context);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.close),
                                  ),
                                )

                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              children: [

                                Expanded(
                                  child: TextField(
                                    onSubmitted: (value){

                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      setState((){

                                        _debouncer.run(() {
                                          setState(() {
                                            _distributorProvider.onlyDistributorList = searchNewDistributor.where((u) {
                                              return (u.name.toLowerCase().contains(value.toLowerCase()) || u.businessName.toLowerCase().contains(value.toLowerCase()));
                                            })
                                                .toList();
                                            isLoaded == true;
                                          });
                                        });

                                      });

                                    },
                                    onChanged: (value){

                                      setState((){

                                        _debouncer.run(() {
                                          setState(() {
                                            _distributorProvider.onlyDistributorList = searchNewDistributor.where((u) {
                                              return (u.name.toLowerCase().contains(value.toLowerCase()) || u.businessName.toLowerCase().contains(value.toLowerCase()));
                                            })
                                                .toList();
                                            isLoaded == true;
                                          });
                                        });

                                      });


                                    },
                                    controller: searchController,
                                    style: textStyle.copyWith(
                                        color: AppColors.black
                                    ),
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
                                ),

                                SizedBox(width: 10),

                                InkWell(
                                  onTap: (){

                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    setState((){

                                      _debouncer.run(() {
                                        setState(() {
                                          _distributorProvider.onlyDistributorList = searchNewDistributor.where((u) {
                                            return (u.name.toLowerCase().contains(value.toLowerCase()) || u.businessName.toLowerCase().contains(value.toLowerCase()));
                                          })
                                              .toList();
                                          isLoaded == true;
                                        });
                                      });

                                    });

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        border: Border.all(color: AppColors.black)
                                    ),
                                    height: 50,width: 60,
                                    child: IconButton(
                                      icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                      onPressed: null,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                          SizedBox(height: 10),

                          Expanded(
                            child:
                            isLoaded == false
                                ?
                            SpinKitThreeBounce(
                              color: AppColors.black,
                              size: 25.0,
                            )
                                :
                            ListView.builder(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                              itemCount: _distributorProvider.onlyDistributorList.length,
                              shrinkWrap: true,
                              itemBuilder:(context, index){
                                var t = _distributorProvider.onlyDistributorList[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: (){

                                      setState(() {
                                        selectedRetailerId = t.id;
                                        selectedRetailerName =
                                        t.businessName == ""
                                            ?
                                        t.name  == ""
                                            ?
                                        t.mobile
                                            :
                                        t.name
                                            :
                                        t.businessName;

                                        selectedRetailerAddress = t.address;
                                        orderAddress = t.address;
                                        selectedRetailerMobile = t.mobile;
                                        isvisible = true;
                                        isvisible1 = true;
                                      });

                                      Navigator.pop(context);

                                    },
                                    child:
                                    ListTile(
                                      leading: Text(
                                        _distributorProvider.onlyDistributorList[index].name == ""
                                            ?
                                        _distributorProvider.onlyDistributorList[index].businessName
                                            :
                                        '${_distributorProvider.onlyDistributorList[index].name}',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black
                                        ),
                                      ),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),


                        ],
                      )
                  );
                }
            ),
          );
        }
    ).whenComplete(() {
      setState(() {
       print("Select Distributor");
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _distributorProvider = Provider.of<DistributorProvider>(context, listen: true);
    _productProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 70,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child:SizedBox(
                  height: 50,
                  width: width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                      borderRadius: round.copyWith()
                    ),
                    child: ElevatedButton(
                      onPressed: () {

                        if(selectedRetailerId == null){

                          Fluttertoast.showToast(
                              msg: "Please Select Retailer.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        }
                        else if(_textEditingController1.text == null || _textEditingController1.text == ""){


                          Fluttertoast.showToast(
                              msg: "Please Select Order Date.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        }
                        else if(viewProduct.length ==0){

                          Fluttertoast.showToast(
                              msg: "Please Add Product First.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        }
                        else{

                          if(_formkey.currentState.validate())
                          {

                            var FinalProduct = [];
                            for(int i=0;i<viewProduct.length;i++){

                              double singleAmount = double.parse("${viewProduct[i]['amount']}") * double.parse("${viewProduct[i]['qty']}");

                              var singleProduct = {
                                "pid":"${viewProduct[i]['pid']}",
                                "color_id":"${viewProduct[i]['color_id']}",
                                "color_code":"${viewProduct[i]['color_code']}",
                                "sku":"${viewProduct[i]['sku']}",
                                "amount":"${viewProduct[i]['amount']}",
                                "qty":"${viewProduct[i]['qty']}"
                              };
                              FinalProduct.add(singleProduct);

                            }
                            //print(FinalProduct);

                            double FinalAmount = 0.0;

                            for(int i=0;i<FinalProduct.length;i++){
                              double singleAmount = double.parse(FinalProduct[i]['amount']) * double.parse(FinalProduct[i]['qty']);
                              FinalAmount = FinalAmount + singleAmount;
                            }

                            Navigator.push(context, MaterialPageRoute(builder: (context) => NormalOrder(
                              retailerId: selectedRetailerId,
                              address: orderAddress,
                              orderDate: _textEditingController1.text,
                              totalAmount: "${FinalAmount}",
                              productList: FinalProduct,
                            )));

                          }
                          else{

                            Fluttertoast.showToast(
                                msg: "Please Add Products Amount.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                          }

                        }


                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: Colors.transparent,
                          shape: StadiumBorder()
                      ),
                      child: Text('Next',
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ),
              )
            )
          ]
        ),
        backgroundColor: Colors.white,
        body:Form(
          key: _formkey,
          child: Container(
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
                          SizedBox(width: 10),
                          Text(
                            "Create Order",
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
                        child:
                        isLoaded == false
                            ?
                        SpinKitThreeBounce(
                          color: AppColors.black,
                          size: 25.0,
                        )
                        :
                        Padding(
                            padding: EdgeInsets.only(right: 10,left: 10),
                            child: NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (OverscrollIndicatorNotification overscroll) {
                                overscroll.disallowGlow();
                                return;
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          SizedBox(height: height*0.03),
                                          Text(
                                            "Retailer Name",
                                            style: textStyle.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          SizedBox(height: height*0.01),


                                          TextFormField(
                                              style: textStyle.copyWith(
                                                  color: AppColors.black
                                              ),
                                              onTap: () async {

                                                selectDistributor();

                                              },
                                              cursorColor: AppColors.black,
                                              cursorHeight: 22,
                                              readOnly: true,
                                              decoration: fieldStyle1.copyWith(
                                                  hintText: "Select Retailer",
                                                  hintStyle: textStyle.copyWith(
                                                      color: AppColors.black
                                                  ),
                                                  isDense: true
                                              )
                                          ),


                                          Visibility(
                                            visible: isvisible,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 20,right: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: height*0.02),
                                                  Row(
                                                    children: [
                                                      RichText(
                                                          text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                    text: "Retailer :- ",
                                                                    style: textStyle.copyWith(
                                                                        fontSize: 16,
                                                                        color: AppColors.black,
                                                                        fontWeight: FontWeight.bold
                                                                    )
                                                                ),
                                                                TextSpan(
                                                                    text: "$selectedRetailerName",
                                                                    style: textStyle.copyWith(
                                                                      fontSize: 16,
                                                                      color: AppColors.black,
                                                                    )
                                                                )
                                                              ]
                                                          )
                                                      ),
                                                      Expanded(child: Container()),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              isvisible = false;
                                                            });
                                                          },
                                                          child: Image.asset("assets/images/productsdata/cancel.png",width: 10,height: 10)
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Image.asset("assets/images/tasks/location1.png",width: 20,height: 20),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          "$selectedRetailerAddress",
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: textStyle.copyWith(
                                                              color: AppColors.black,
                                                              height: 1.4
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 14),
                                                  Row(
                                                    children: [
                                                      Image.asset("assets/images/neworder/call.png",width: 20,height: 20),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          "+91 ${selectedRetailerMobile}",
                                                          maxLines: 2,
                                                          style: textStyle.copyWith(
                                                              fontSize: 15,
                                                              color: AppColors.black,
                                                              height: 1.2
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: height*0.02),

                                          Divider(
                                              color: Color.fromRGBO(185, 185, 185, 0.75),
                                              thickness: 2
                                          ),
                                          SizedBox(height: height*0.02),
                                          Text(
                                            "To Change Location Click Here",
                                            style: textStyle.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          ),
                                          SizedBox(height: height*0.01),

                                          TextFormField(
                                              style: textStyle.copyWith(
                                                  color: AppColors.black
                                              ),
                                              onTap: () async {

                                                final value = await Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage()));
                                                if(value != null){
                                                  print(value);

                                                  var fullAddress = value.split("/");
                                                  orderAddress = fullAddress[0];

                                                  setState(() {
                                                    isvisible1 = true;
                                                  });
                                                }

                                              },
                                              cursorColor: AppColors.black,
                                              cursorHeight: 22,
                                              readOnly: true,
                                              decoration: fieldStyle1.copyWith(
                                                  hintText: "Search Location",
                                                  hintStyle: textStyle.copyWith(
                                                      color: AppColors.black
                                                  ),
                                                  prefixIcon: new IconButton(
                                                    icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                                    onPressed: null,
                                                  ),
                                                  isDense: true
                                              )
                                          ),

                                          Visibility(
                                            visible: isvisible1,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 20,right: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: height*0.02),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                            children: [
                                                              Image.asset("assets/images/locater/location4.png",width: 20,height: 20),
                                                              SizedBox(width: 10),
                                                              Flexible(
                                                                child: Text(
                                                                  "$orderAddress",
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: textStyle.copyWith(
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                      height: 1.4
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                      ),

                                                      SizedBox(width: 15),

                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              isvisible1 = false;
                                                            });
                                                          },
                                                          child: Image.asset("assets/images/productsdata/cancel.png",width: 10,height: 10)
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),

                                                ],
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: height*0.03),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Tentative Order Date",
                                                style: textStyle.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              SizedBox(
                                                width: width,
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
                                                    isDense: true,
                                                    errorStyle: TextStyle(height: 0),
                                                  ),
                                                  style: textStyle.copyWith(
                                                      fontSize: 16,
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
                                          SizedBox(height: height*0.02),
                                          Row(
                                            children: [

                                              Expanded(
                                                child: Text(
                                                  "Add products",
                                                  style: textStyle.copyWith(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ),

                                              InkWell(
                                                onTap: (){

                                                  selectGroup(context);
                                                  //addNewItem(context);

                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(Icons.add),
                                                ),
                                              )


                                            ],
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [

                                          SizedBox(width: 30),

                                          Expanded(
                                            child: Text(
                                              "Item Code",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            child: Text(
                                              "Quantity",
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            child: Text(
                                              "Amount",
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Divider(
                                        height: 20,
                                        color: Color.fromRGBO(185, 185, 185, 0.75),
                                        thickness: 1.2
                                    ),

                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(top: 10,left: 6,right: 10),
                                      itemCount: viewProduct.length,
                                      shrinkWrap: true,
                                      itemBuilder:(context, index){
                                        var productData = viewProduct[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            children: [


                                              InkWell(
                                                onTap: (){
                                                  setState(() {

                                                    viewProduct.removeAt(index);
                                                    totalQuentity = 0;
                                                    totalAmount = 0;

                                                    for(int i=0;i<viewProduct.length;i++){

                                                      totalQuentity = totalQuentity + int.parse("${viewProduct[i]['qty']}");

                                                      double singleAmount = double.parse("${viewProduct[i]['amount']}") * double.parse("${viewProduct[i]['qty']}");
                                                      totalAmount = totalAmount + singleAmount;
                                                    }

                                                  });
                                                },
                                                child: Icon(Icons.close,size: 20),
                                              ),

                                              SizedBox(width: 20),

                                              Expanded(
                                                child: Text(
                                                  "${productData['sku']}",
                                                  style: textStyle.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  "${productData['qty']}",
                                                  textAlign: TextAlign.center,
                                                  style: textStyle.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  "${productData['amount']}",
                                                  textAlign: TextAlign.center,
                                                  style: textStyle.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 10),

                                    viewProduct.length == 0
                                        ?
                                    SizedBox(height: 10)
                                        :
                                    Row(
                                      children: [


                                        Expanded(
                                          child: Container(
                                            width: 130,
                                            child: Text(
                                              "Quantity : $totalQuentity",
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              "Amount : ${totalAmount.toStringAsFixed(2)}",
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
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
          ),
        )
    );
  }

  _selecttDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
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
      setState(() {
        _textEditingController1 = TextEditingController(text: DateFormat('yyyy-MM-dd').format(_selectedDate));
      });
    }
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}