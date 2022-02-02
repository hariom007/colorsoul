import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../Values/components.dart';
import 'productsdata.dart';

class Products extends StatefulWidget {
   @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {


  ProductProvider _productProvider;
  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();

    _productProvider = Provider.of<ProductProvider>(context, listen: false);

    getProductCategory();

  }

  int page = 1;
  getProductCategory() async {
    await _productProvider.getProductCategory('/getCatagories');
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _productProvider = Provider.of<ProductProvider>(context, listen: true);

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
              children: [
                SizedBox(height: height*0.062),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Product List",
                      style: textStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
                SizedBox(height: height*0.02),
                Container(
                  height: 50,
                  width: width-30,
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
                                  hintText: "Search Product",
                                  hintStyle: textStyle.copyWith(
                                      color: AppColors.black
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
                        SizedBox(
                            height: 50,
                            width: 80,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                                  borderRadius: round.copyWith()
                              ),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      shadowColor: Color.fromRGBO(0,0,0,.2),
                                      primary: Colors.transparent,
                                      shape: StadiumBorder()
                                  ),
                                  child: Image.asset("assets/images/products/search1.png",width: 20)
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.03),
                Expanded(
                  child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                      child:
                      _productProvider.isLoaded == false
                          ?
                      Center(
                          child: SpinKitThreeBounce(
                            color: AppColors.black,
                            size: 25.0,
                          )
                      )
                          :
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                              childAspectRatio: 1
                          ),
                          shrinkWrap: true,
                          itemCount: _productProvider.productCategoryList.length,
                          padding: EdgeInsets.only(top: 20,right: 20,left: 20,bottom: 70),
                          itemBuilder: (context, index){
                            var productCategoryData = _productProvider.productCategoryList[index];
                            return Card(
                              color: Colors.transparent,
                              elevation: 10,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductsData(
                                            categoryId: productCategoryData.catId,
                                          )
                                      )
                                  );
                                },
                                child: Container(
                                  height: width/2.5,
                                  width: width/2.5,
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: round1.copyWith()
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),

                                      CachedNetworkImage(
                                        imageUrl: "${productCategoryData.image}",
                                        placeholder: (context, url) => Center(
                                            child: SpinKitThreeBounce(
                                              color: AppColors.black,
                                              size: 25.0,
                                            )
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        height: 80
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "${productCategoryData.name}",
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
