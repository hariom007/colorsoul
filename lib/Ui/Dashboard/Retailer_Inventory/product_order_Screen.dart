import 'package:colorsoul/Model/Product_Model.dart';
import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/location_page.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/normal_order.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/barcode_confirm_order.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../NewOrder/neworder.dart';

class BarcodeOrder extends StatefulWidget {

  String distributor_name,distributor_address,latitude,longitude,home_address,distributor_gst,landmark,city,state,
      person_name,person_mobile,person_tel,opentime,closetime,business_type,type,id;
  List productList;
  List<TextEditingController> selectedQuantity = [];
  List<TextEditingController> orderQuantity = [];
  List<TextEditingController> selectedAmount = [];

  BarcodeOrder({Key key, this.distributor_name,this.distributor_address,this.latitude,this.longitude,this.distributor_gst,this.landmark,
    this.person_name,this.person_mobile,this.person_tel,this.opentime,this.closetime,this.business_type,this.type,this.id,this.home_address,this.city,this.state,
    this.productList,this.selectedQuantity,this.orderQuantity,this.selectedAmount
  }) : super(key: key);

  @override
  State<BarcodeOrder> createState() => _BarcodeOrderState();
}

class _BarcodeOrderState extends State<BarcodeOrder> {

  String orderAddress;
  double totalAmount = 0.0;
  int totalQuentity = 0;

  ProductProvider _productProvider;
  DistributorProvider _distributorProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _distributorProvider = Provider.of<DistributorProvider>(context, listen: false);
    _productProvider = Provider.of<ProductProvider>(context, listen: false);

    getGroup();

    orderAddress = widget.distributor_address;
    for(int i=0;i<widget.selectedAmount.length;i++){

      double singleAmount = double.parse("${widget.selectedAmount[i].text}") * double.parse("${widget.orderQuantity[i].text}");
      totalAmount = totalAmount + singleAmount;

      totalQuentity = totalQuentity + int.parse("${widget.orderQuantity[i].text}");

    }

  }

  TextEditingController _textEditingController1 = new TextEditingController();
  DateTime _selectedDate;


  bool isLoaded = false;

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
                      "group_id":"$groupId",
                      "retailer_id":"${widget.id}"
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
                                                    "hsnigst":"${selectedProductList[i].hsnIgst}",
                                                    "hsncgst":"${selectedProductList[i].hsnCgst}",
                                                    "hsnsgst":"${selectedProductList[i].hsnSgst}",
                                                    "hsn_code":"${selectedProductList[i].hsnCode}",
                                                    "stock":"${selectedProductList[i].available_stock}",
                                                  };

                                                  final index = widget.productList.indexWhere((element) =>
                                                  element['pid'] == product['pid']);
                                                  if (index >= 0) {

                                                  }
                                                  else{
                                                    widget.productList.add(product);
                                                  }


                                                  widget.selectedQuantity.add(TextEditingController(text: "${selectedProductList[i].available_stock}"));
                                                  widget.orderQuantity.add(TextEditingController(text: "${selectedQuantity[i].text}"));
                                                  widget.selectedAmount.add(TextEditingController(text: "${selectedAmount[i].text}"));
                                                }

                                                totalAmount = 0;
                                                totalQuentity = 0;
                                                for(int i=0;i<widget.selectedAmount.length;i++){

                                                  setState((){
                                                    double singleAmount = double.parse("${widget.selectedAmount[i].text}") * double.parse("${widget.orderQuantity[i].text}");
                                                    totalAmount = totalAmount + singleAmount;
                                                    totalQuentity = totalQuentity + int.parse("${widget.orderQuantity[i].text}");
                                                  });

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

  String person_mobile = "";
  getDistributorDetails(FinalAmount,FinalProduct) async {

    var data = {
      "id":"${widget.id}",
    };

    await _distributorProvider.getDistributorDetails(data, "/get_distributer_detail");

    if(_distributorProvider.isSuccess == true){

      if(_distributorProvider.distributorData['mobile'] == ""){
        person_mobile = _distributorProvider.distributorData['mobile'];
      }
      else{
        person_mobile = _distributorProvider.distributorData['telephone'];
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BarcodeConfirmOrder(
        retailerId: widget.id,
        address: orderAddress,
        orderDate: _textEditingController1.text,
        totalAmount: "${FinalAmount}",
        productList: FinalProduct,
          person_mobile: person_mobile,
        retailerName: widget.distributor_name,
      )));

    }

  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _productProvider = Provider.of<ProductProvider>(context, listen: true);
    _distributorProvider = Provider.of<DistributorProvider>(context, listen: true);

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

                              if(_textEditingController1.text == null || _textEditingController1.text == ""){


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
                              else{

                                  double FinalAmount = 0.0;
                                  var FinalProduct = [];

                                  for(int i=0;i<widget.productList.length;i++){

                                    var singleProduct = {
                                      "pid":"${widget.productList[i]['pid']}",
                                      "color_id":"${widget.productList[i]['color_id']}",
                                      "color_code":"${widget.productList[i]['color_code']}",
                                      "sku":"${widget.productList[i]['sku']}",
                                      "amount":"${widget.selectedAmount[i].text}",
                                      "qty":"${widget.orderQuantity[i].text}",
                                      "stock":"${widget.selectedQuantity[i].text}",
                                    };

                                    FinalProduct.add(singleProduct);

                                    double singleAmount = double.parse(widget.selectedAmount[i].text) * double.parse(widget.orderQuantity[i].text);
                                    FinalAmount = FinalAmount + singleAmount;

                                  }

                                  getDistributorDetails(FinalAmount,FinalProduct);

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
        body: Container(
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

                                        SizedBox(height: height*0.01),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height*0.02),
                                            RichText(
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "Retailer Name : ",
                                                          style: textStyle.copyWith(
                                                              fontSize: 16,
                                                              color: AppColors.black,
                                                              fontWeight: FontWeight.bold
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: "${widget.distributor_name}",
                                                          style: textStyle.copyWith(
                                                            fontSize: 16,
                                                            color: AppColors.black,
                                                          )
                                                      )
                                                    ]
                                                )
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Image.asset("assets/images/tasks/location1.png",width: 20,height: 20),
                                                SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    "${widget.distributor_address}",
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
                                                    "+91 ${widget.person_mobile}",
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

                                        Padding(
                                          padding: EdgeInsets.only(left: 20,right: 20,top: 10),
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

                                  SizedBox(height: 20),

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
                                    itemCount: widget.productList.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var productData = widget.productList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [

                                            InkWell(
                                              onTap: (){
                                                setState(() {
                                                  widget.productList.removeAt(index);
                                                  widget.selectedAmount.removeAt(index);
                                                  widget.orderQuantity.removeAt(index);
                                                  widget.selectedQuantity.removeAt(index);

                                                  totalAmount = 0;
                                                  totalQuentity = 0;
                                                  for(int i=0;i<widget.selectedAmount.length;i++){

                                                    double singleAmount = double.parse("${widget.selectedAmount[i].text}") * double.parse("${widget.orderQuantity[i].text}");
                                                    totalAmount = totalAmount + singleAmount;

                                                    totalQuentity = totalQuentity + int.parse("${widget.orderQuantity[i].text}");

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
                                                "${widget.orderQuantity[index].text}",
                                                textAlign: TextAlign.center,
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: Text(
                                                "${widget.selectedAmount[index].text}",
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