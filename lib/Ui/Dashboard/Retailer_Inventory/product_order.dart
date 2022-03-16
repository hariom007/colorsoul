import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/product_order_Screen.dart';
import 'package:colorsoul/Ui/Dashboard/Retailer_Inventory/qr_scanner_page.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
        orderQuantity.add(TextEditingController(text: "${_orderProvider.scanProductDetails['available_stock']}"));
        selectedAmount.add(TextEditingController(text: "${_orderProvider.scanProductDetails['rate']}"));

        final index = viewProduct.indexWhere((element) =>
        element['pid'] == product['pid']);
        if (index >= 0) {

          Fluttertoast.showToast(
              msg: "Product Already Added !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

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

    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

  }

  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _orderProvider = Provider.of<OrderProvider>(context, listen: true);

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

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BarcodeOrder(
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

                  ],
                ),
              ),
              SizedBox(height: height*0.01),

              Expanded(
                child: Container(
                  color: AppColors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        SizedBox(height: height*0.02),

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

                        ListView.builder(
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
