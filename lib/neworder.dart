import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'appColors.dart';
import 'components.dart';

class NewOrder extends StatefulWidget  {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController _textEditingController1 = new TextEditingController();
  DateTime _selectedDate;
  String value;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: Colors.transparent,
                          shape: StadiumBorder()
                      ),
                      child: Text('Done',
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
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.black
                                      ),
                                      borderRadius: round,
                                    ),
                                    child: DropdownBelow(
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
                                      value: value,
                                      items: [
                                        DropdownMenuItem(
                                            value: "1",
                                            child: Text("Retailer")
                                        ),
                                        DropdownMenuItem(
                                            value: "2",
                                            child: Text("Distributor")
                                        ),
                                      ],
                                      onChanged: (_value) {
                                        setState((){
                                          value = _value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: height*0.02),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                                    text: "Be Shoppers Stop",
                                                    style: textStyle.copyWith(
                                                        fontSize: 16,
                                                        color: AppColors.black,
                                                    )
                                                  )
                                                ]
                                              )
                                            ),
                                            Expanded(child: Container()),
                                            Image.asset("assets/images/productsdata/cancel.png",width: 10,height: 10)
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Image.asset("assets/images/tasks/location1.png",width: 20,height: 20),
                                            SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                "Silicon Shoppers, F4, 1st Floor,  Chandanvan Society, Udhna, Surat, Gujarat 394210",
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
                                                "+91 98452 00320",
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
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
                                    ),
                                  ),
                                  SizedBox(height: height*0.02),
                                  Text(
                                    "Description",
                                    style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(height: height*0.01),
                                  TextFormField(
                                    minLines: 6,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
                                    ),
                                  ),
                                  SizedBox(height: height*0.02),
                                  Text(
                                    "Add Catagory name",
                                    style: textStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                  SizedBox(height: height*0.01),
                                  TextFormField(
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.black
                                    ),
                                    cursorHeight: 22,
                                    cursorColor: Colors.grey,
                                    decoration: fieldStyle1.copyWith(
                                        isDense: true
                                    ),
                                  ),
                                  SizedBox(height: height*0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
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
                                            height: height*0.08,
                                            width: width/2.4,
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
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                  fontSize: 14,
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
      initializeDateFormatting('es');
      _textEditingController1
        ..text = DateFormat.yMd('es').format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController1.text.length,
            affinity: TextAffinity.upstream
        )
        );
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}