import 'package:colorsoul/appColors.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {

  final int index;
  final ValueChanged<int> onChangedTab;

  BottomBar({this.index, this.onChangedTab});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: buildTabItem(index: 0, icon: Image.asset("assets/images/home.png",height: 20)
              )
          ),
          buildTabItem(index: 1, icon: Image.asset("assets/images/tab.png",height: 16)),
          buildTabItem(index: 2, icon: Image.asset("assets/images/bell.png",height: 22)),
          Padding(
              padding: EdgeInsets.only(right: 90),
              child: buildTabItem(index: 3, icon: Image.asset("assets/images/location3.png",height: 20)
              )
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({@required int index,@required Image icon}){
    final isSelected = index == widget.index;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: isSelected ? BorderSide(width: 3.0, color: AppColors.grey2) : BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        Container(
          child: IconButton(
            icon: icon,
            onPressed: () => widget.onChangedTab(index),
          ),
        ),
      ],
    );
  }
}
