import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class ProductOrder extends StatefulWidget {
  const ProductOrder({Key key}) : super(key: key);

  @override
  State<ProductOrder> createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
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
                      onPressed: (){



                      },
                      child: Image.asset("assets/images/barcodenew.png",height: 30,color: AppColors.white)
                  ),

                ],
              ),
            ),
            SizedBox(height: height*0.01),

          ],
        ),
      ),
    );

  }
}
