import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorsoul/Provider/product_provider.dart';
import 'package:colorsoul/Ui/Dashboard/Products/productsfilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../../Values/appColors.dart';
import '../../../Values/colorselect.dart';
import '../../../Values/components.dart';
import 'productinfo.dart';

class ProductsData extends StatefulWidget {

  String categoryId;
  ProductsData({Key key,this.categoryId}) : super(key: key);

  @override
  _ProductsDataState createState() => _ProductsDataState();
}

class _ProductsDataState extends State<ProductsData> {
  String value = '1';
  bool isFavorite = false;

  ProductProvider _productProvider;
  ScrollController _scrollViewController =  ScrollController();
  bool isScrollingDown = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.productList.clear();
    getProducts(searchController.text);

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {

          isScrollingDown = true;
          setState(() {
            page = page + 1;
            getProducts(searchController.text);
          });
        }
      }
    });

  }

  int page = 1;
  getProducts(String searchValue) async {
    var data ={
      "search_term":searchValue,
      "cat_id":"${widget.categoryId}"
    };
    await _productProvider.getProducts(data,'/getProduct/$page');
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _productProvider = Provider.of<ProductProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0,0,0,0.9],colors: [AppColors.grey1,AppColors.grey1,AppColors.grey1,AppColors.grey2]),
                    borderRadius: round1.copyWith(
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(0)
                    ),
                    boxShadow: [new BoxShadow(
                      color: Color.fromRGBO(0,0,0, 0.5),
                      offset: Offset(0, 6),
                      blurRadius: 5,
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          cursorColor: AppColors.black,
                          cursorHeight: 24,
                          controller: searchController,
                          onChanged: (value){

                            if(_productProvider.isLoaded == true){
                              setState(() {
                                _productProvider.productList.clear();
                              });

                              getProducts(searchController.text);
                            }

                          },
                          decoration: InputDecoration(
                              hintText: "Search Product",
                              hintStyle: textStyle.copyWith(
                                  color: AppColors.black
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                      Navigator.pop(context);
                                      },
                                      icon: Image.asset('assets/images/productsdata/back1.png',width: 20,height: 20),
                                    ),
                                    SizedBox(width: 10),
                                    Image.asset('assets/images/locater/search.png',width: 20,height: 20),
                                  ],
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Image.asset('assets/images/productsdata/mic.png',width: 26,height: 26),
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
                              isDense: true,
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                children: [
                  Container(
                      height: height*0.04,
                      width: width/2.8,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey3,AppColors.black]),
                          borderRadius: round.copyWith()
                      ),
                      child:  Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: DropdownButton<String>(
                          icon: Image.asset('assets/images/productsdata/down1.png',width: 16),
                          isExpanded: true,
                          value: value,
                          borderRadius: round.copyWith(),
                          dropdownColor: AppColors.black,
                          style: textStyle.copyWith(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold
                          ),
                          underline: SizedBox(),
                          items: [
                            DropdownMenuItem(
                                value: "1",
                                child: Text("Popularity")
                            ),
                            DropdownMenuItem(
                                value: "2",
                                child: Text("Relevance")
                            ),
                            DropdownMenuItem(
                                value: "3",
                                child: Text("Low to High")
                            ),
                            DropdownMenuItem(
                                value: "4",
                                child: Text("High to Low")
                            ),
                            DropdownMenuItem(
                                value: "5",
                                child: Text("Newest First")
                            ),
                          ],
                          onChanged: (_value) {
                            setState((){
                              value = _value;
                            });
                          },
                        ),
                      )
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductsFilter()
                          )
                      );
                    },
                    child: Image.asset("assets/images/productsdata/filter1.png",width: 26,height: 26)
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child:

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    GridView.builder(
                      controller: _scrollViewController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 3/4.6
                        ),
                        shrinkWrap: true,
                        itemCount: _productProvider.productList.length,
                        padding: EdgeInsets.only(right: 10,left: 10,bottom: 20),
                        itemBuilder: (context, index){
                          var productData = _productProvider.productList[index];
                          return Card(
                            color: Colors.transparent,
                            elevation: 13,
                            child: InkWell(
                              onTap: (){
                                setState(() {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(
                                      name: productData.clProductName,
                                      colors: productData.colors,
                                    images: productData.clProductImg,
                                    shortDecs: productData.clProductSortDesc,
                                    longDesc: productData.clProductDesc,
                                    specification: productData.pattributes,
                                  )
                                  ));


                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: round1.copyWith()
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      productData.clProductImg.length != 0
                                          ?
                                      Center(
                                        child:
                                        Hero(
                                            tag: '${productData.clProductId}',
                                            child:
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(6),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                  productData.clProductImg.length != 0
                                                      ?
                                                  "${productData.clProductImg[0].hPath}"+"${productData.clProductImg[0].imageName}"
                                                  :
                                                      "",
                                                  placeholder: (context, url) => Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 140,
                                                    child: Center(
                                                        child: SpinKitThreeBounce(
                                                          color: AppColors.black,
                                                          size: 25.0,
                                                        )
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                  width: 140,
                                                  height: 140,
                                              ),
                                            ),
                                        ),
                                      )
                                      :
                                      Container(
                                        height: 140,
                                          child: Center(child: Icon(Icons.error))
                                      ),

                                      SizedBox(height: 10),

                                      Row(
                                        children: [

                                          productData.colors.length >= 3
                                              ?
                                          Row(
                                            children: [

                                              Container(
                                                padding: EdgeInsets.all(2.5),
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("${productData.colors[0].hexCode}"),
                                                ),
                                              ),

                                              SizedBox(width: 6),

                                              Container(
                                                padding: EdgeInsets.all(2.5),
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("${productData.colors[1].hexCode}"),
                                                ),
                                              ),

                                              SizedBox(width: 6),

                                              Container(
                                                padding: EdgeInsets.all(2.5),
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("${productData.colors[2].hexCode}"),
                                                ),
                                              ),

                                            ],
                                          )
                                              :
                                          productData.colors.length == 2
                                              ?
                                          Row(
                                            children: [

                                              Container(
                                                padding: EdgeInsets.all(2.5),
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("${productData.colors[0].hexCode}"),
                                                ),
                                              ),

                                              SizedBox(width: 6),

                                              Container(
                                                padding: EdgeInsets.all(2.5),
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("${productData.colors[1].hexCode}"),
                                                ),
                                              ),


                                            ],
                                          )
                                              :
                                          productData.colors.length == 1
                                              ?
                                          Row(
                                            children: [

                                              Container(
                                                padding: EdgeInsets.all(2.5),
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("${productData.colors[0].hexCode}"),
                                                ),
                                              ),

                                            ],
                                          )
                                              :
                                          SizedBox(),

                                          SizedBox(width: 10),

                                          productData.colors.length > 3
                                              ?
                                          Text(
                                            "+${productData.colors.length - 3}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                            ),
                                          )
                                              :
                                              SizedBox()

                                        ],
                                      ),


                                      SizedBox(height: 10),

                                      Text(
                                        "${productData.clProductName.toUpperCase()}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),

                                      Html(
                                        shrinkWrap: true,
                                        data: '${productData.clProductSortDesc}',
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
                                ),
                              ),
                            ),
                          );
                        }
                    ),

                    _productProvider.isLoaded == false
                        ?
                    Center(
                        child: SpinKitThreeBounce(
                          color: AppColors.black,
                          size: 25.0,
                        )
                    )
                        :
                        SizedBox()

                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}