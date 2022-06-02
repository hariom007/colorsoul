import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:colorsoul/Provider/order_provider.dart';
import 'package:colorsoul/Ui/Dashboard/NewOrder/Pdf/savefile.dart';
import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';


class BarcodeConfirmOrder extends StatefulWidget {

  List productList = [];
  List ProductName = [];
  String orderid,retailerId,address,orderDate,totalAmount,totalQuantity,person_mobile,mobile_number,retailerName;

  BarcodeConfirmOrder({Key key,this.orderid,this.productList,this.retailerId,this.address,this.mobile_number,
    this.totalAmount,this.orderDate,this.person_mobile,this.retailerName,this.ProductName,this.totalQuantity
  }) : super(key: key);

  @override
  State<BarcodeConfirmOrder> createState() => _BarcodeConfirmOrderState();
}

class _BarcodeConfirmOrderState extends State<BarcodeConfirmOrder> {
  OrderProvider _orderProvider;
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
  }

  createOrder() async {

    setState(() {
      isloading = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "id":"",
      "uid":"$userId",
      "retailer_id":"${widget.retailerId}",
      "address":"${widget.address}",
      "order_date":"${widget.orderDate}",
      "items": widget.productList,
      "total":"${widget.totalAmount}",
      "note":"${noteController.text}"
    };
    
   // print(jsonEncode(data));

    await _orderProvider.insertBarcodeOrder(data, "/new_order");

    print("Order page ${_orderProvider.isBarcode}");
    if(_orderProvider.isBarcode == true){

      getOrders();

    }
    else{
      Fluttertoast.showToast(
          msg: "Create Order Error !!\nPlease Try Again Later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  int page = 1;
  bool isloading = false;
  getOrders() async {

    setState(() {
      isloading = true;
    });

    setState(() {
      _orderProvider.orderList.clear();
      _orderProvider.incompleteOrderList.clear();
      _orderProvider.completeOrderList.clear();
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.get("userId");

    var data = {
      "uid":"$userId",
      "from_date":"",
      "to_date":"",
      "status":""
    };
    await _orderProvider.getAllOrders(data,'/getOrder/$page');


    var data1 = {
      "uid":"$userId",
      "from_date":"",
      "to_date":"",
      "status":"Pending"
    };
    await _orderProvider.getIncompleteOrders(data1,'/getOrder/$page');


    var data2 = {
      "uid":"$userId",
      "from_date":"",
      "to_date":"",
      "status":"Delivered"
    };
    await _orderProvider.getCompleteOrders(data2,'/getOrder/$page');

    setState(() {
      isloading = false;
    });

    pagecount();

    Navigator.pop(context);
    Navigator.pop(context);
  }


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
                  child:
                  isloading == true
                      ?
                  Center(
                      child: SpinKitThreeBounce(
                        color: AppColors.black,
                        size: 25.0,
                      )
                  )
                      :
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:SizedBox(
                        height: 50,
                        width: width,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors:
                              [AppColors.grey3,AppColors.black]),
                              borderRadius: round.copyWith()
                          ),
                          child: ElevatedButton(
                            onPressed: () {

                              createOrder();
                              //pagecount();

                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: Colors.transparent,
                                shape: StadiumBorder()
                            ),
                            child: Text('Confirm',
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
                      child: Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (OverscrollIndicatorNotification overscroll) {
                              overscroll.disallowGlow();
                              return;
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: height*0.03),
                                  Text(
                                    "Order Amount",
                                    style: textStyle.copyWith(
                                        color: AppColors.black,
                                        fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "₹ ${double.parse(widget.totalAmount).toStringAsFixed(2)}",
                                    style: textStyle.copyWith(
                                        color: AppColors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    "___",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 34,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  /*Text(
                                    "Delivery Date : December 18, 2021",
                                    style: textStyle.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),*/
                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),
                                  Row(
                                    children: [
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
                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),

                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(top: 10),
                                    itemCount: widget.productList.length,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      var productData = widget.productList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
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

                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),

                                  SizedBox(height: 10),

                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Amount",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                              "₹ ${double.parse(widget.totalAmount).toStringAsFixed(2)}",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Text(
                                              "Delivery Charges",
                                              style: textStyle.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Text(
                                              "Free",
                                              style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                      height: 20,
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 1.2
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Total Amount",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          "₹ ${double.parse(widget.totalAmount).toStringAsFixed(2)}",
                                          //"₹ ${widget.totalAmount}",
                                          style: textStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Remark",
                                      style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height*0.01),
                                  TextFormField(
                                      controller: noteController,
                                      style: textStyle.copyWith(
                                          color: AppColors.black
                                      ),
                                      cursorColor: AppColors.black,
                                      cursorHeight: 22,
                                      decoration: fieldStyle1.copyWith(
                                          hintText: "Add Remark",
                                          hintStyle: textStyle.copyWith(
                                              color: AppColors.black
                                          ),
                                          isDense: true
                                      )
                                  ),
                                  SizedBox(height: height*0.01),
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

  String url = "";
  sendImage(path) async {

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "4ccda7514adc0f13595a585205fb9761"
    };

    final uri = 'https://colorsoul.koffeekodes.com/admin/Api/imageUpload';
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll(headers);

    request.fields['folder'] = "profile";
    request.files.add(await http.MultipartFile.fromPath('file', path));

    request.send().then((response) async {
      var res = await response.stream.bytesToString();
      print(res);
      var body = json.decode(res);

      if (response.statusCode == 200 && body['st'] == "success") {

        print("Upload done");

        url = body['file'];
        sendOnWhatsapp(url);
      }
      else{

        Fluttertoast.showToast(
            msg: "Pdf Upload Error !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    });

  }

  sendOnWhatsapp(String url) async {

    var data = {

      "key": "fd3b0043e7a54dffa1778d00a9e8828e",
      "to": "91${widget.person_mobile}",
      "url": url,
      "filename": "Invoice_No_${_orderProvider.orderId}.pdf",
      "isUrgent": true
    };
    await _orderProvider.SendWhatsapp(data,'http://smartwhatsapp.dove-sms.com/api/v1/sendDocument');
    if(_orderProvider.isSendWhatsapp == true){
      print("Send On Whatsapp done");
    }
  }

  pagecount(){

    double a = widget.productList.length/25;
    //print(a%4);
    if((a)%1 == 0){
      pageLength = a.toInt();
    }
    else{
      pageLength = a.toInt()+1;
    }
    //print(pageLength);

    if(pageLength==0){
      pageLength=1;
    }

    _createPDF();

  }

  int pageLength;
  bool isLoading = false;
  Future<void> _createPDF() async {
    //Create a new PDF document


    PdfDocument document = PdfDocument();
    List<PdfPage> pageList=[];
    List<PdfGrid> gridList=[];
    List<PdfGridRow> hadderList=[];
    List<PdfGridRow> rowList=[];


    //  ------ Style ----------------------------------------------------------
    PdfStringFormat format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
        wordSpacing: 10);

    PdfGridRowStyle rowStylebold = PdfGridRowStyle(
        font: PdfStandardFont(
            PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold));

    PdfGridRowStyle rowStyleboldExtra = PdfGridRowStyle(
        font: PdfStandardFont(
            PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold));

    PdfGridRowStyle rowStyle = PdfGridRowStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 11));

    PdfGridCellStyle cellStyle1 = PdfGridCellStyle(
      //cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
      font: PdfStandardFont(
          PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),
    );


    PdfBorders borderu = PdfBorders(
      top: PdfPen(PdfColor.empty),
    );
    PdfBorders borderb = PdfBorders(
      bottom: PdfPen(PdfColor.empty),
    );

    PdfBorders bordempty = PdfBorders(
      bottom: PdfPen(PdfColor.empty),
      top: PdfPen(PdfColor.empty),
    );

    PdfGridStyle gridStyle = PdfGridStyle(
      cellPadding: PdfPaddings(left: 7, right: 7, top: 3, bottom: 0),
    );
    PdfGridStyle gridStyle1 = PdfGridStyle(
      cellPadding: PdfPaddings(left: 7, right: 100, top: 0, bottom: 0),
    );

    PdfGridStyle gridStyle2 = PdfGridStyle(
      cellPadding: PdfPaddings(left: 7, right: 7, top: 7, bottom: 0),
    );

    PdfGridStyle gridStylewithheader = PdfGridStyle(
      cellPadding: PdfPaddings(left: 5, right: 5, top: 03, bottom: 0),
    );

    // Page - create
    for(int i=0;i<pageLength;i++){
      pageList.add(document.pages.add());
      gridList.add(PdfGrid());
      gridList[i].columns.add(count: 5);
      gridList[i].headers.add(1);
      pageList[0].graphics.drawString(
          'Order Invoice',
          PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(225, 00, 500, 0));
      PdfBorders border = PdfBorders(
        bottom: PdfPen(PdfColor.empty),
        top: PdfPen(PdfColor.empty),
        left: PdfPen(PdfColor.empty),
        right: PdfPen(PdfColor.empty),
      );
    }

    int x=0;
    int y=25;
    if(y>widget.productList.length){
      y=widget.productList.length;
    }

    // Grid Create / Header Create -----------------
    for(int i=0;i<gridList.length;i++){

      hadderList.add(gridList[i].headers[0]);
      hadderList[i].cells[0].value ="Sr.";//Save the document
      hadderList[i].cells[1].value ="Product Name";//Save the document
      hadderList[i].cells[2].value ="Color Code";
      hadderList[i].cells[3].value ="Quantity";

      hadderList[i].style = rowStyle;

      gridList[i].columns[0].width=30;
      gridList[i].columns[1].width=320;
      gridList[i].columns[2].width=80;
      gridList[i].columns[3].width=80;
      gridList[i].rows.applyStyle(gridStylewithheader);

      // header.cells[0].style =PdfGridCellStyle(,cellPadding: PdfPaddings(left: 100,right: 100));
      hadderList[i].cells[0].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);
      hadderList[i].cells[1].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 2);
      hadderList[i].cells[2].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);
      hadderList[i].cells[3].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);

      for (int j = x; j < y; j++) {

        rowList.add(gridList[i].rows.add());
        rowList[j].cells[0].value=(j+1).toString();
        rowList[j].cells[1].value = "${widget.ProductName[j]}";
        rowList[j].cells[2].value = "${widget.productList[j]["color_code"]}";
        rowList[j].cells[3].value = "${widget.productList[j]["qty"]}";

        rowList[j].cells[1].style = cellStyle1;
        rowList[j].cells[2].style = cellStyle1;
        rowList[j].cells[3].style = cellStyle1;

        rowList[j].cells[i].style = PdfGridCellStyle(
          cellPadding: PdfPaddings(left: 3, right: 3, top: 4, bottom: 0),
          font: PdfStandardFont(PdfFontFamily.timesRoman, 10,style: PdfFontStyle.bold),
        );
        rowList[j].cells[1].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[0].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[1].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[2].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );
        rowList[j].cells[3].style.borders = PdfBorders(
            bottom:PdfPen(PdfColor.empty),top:PdfPen(PdfColor.empty)
        );

      }

      x=y;
      y=y+25;

      print(widget.productList.length);
      if(y>widget.productList.length){
        y=widget.productList.length;
      }

      if(i == gridList.length-1){

        PdfGridRow r2 = gridList[gridList.length-1].rows.add();

        for (int d = 0; d < gridList[gridList.length-1].columns.count; d++) {
          if(d==1||d==4){
            r2.cells[d].style = PdfGridCellStyle(
              cellPadding: PdfPaddings(left: 2, right: 3, top: 5, bottom: 5),
              font: PdfStandardFont(PdfFontFamily.timesRoman, 10,style: PdfFontStyle.bold),
            );
            if(d==1){

              r2.cells[d].style = PdfGridCellStyle(
                cellPadding: PdfPaddings(left: 2, right: 3, top: 0, bottom: 5),
                font: PdfStandardFont(PdfFontFamily.timesRoman, 10,style: PdfFontStyle.bold),
              );
              r2.cells[d].style.stringFormat = PdfStringFormat(
                  alignment: PdfTextAlignment.right,
                  lineAlignment: PdfVerticalAlignment.middle,
                  wordSpacing: 0);
            }
            if(d==3){

              r2.cells[d].style = cellStyle1;
            }
          }

        }
        r2.cells[3].value=" ${widget.totalQuantity}";
        r2.cells[1].value= "Total Quantity ";

      }
      else{

        PdfGridRow r3 = gridList[i].rows.add();

        for (int d = 0; d < gridList[i].columns.count; d++) {
          //r3.cells[d].style = cellStyle1;
          r3.cells[d].style.borders =  PdfBorders(
              top:PdfPen(PdfColor.empty)
          );
          }

      }


      PdfGrid gridu = PdfGrid();

      gridu.columns.add(count: 1);
      gridu.headers.add(0);
      gridu.rows.applyStyle(gridStyle1);
      gridu.columns[0].width = 510;

//Add rows to grid
/*      PdfGridRow rowug3 = gridu.rows.add();
      rowug3.cells[0].value = "Invoice No : ${widget.orderid}";
      rowug3.cells[0].style.borders = borderb;
      rowug3.style = rowStyle;*/

      PdfGridRow rowug6 = gridu.rows.add();
      rowug6.cells[0].value = "";
      rowug6.style = rowStyleboldExtra;
      rowug6.cells[0].style.borders = borderb;

      PdfGridRow rowug4 = gridu.rows.add();
      rowug4.cells[0].value = "Order No - ${_orderProvider.orderId}";
      rowug4.style = rowStylebold;
      rowug4.cells[0].style.borders = bordempty;

      PdfGridRow rowug5 = gridu.rows.add();
      rowug5.cells[0].value = "Order Date - ${widget.orderDate}";
      rowug5.style = rowStylebold;
      rowug5.cells[0].style.borders = bordempty;

      PdfImage image = PdfBitmap.fromBase64String('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AAAAAAAALSABAAAAAAAAAABaQAIAAAAAAAAAALSABAAAAAAAAAAAaAEJAAAAAAAAAADQAhIAAAAAAAAAAKAFJAAAAAAAAAAAQAtIAAAAAAAAAACAFpAAAAAAAAAAAAAtIAEAAAAAAAAAAFpAAgAAAAAAAAAAtIAEAAAAAAAAAABoAQkAAAAAAAAAANACEgAAAAAAAAAAoAUkAAAAAAAAAABAC0gAAAAAAAAAAIAWkAAAAAAAAAAAAC0gAQAAAAAAAAAAWkACAAAAAAAAAAC0gAQAAAAAAAAAAGgBCQAAAAAAAAAA0AISAAAAAAAAAACgBSQAAAAAAAAAAEALSAAAAAAAAAAAgBaQAAAAAAAAAAAALSABAAAAAAAAAABaQAIAAAAAAAAAALSABAAAAAAAAAAAaAEJAAAAAAAAAADQAhIAAAAAAAAAAKAFJAAAAAAAAAAAQAtIAAAAAAAAAACAFpAAAAAAAAAAAAAtIAEAAAAAAAAAAFpAAgAAAAAAAAAAtIAEAAAAAAAAAABoAQkAAAAAAAAAANACEgAAAAAAAAAAoAUkAAAAAAAAAABAC0gAAAAAAAAAAIAWkAAAAAAAAAAAAC0gAQAAAAAAAAAAWkACAAAAAAAAAAC0gAQAAAAAAAAAAGgBCQAAAAAAAAAA0AISAAAAAAAAAACgBSQAAAAAAAAAAEALSAAAAAAAAAAAgBaQAAAAAAAAAAAALSABAAAAAAAAAABaQAIAAAAAAAAAALSABAAAAAAAAAAAaAEJAAAAAAAAAADQAhIAAAAAAAAAAKAFJAAAAAAAAAAAQAtIAAAAAAAAAACAFpAAAAAAAAAAAAAtIAEAAAAAAAAAAFpAAgAAAAAAAAAAtIAEAAAAAAAAAABoAQkAAAAAAAAAANACEgAAAAAAAAAAoAUkAAAAAAAAAABAC0gAAAAAAAAAAIAWkAAAAAAAAAAAAC0gAQAAAAAAAAAAWkACAAAAAAAAAAC0gAQAAAAAAAAAAGgBCQAAAAAAAAAA0AISAAAAAAAAAACgBSQAAAAAAAAAAEALSAAAAAAAAAAAgBaQAAAAAAAAAAAALSABAAAAAAAAAABaQAIAAAAAAAAAALSABAAAAAAAAAAAaAEJAAAAAAAAAADQAhIAAAAAAAAAAKAFJAAAAAAAAAAAQAtIAAAAAAAAAACAFpAAAAAAAAAAAAAtIAEA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');
      pageList[i].graphics.drawImage(image, Rect.fromLTWH(435, 40, 60, 60));


      PdfGridRow rowug1 = gridu.rows.add();
      rowug1.cells[0].value = "Retailer Name - ${widget.retailerName}";
      rowug1.style = rowStylebold;
      rowug1.cells[0].style.borders = bordempty;

      PdfGridRow rowup2 = gridu.rows.add();
      rowup2.cells[0].value = "Retailer Address - ${widget.address}";
      rowup2.style = rowStylebold;
      rowup2.cells[0].style.borders = bordempty;

      PdfGridRow rowup3 = gridu.rows.add();
      rowup3.cells[0].value = "Retailer Phone No - ${widget.mobile_number}";
      rowup3.style = rowStylebold;
      rowup3.cells[0].style.borders = bordempty;

      PdfLayoutResult result,result1;

      result = gridu.draw(
          page: pageList[i],
          bounds: const Rect.fromLTWH(0, 25, 510, 3000));

      //--------------------------------------------------------------TOP SECOND GRID  ---------------------------------
      result1 = gridList[i].draw(
          page: pageList[i],
          bounds: Rect.fromLTWH(0, result.bounds.bottom, 510, 10040)
      );

      PdfGrid grid2 = PdfGrid();
      grid2.style = PdfGridStyle(
          cellPadding: PdfPaddings(left: 7, right: 7, top: 1, bottom: 0),
          font: PdfStandardFont(PdfFontFamily.timesRoman, 10));
      grid2.columns.add(count: 2);

      PdfGrid grid3 = PdfGrid();
      grid3.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 2, right: 5,),);

      grid3.columns.add(count: 5);
      grid3.columns[0].width = 234;
      grid3.columns[1].width = 80;
      grid3.columns[2].width = 50;
      // /grid.columns[1].width = 50;
      grid3.headers.add(1);

    }
    List<int> bytes = document.save();
    //Dispose the document
    document.dispose();

    //await saveAndLaunchFile(bytes, 'Inv.pdf');


    final path= Directory("storage/emulated/0/Documents");
    // print(path);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      await Permission.mediaLibrary.request();
    }
    if ((await path.exists())) {
      null;
    } else {
      path.create();
    }

    String route = "storage/emulated/0/Documents";
    File file = File('$route/Invoice_id_${_orderProvider.orderId}_$currentDate.pdf');
    await file.writeAsBytes(bytes, flush: true);

    if(widget.person_mobile != ""){
      sendImage(file.path);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleCustomAlert();
          }
      );

    }
    else{

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleCustomAlert();
          }
      );

    }

    setState(() {
      isLoading = false;
    });


/*
    OpenFile.open('$route/Invoice_id_${_orderProvider.orderId}_$currentDate.pdf').then((value) {

      setState(() {
        isLoading = false;
      });

      return null;
    });
*/

  }

  String dateFormate = DateFormat("yyMMddhhmmss").format(DateTime.now());
  String currentDate = DateFormat("dd_MMM_yyyy_hhmmss").format(DateTime.now());

}

class SimpleCustomAlert extends StatefulWidget {
  @override
  State<SimpleCustomAlert> createState() => _SimpleCustomAlertState();
}

class _SimpleCustomAlertState extends State<SimpleCustomAlert> {

  @override
  void initState()
  {
    super.initState();
    Timer(
        Duration(milliseconds: 1000),
            () {
          Navigator.pop(context);

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,

      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [AppColors.grey1,AppColors.grey2]),
          borderRadius: round.copyWith(),
        ),
        height: 100,
        width: width/1.4,
        child: Center(
          child: Text(
              "Order Confirmed",
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          ),
        ),
      ),
    );
  }
}