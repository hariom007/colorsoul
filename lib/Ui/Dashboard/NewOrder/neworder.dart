import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Model/Product_Model.dart';
import 'package:colorsoul/Provider/distributor_provider.dart';
import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/confirmorder.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/location_page.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Values/appColors.dart';
import '../../../Values/components.dart';

class NewOrder extends StatefulWidget  {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class TypeModel{
  String id;
  String name;
  String address;
  String mobile;

  TypeModel(this.id, this.name, this.address, this.mobile);
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

  bool isLoaded = true;
  String selectedRetailerId,selectedRetailerName,selectedRetailerAddress,selectedRetailerMobile;
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

      var result  = _distributorProvider.onlyDistributorList;
      var singleDistributor;

      for (var abc in result) {
        singleDistributor = TypeModel(abc.id,abc.name,abc.address,abc.mobile);
        distributor_List.add(singleDistributor);
      }
    }

    setState(() {
      isLoaded = true;
    });

  }

  getProducts() async {
    setState(() {
      isLoaded = false;
    });

    var data ={
      "search_term" : "",
    };
    await _productProvider.getSearchProducts(data,'/searchProductByKeyword');
    setState(() {
      isLoaded = true;
    });

  }


  addNewItem(BuildContext context) {

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
                      "search_term" : "${value}",
                    };
                    await _productProvider.getSearchProducts(data,'/searchProductByKeyword');

                    setState((){
                      isLoading = false;
                    });

                  }

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    height: MediaQuery.of(context).size.height-150,
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
                          child: TextFormField(
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
                                  prefixIcon: new IconButton(
                                    icon: new Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                    onPressed: null,
                                  ),
                                  isDense: true
                              ),
                            onChanged: (value){

                              setState((){
                                _productProvider.searchProductList.clear();
                              });
                              if(_productProvider.isLoaded == true){
                                getProducts(value);
                              }
                              else{

                              }

                            },
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

                                    var product = {
                                      "pid":"${productData.clProductId}",
                                      "name":"${productData.clProductName}",
                                      "image":"${productData.clProductImg[0].hPath}"+"${productData.clProductImg[0].imageName}",
                                      "desc":"${productData.clProductSortDesc}",
                                      "sku":"${productData.clProductSkuCode}",
                                    };
                                    viewProduct.add(product);
                                    viewColors.add(productData.colors);
                                    selectedColorId.add(productData.colors[0].clColorId);
                                    selectedColorCode.add(productData.colors[0].clColorCode);
                                    selectedSkU.add(productData.colors[0].skuCode);
                                    viewQuantity.add(1);
                                    viewAmount.add(TextEditingController());
                                    Navigator.pop(context);

                                  },
                                  child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: round1.copyWith()
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5,bottom: 6),
                                        child: ListTile(
                                          leading: CachedNetworkImage(
                                            imageUrl: "${productData.clProductImg[0].hPath}"+"${productData.clProductImg[0].imageName}",
                                            placeholder: (context, url) => Container(
                                              width: 70,
                                              height: 70,
                                              child: Center(
                                                  child: SpinKitThreeBounce(
                                                    color: AppColors.black,
                                                    size: 25.0,
                                                  )
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                            width: 70,
                                            height: 70,
                                          ),
                                          title: Padding(
                                            padding: EdgeInsets.only(top: 6),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Gel Nail Polish',
                                                    style: textStyle.copyWith(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),

                                                Text(
                                                    "In Stock",
                                                    style: textStyle.copyWith(
                                                        fontSize: 12,
                                                        color: Color.fromRGBO(0, 169, 145, 1),
                                                        fontWeight: FontWeight.bold
                                                    )
                                                ),

                                              ],
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 2),
                                                Text(
                                                  'Lorem ipsum dolor sit amet. ipsum dolor.',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textStyle.copyWith(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
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
        print("Product Added");
      });
    });
  }

  List viewProduct = [];
  List viewColors = [];
  List selectedColorId = [];
  List selectedColorCode = [];
  List selectedSkU = [];
  List<TextEditingController> viewAmount = [];
  List<int> viewQuantity = [];

  List finalProduct = [];
  double TotalAmount = 0.0;

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

                        var FinalProduct = [];
                        for(int i=0;i<viewProduct.length;i++){

                          var singleProduct = {
                            "pid":"${viewProduct[i]['pid']}",
                            "color_id":"${selectedColorId[i]}",
                            "color_code":"${selectedColorCode[i]}",
                            "sku":"${selectedSkU[i]}",
                            "amount":"${viewAmount[i].text}",
                            "qty":"${viewQuantity[i]}"
                          };
                          FinalProduct.add(singleProduct);

                        }
                        //print(FinalProduct);

                        double FinalAmount = 0.0;
                        for(int i=0;i<FinalProduct.length;i++){
                          double singleAmount = double.parse(FinalProduct[i]['amount']) * double.parse(FinalProduct[i]['qty']);
                          FinalAmount = FinalAmount + singleAmount;
                        }

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmOrder(
                          retailerId: selectedRetailerId,
                          address: selectedRetailerAddress,
                          orderDate: _textEditingController1.text,
                          totalAmount: "${FinalAmount}",
                          productList: FinalProduct,
                        )));

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
                                    "Retailer Name",
                                    style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(height: height*0.01),
                                  Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.black
                                        ),
                                        borderRadius: round,
                                      ),
                                      child: Listener(
                                        onPointerDown: (_) {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: DropdownBelow<TypeModel>(
                                            itemWidth: width/1.3,
                                            itemTextstyle:textStyle.copyWith(
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                            boxTextstyle: textStyle.copyWith(
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                            boxWidth: width,
                                            boxHeight: 50,
                                            icon: Image.asset('assets/images/locater/down.png',width: 14),
                                            hint: Text('Select Retailer'),
                                            value: distributorList,
                                            onChanged: (TypeModel t){

                                              setState(()  {
                                                distributorList = t;
                                                print(t.id);
                                                selectedRetailerId = t.id;
                                                selectedRetailerName = t.name;
                                                selectedRetailerAddress = t.address;
                                                selectedRetailerMobile = t.mobile;
                                                isvisible = true;
                                                isvisible1 = true;
                                              });

                                            },
                                            items: distributor_List.map((TypeModel t) {
                                              return DropdownMenuItem<TypeModel>(
                                                value: t,
                                                child: Text(t.name),
                                              );
                                            }).toList(),
                                          ),
                                        ),
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
                                    "Title",
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
                                        selectedRetailerAddress = fullAddress[0];

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
                                                      "$selectedRetailerAddress",
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
                                        "Date",
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
                                              isDense: true
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

                                          addNewItem(context);

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.add),
                                        ),
                                      )


                                    ],
                                  ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(top: 10),
                                    itemCount: viewProduct.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: round1.copyWith()
                                            ),
                                            child: Slidable(
                                              actionExtentRatio: 0.14,
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
                                                padding: EdgeInsets.only(top: 5,bottom: 6),
                                                child: Column(
                                                  children: [

                                                    ListTile(
                                                      leading:
                                                      CachedNetworkImage(
                                                        imageUrl: "${viewProduct[index]['image']}",
                                                        placeholder: (context, url) => Container(
                                                          width: 70,
                                                          height: 70,
                                                          child: Center(
                                                              child: SpinKitThreeBounce(
                                                                color: AppColors.black,
                                                                size: 25.0,
                                                              )
                                                          ),
                                                        ),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                        width: 70,
                                                        height: 70,
                                                      ),
                                                      title: Padding(
                                                        padding: EdgeInsets.only(top: 6),
                                                        child: Text(
                                                          "${viewProduct[index]['name']}",
                                                          style: textStyle.copyWith(
                                                              fontSize: 16,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(height: 2),
                                                          Html(
                                                            shrinkWrap: true,
                                                            data: "${viewProduct[index]['desc']}",
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
                                                          Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              InkWell(
                                                                onTap: (){
                                                                  setState(() {
                                                                    if(viewQuantity[index] == 1)
                                                                    {
                                                                      null;
                                                                    }
                                                                    else
                                                                    {
                                                                      viewQuantity[index] = viewQuantity[index] - 1;
                                                                    }
                                                                  });
                                                                },
                                                                child: Container(
                                                                  padding: EdgeInsets.all(4),
                                                                  height: 20,
                                                                  width: 20,
                                                                  decoration: BoxDecoration(
                                                                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft: Radius.circular(6),
                                                                        bottomRight: Radius.circular(6),
                                                                        topRight: Radius.circular(6)
                                                                    ),
                                                                  ),
                                                                  child: Image.asset("assets/images/neworder/minus.png"),
                                                                ),
                                                              ),
                                                              SizedBox(width: 8),
                                                              Text(
                                                                "${viewQuantity[index]}",
                                                                style: textStyle.copyWith(
                                                                    color: AppColors.black,
                                                                    fontSize: 18
                                                                ),
                                                              ),
                                                              SizedBox(width: 8),
                                                              InkWell(
                                                                onTap: (){

                                                                  setState(() {
                                                                    viewQuantity[index] = viewQuantity[index] + 1;
                                                                  });

                                                                },
                                                                child: Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  padding: EdgeInsets.all(4),
                                                                  decoration: BoxDecoration(
                                                                    gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft: Radius.circular(6),
                                                                        bottomRight: Radius.circular(6),
                                                                        topRight: Radius.circular(6)
                                                                    ),
                                                                  ),
                                                                  child: Image.asset("assets/images/add.png"),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),
                                                      child: Row(
                                                        children: [

                                                          Expanded(
                                                            child: GridView.builder(
                                                                padding: EdgeInsets.zero,
                                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount: 6,
                                                                    crossAxisSpacing: 10.0,
                                                                    mainAxisSpacing: 10.0,
                                                                    childAspectRatio: 1
                                                                ),
                                                                shrinkWrap: true,
                                                                itemCount: viewColors[index].length,
                                                                itemBuilder: (context, index1){
                                                                  var colorData = viewColors[index][index1];
                                                                  return InkWell(
                                                                    onTap: (){

                                                                      setState(() {
                                                                        selectedColorId[index] = colorData.clColorId;
                                                                        selectedColorCode[index] = colorData.clColorCode;
                                                                        selectedSkU[index] = colorData.skuCode;
                                                                      });

                                                                    },
                                                                    child:
                                                                    selectedColorId[index] == colorData.clColorId
                                                                        ?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          border: Border.all(color: AppColors.black,width: 1)
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(2.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: HexColor("${colorData.hashCode}"),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                        :
                                                                    Container(
                                                                      padding: EdgeInsets.all(2.5),
                                                                      height: 24,
                                                                      width: 24,
                                                                      decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: HexColor("${colorData.hashCode}"),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                            ),
                                                          ),

                                                          Row(
                                                            children: [

                                                              Text("₹",style: textStyle.copyWith(
                                                                  color: AppColors.black,
                                                                  fontSize: 24
                                                              )),

                                                              SizedBox(width: 14),

                                                              Container(
                                                                width: 70,
                                                                child: TextFormField(
                                                                  controller: viewAmount[index],
                                                                  style: textStyle.copyWith(
                                                                      fontSize: 16,
                                                                      color: Colors.black
                                                                  ),
                                                                  cursorHeight: 22,
                                                                  cursorColor: Colors.grey,
                                                                  decoration: InputDecoration(
                                                                      enabledBorder: UnderlineInputBorder(),
                                                                    isDense: true,
                                                                    hintText: "Amount",
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            )
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height*0.01),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "Order Amount",
                                  //       style: textStyle.copyWith(
                                  //           color: Colors.black,
                                  //           fontSize: 18
                                  //       ),
                                  //     ),
                                  //     Expanded(child: Container()),
                                  //     Text(
                                  //       "₹${TotalAmount.toStringAsFixed(2)}",
                                  //       style: textStyle.copyWith(
                                  //         color: Colors.black,
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 20
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(height: height*0.02),
                                ],
                              ),
                            ),
                          )
                      ),
                    )
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

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController1 = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    }
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}