import 'package:colorsoul/Ui/Dashboard/NewOrder/confirmorder.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../Values/appColors.dart';
import '../../../Values/components.dart';

class NewOrder extends StatefulWidget  {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController _textEditingController1 = new TextEditingController();
  DateTime _selectedDate;
  String value;
  int count = 1;
  bool isvisible = true;
  bool isvisible1 = true;

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmOrder()));
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
                                    cursorColor: AppColors.black,
                                    cursorHeight: 22,
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
                                              Text(
                                                "Chandanvan society",
                                                style: textStyle.copyWith(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18
                                                ),
                                              ),
                                              Expanded(child: Container()),
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
                                          Row(
                                            children: [
                                              Image.asset("assets/images/locater/location4.png",width: 20,height: 20),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: Text(
                                                  "Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)",
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
                                          ),
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
                                  Text(
                                    "Add products",
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
                                    )
                                  ),
                                  SizedBox(height: height*0.01),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(top: 10),
                                    itemCount: 3,
                                    shrinkWrap: true,
                                    itemBuilder:(context, index){
                                      return buildCard(height,index);
                                    },
                                  ),
                                  SizedBox(height: height*0.01),
                                  Divider(
                                      color: Color.fromRGBO(185, 185, 185, 0.75),
                                      thickness: 2
                                  ),
                                  SizedBox(height: height*0.02),
                                  Row(
                                    children: [
                                      Text(
                                        "Order Amount",
                                        style: textStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 18
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "₹1500.00",
                                        style: textStyle.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
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
      _textEditingController1
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController1.text.length,
            affinity: TextAffinity.upstream
        )
        );
    }
  }

  Widget buildCard(double height,int index) {
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
                child: ListTile(
                  leading: Image.asset("assets/images/neworder/nail-polish9.png"),
                  title: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      'Gel Nail Polish',
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
                      Row(
                        children: [
                          Text(
                            "₹250",
                            style: textStyle.copyWith(
                              fontSize: 12,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(width: 10),
                          Text(
                            "In Stock",
                            style: textStyle.copyWith(
                              fontSize: 11,
                              color: Color.fromRGBO(0, 169, 145, 1),
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ],
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
                                if(count == 1)
                                {
                                  null;
                                }
                                else
                                {
                                  count = count - 1;
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
                            "$count",
                            style: textStyle.copyWith(
                              color: AppColors.black,
                              fontSize: 18
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: (){
                              setState(() {
                                count = count + 1;
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
                      SizedBox(height: 17),
                      Text(
                        '₹500.00',
                        overflow: TextOverflow.ellipsis,
                        style: textStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}