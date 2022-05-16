import 'dart:async';

import 'package:colorsoul/Model/Product_Model.dart';
import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/product_order_Screen.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/qr_scanner_page.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class ProductOrder extends StatefulWidget {

  String distributor_name,distributor_address,latitude,longitude,home_address,distributor_gst,landmark,city,state,
      person_name,person_mobile,person_tel,opentime,closetime,business_type,type,id;
  ProductOrder({Key key, this.distributor_name,this.distributor_address,this.latitude,this.longitude,this.distributor_gst,this.landmark,
    this.person_name,this.person_mobile,this.person_tel,this.opentime,this.closetime,this.business_type,this.type,this.id,this.home_address,this.city,this.state
  }) : super(key: key);

  @override
  State<ProductOrder> createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {

  String barcodeScanRes;
  List viewProduct = [];
  List<TextEditingController> selectedQuantity = [];
  List<TextEditingController> orderQuantity = [];
  List<TextEditingController> selectedAmount = [];

  addProducts() async {

    var data = {
      "barcode":"$barcodeScanRes",
      "retailer_id":"${widget.id}"
    };
    await _orderProvider.getScanProductDetails(data,'/get_barcode_product');
    if(_orderProvider.isProductSuccess == true){

      setState(() {

        var product = {
          "pid":"${_orderProvider.scanProductDetails['cl_product_id']}",
          "short":"${_orderProvider.scanProductDetails['cl_product_shortname']}",
          "color_id":"${_orderProvider.scanProductDetails['colors']['cl_color_id']}",
          "color_code":"${_orderProvider.scanProductDetails['colors']['cl_color_code']}",
          "sku":"${_orderProvider.scanProductDetails['colors']['sku_code']}",
          "hsnigst":"${_orderProvider.scanProductDetails['hsn_igst']}",
          "hsncgst":"${_orderProvider.scanProductDetails['hsn_cgst']}",
          "hsnsgst":"${_orderProvider.scanProductDetails['hsn_sgst']}",
          "hsn_code":"${_orderProvider.scanProductDetails['hsn_code']}",
          "stock":"${_orderProvider.scanProductDetails['available_stock']}",
        };
        selectedQuantity.add(TextEditingController(text: "0"));

        if("${_orderProvider.scanProductDetails['available_stock']}" == "0"){
          orderQuantity.add(TextEditingController(text: "1"));
        }
        else{
          orderQuantity.add(TextEditingController(text: "${_orderProvider.scanProductDetails['available_stock']}"));
        }

        if("${_orderProvider.scanProductDetails['rate']}" == "0"){
          selectedAmount.add(TextEditingController(text: "1"));
        }
        else{
          selectedAmount.add(TextEditingController(text: "${_orderProvider.scanProductDetails['rate']}"));
        }

        final index = viewProduct.indexWhere((element) =>
        element['pid'] == product['pid']);
        if (index >= 0) {

          setState(() {
            int value = int.parse(orderQuantity[index].text) + 1;
            print(value);
            orderQuantity[index] = TextEditingController(text: "${value}");
          });

        /*  Fluttertoast.showToast(
              msg: "Product Already Added !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );*/

          print("Product Already Added");
        }
        else{
          viewProduct.add(product);
        }

      });

      print(_orderProvider.scanProductDetails["available_stock"]);
      print(_orderProvider.scanProductDetails["cl_product_name"]);
    }

  }

  OrderProvider _orderProvider;
  @override
  void initState() {
    super.initState();

    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

    getGroup();

  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController allQuantity = TextEditingController();
  TextEditingController allPrice = TextEditingController();
  TextEditingController allCurrent = TextEditingController();


  ProductProvider _productProvider;

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

                                          for(int j=0;j<showProductList.length;j++){

                                            if(checkBoxList[i]['id'] == showProductList[j].clProductId){

                                              setState((){

                                                var product = {
                                                  "pid":"${showProductList[i].clProductId}",
                                                  "short":"${showProductList[i].clProductShortname}",
                                                  "color_id":"${showProductList[i].colors[0].clColorId}",
                                                  "color_code":"${showProductList[i].colors[0].clColorCode}",
                                                  "sku":"${showProductList[i].colors[0].skuCode}",
                                                  "hsnigst":"${showProductList[i].hsnIgst}",
                                                  "hsncgst":"${showProductList[i].hsnCgst}",
                                                  "hsnsgst":"${showProductList[i].hsnSgst}",
                                                  "hsn_code":"${showProductList[i].hsnCode}",
                                                  "stock":"${showProductList[i].available_stock}",
                                                };
                                                selectedQuantity.add(TextEditingController(text: "0"));
                                                orderQuantity.add(TextEditingController(text: "${showProductList[i].available_stock}"));
                                                selectedAmount.add(TextEditingController(text: "${showProductList[i].rate}"));

                                                final index = viewProduct.indexWhere((element) =>
                                                element['pid'] == product['pid']);
                                                if (index >= 0) {

                                                }
                                                else{
                                                  viewProduct.add(product);
                                                }


                                              });

                                            }

                                          }

                                        }
                                      }

                                      Navigator.pop(context);
                                      Navigator.pop(context);

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



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _orderProvider = Provider.of<OrderProvider>(context, listen: true);
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

                            if(_formkey.currentState.validate()){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => BarcodeOrder(
                                distributor_name: "${widget.distributor_name}",
                                distributor_address: "${widget.distributor_address}",
                                latitude: widget.latitude,
                                longitude: widget.longitude,
                                person_name: "${widget.person_name}",
                                home_address: "${widget.home_address}",
                                landmark: "${widget.landmark}",
                                person_mobile: "${widget.person_mobile}",
                                person_tel: "${widget.person_tel}",
                                business_type: "${widget.business_type}",
                                distributor_gst: "${widget.distributor_gst}",
                                opentime: "${widget.opentime}",
                                closetime: "${widget.closetime}",
                                type: "${widget.type}",
                                id: "${widget.id}",
                                state: "${widget.state}",
                                city:"${widget.city}",
                                productList: viewProduct,
                                selectedAmount: selectedAmount,
                                selectedQuantity: selectedQuantity,
                                orderQuantity: orderQuantity,
                              )));

                            }

                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: Colors.transparent,
                              shape: StadiumBorder()
                          ),
                          child: Text('Order',
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
      body: Form(
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

              SizedBox(height: height*0.04),
              Padding(
                padding: EdgeInsets.only(left: 15,right: 5),
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

                    Expanded(
                      child: Center(
                        child: Text(
                          "Add Product",
                          style: textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                    TextButton(
                        onPressed: () async {

                          final value = await Navigator.push(context, MaterialPageRoute(builder: (context) => qrScannerPage()));
                          if(value != null){
                            setState(() {
                              barcodeScanRes = value;
                            });

                            addProducts();

                          }

                        },
                        child: Image.asset("assets/images/barcodenew.png",height: 30,color: AppColors.white)
                    ),

                    InkWell(
                      onTap: (){

                        selectGroup(context);

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add,color: AppColors.white,size: 30,),
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: height*0.01),

              Expanded(
                child: Container(
                  color: AppColors.white,
                  child:
                  isLoaded == false
                      ?
                  Center(
                      child: SpinKitThreeBounce(
                        color: AppColors.black,
                        size: 25.0,
                      )
                  )
                      :
                  SingleChildScrollView(
                    child: Column(
                      children: [

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
                                  "Current\nStock",
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
                                  "Order\nStock",
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

                        SizedBox(height: height*0.01),

                        Divider(
                            height: 20,
                            color: Color.fromRGBO(185, 185, 185, 0.75),
                            thickness: 1.2
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 10),
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

/*
                              Container(
                                width: 80,
                                child: TextFormField(
                                  controller: allCurrent,
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

                                    setState(() {
                                      selectedQuantity.clear();
                                    });
                                    for(int i =0;i<viewProduct.length;i++){
                                      if(value.isEmpty){
                                        setState(() {
                                          TextEditingController controller = TextEditingController(text: "0");
                                          selectedQuantity.add(controller);
                                        });

                                      }
                                      else{
                                        setState(() {
                                          TextEditingController controller = TextEditingController(text: "$value");
                                          selectedQuantity.add(controller);

                                      */
/*    if(viewProduct[i]['stock'] != "0"){

                                            int orderQ = int.parse(viewProduct[i]['stock']) - int.parse(selectedQuantity[i].text);
                                            setState(() {
                                              orderQuantity[i] = TextEditingController(
                                                  text: "$orderQ"
                                              );
                                            });

                                          }
*//*

                                        });

                                      }

                                    }

                                  },
                                ),
                              ),

                              SizedBox(width: 10),
*/

                              Container(
                                width: 70,
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
                                  textAlign: TextAlign.center,
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

                                    setState(() {
                                      orderQuantity.clear();
                                    });
                                    for(int i =0;i<viewProduct.length;i++){
                                      if(value.isEmpty){
                                        setState(() {
                                          TextEditingController controller = TextEditingController(text: "0");
                                          orderQuantity.add(controller);
                                        });

                                      }
                                      else{
                                        setState(() {
                                          TextEditingController controller = TextEditingController(text: "$value");
                                          orderQuantity.add(controller);
                                        });

                                      }

                                    }

                                  },
                                ),
                              ),

                              SizedBox(width: 15),

                              Container(
                                width: 70,
                                child: TextFormField(
                                  controller: allPrice,
                                  keyboardType: TextInputType.number,
                                  style: textStyle.copyWith(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  cursorHeight: 22,
                                  cursorColor: Colors.grey,
                                  textAlign: TextAlign.center,
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
                                    });

                                    for(int i =0;i<viewProduct.length;i++){
                                      if(value.isEmpty){

                                        setState(() {
                                          TextEditingController controller = TextEditingController(text: "0");
                                          selectedAmount.add(controller);
                                        });

                                      }
                                      else{

                                        setState(() {
                                          TextEditingController controller = TextEditingController(text: "$value");
                                          selectedAmount.add(controller);
                                        });

                                      }
                                    }

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: height*0.01),

                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 10,left: 10,right: 10),
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
                                        selectedQuantity.removeAt(index);
                                        orderQuantity.removeAt(index);
                                        selectedAmount.removeAt(index);
                                      });

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.close),
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  Expanded(
                                    child: Text(
                                      "${productData['sku']}",
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
                                        errorStyle: TextStyle(height: 0,fontSize: 0),
                                      ),
                                      onChanged: (value){

                                        if(productData['stock'] != "0"){

                                          int orderQ = int.parse(productData['stock']) - int.parse(selectedQuantity[index].text);
                                          setState(() {
                                            orderQuantity[index] = TextEditingController(
                                              text: "$orderQ"
                                            );
                                          });

                                        }

                                      },
                                    ),
                                  ),

                                  SizedBox(width: 15),

                                  Container(
                                    width: 70,
                                    child: TextFormField(
                                      controller: orderQuantity[index],
                                      keyboardType: TextInputType.number,
                                      validator: (String value) {
                                        if(value == "0")
                                        {
                                          return "Enter Quantity";
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
                                        errorStyle: TextStyle(height: 1,fontSize: 10),
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
                                        if(value == "0")
                                        {
                                          return "Enter Amount";
                                        }
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
                                        errorStyle: TextStyle(height: 1,fontSize: 10),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),

              )



            ],
          ),
        ),
      ),
    );

  }
}
