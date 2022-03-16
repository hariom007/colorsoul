import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class RetailerProductPage extends StatefulWidget {

  String retailerId;
  RetailerProductPage({Key key,this.retailerId}) : super(key: key);

  @override
  State<RetailerProductPage> createState() => _RetailerProductPageState();
}

class _RetailerProductPageState extends State<RetailerProductPage> {

  ProductProvider _productProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _productProvider = Provider.of<ProductProvider>(context, listen: false);

    getProducts();

  }

  getProducts() async {
    var data =
    {
      "retailer_id":"${widget.retailerId}"
    };
    await _productProvider.getRetailerProducts(data,"/get_retailer_product");
  }



  @override
  Widget build(BuildContext context) {

    _productProvider = Provider.of<ProductProvider>(context, listen: true);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.05),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Retailers Products",
                  style: textStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: height*0.01),
              Expanded(
                  child:
                  Container(
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

                            _productProvider.isLoaded == false
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

                            Expanded(
                              child: NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification overscroll) {
                                  overscroll.disallowGlow();
                                  return;
                                },
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        itemCount: _productProvider.retailerProduct.length,
                                        shrinkWrap: true,
                                        itemBuilder:(context, index){
                                          var productData = _productProvider.retailerProduct[index];
                                          return Padding(
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
                                                      "${productData.clProductShortname}",
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
                                                            Expanded(
                                                              child: Text(
                                                                "${productData.colors.skuCode}",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: textStyle.copyWith(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Total Stock : ${productData.totalStock}",
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: textStyle.copyWith(
                                                                fontSize: 14,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ),
                                          );
                                        },
                                      ),

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
      ),
    );
  }
}
