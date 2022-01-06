import 'package:colorsoul/Values/appColors.dart';
import 'package:colorsoul/Values/components.dart';
import 'package:flutter/material.dart';

class ColorAndSize extends StatefulWidget {

  @override
  State<ColorAndSize> createState() => _ColorAndSizeState();
}

class _ColorAndSizeState extends State<ColorAndSize> {
  bool flag1 = true;
  bool flag2 = false;
  bool flag3 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: (){
                  setState(() {
                    if(flag2==true || flag3==true)
                    {
                      flag1 = true;
                      flag2 = false;
                      flag3 = false;
                    }
                  });
                },
                child: ColorDot(
                  color1: Color(0xFFDC857E),
                  color2: Color(0xFF965048),
                  isSelected: flag1,
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    if(flag1==true || flag3==true)
                    {
                      flag1 = false;
                      flag2 = true;
                      flag3 = false;
                    }
                  });
                },
                child: ColorDot(
                  color1: Color(0xFFE1A592),
                  color2: Color(0xFFB4604A),
                  isSelected: flag2,
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    if(flag1==true || flag2==true)
                    {
                      flag1 = false;
                      flag2 = false;
                      flag3 = true;
                    }
                  });
                },
                child: ColorDot(
                  color1: Color(0xFFE5636C),
                  color2: Color(0xFFC43A46),
                  isSelected: flag3,
                ),
              ),
              Text(
                " +4",
                style: textStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color1;
  final Color color2;
  final bool isSelected;
  const ColorDot({
    Key key,
    this.color1,
    this.color2,
    // by default isSelected is false
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [color1,color2]),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class ColorAndSize1 extends StatefulWidget {
  @override
  _ColorAndSize1State createState() => _ColorAndSize1State();
}

class _ColorAndSize1State extends State<ColorAndSize1> {
  bool flag1 = true;
  bool flag2 = false;
  bool flag3 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
                      if(flag2==true || flag3==true)
                      {
                        flag1 = true;
                        flag2 = false;
                        flag3 = false;
                      }
                    });
                  },
                  child: ColorDot1(
                    color1: Color(0xFFDC857E),
                    color2: Color(0xFF965048),
                    isSelected: flag1,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){
                    setState(() {
                      if(flag1==true || flag3==true)
                      {
                        flag1 = false;
                        flag2 = true;
                        flag3 = false;
                      }
                    });
                  },
                  child: ColorDot1(
                    color1: Color(0xFFE1A592),
                    color2: Color(0xFFB4604A),
                    isSelected: flag2,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){
                    setState(() {
                      if(flag1==true || flag2==true)
                      {
                        flag1 = false;
                        flag2 = false;
                        flag3 = true;
                      }
                    });
                  },
                  child: ColorDot1(
                    color1: Color(0xFFE5636C),
                    color2: Color(0xFFC43A46),
                    isSelected: flag3,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  " +4",
                  style: textStyle.copyWith(
                      color: Colors.black,
                      fontSize: 20
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorDot1 extends StatelessWidget {
  final Color color1;
  final Color color2;
  final bool isSelected;
  const ColorDot1({
    Key key,
    this.color1,
    this.color2,
    // by default isSelected is false
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [color1,color2]),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class ColorAndSize2 extends StatefulWidget {
  @override
  _ColorAndSize2State createState() => _ColorAndSize2State();
}

class _ColorAndSize2State extends State<ColorAndSize2> {
  bool flag1 = true;
  bool flag2 = false;
  bool flag3 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: (){
            setState(() {
              if(flag2==true || flag3==true)
              {
                flag1 = true;
                flag2 = false;
                flag3 = false;
              }
            });
          },
          child: ColorDot2(
            color1: Color(0xFFDC857E),
            color2: Color(0xFF965048),
            isSelected: flag1,
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: (){
            setState(() {
              if(flag1==true || flag3==true)
              {
                flag1 = false;
                flag2 = true;
                flag3 = false;
              }
            });
          },
          child: ColorDot2(
            color1: Color(0xFFE1A592),
            color2: Color(0xFFB4604A),
            isSelected: flag2,
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: (){
            setState(() {
              if(flag1==true || flag2==true)
              {
                flag1 = false;
                flag2 = false;
                flag3 = true;
              }
            });
          },
          child: ColorDot2(
            color1: Color(0xFFE5636C),
            color2: Color(0xFFC43A46),
            isSelected: flag3,
          ),
        ),
        SizedBox(width: 10),
        ColorDot2(
          color1: Color(0xFFBEBEB9),
          color2: Color(0xFF88777D),
        ),
        SizedBox(width: 10),
        ColorDot2(
          color1: Color(0xFFD3CFB1),
          color2: Color(0xFFA9A385),
        ),
        SizedBox(width: 10),
        ColorDot2(
          color1: Color(0xFF7F3915),
          color2: Color(0xFFB7A375),
        ),
      ],
    );
  }
}

class ColorDot2 extends StatelessWidget {
  final Color color1;
  final Color color2;
  final bool isSelected;
  const ColorDot2({
    Key key,
    this.color1,
    this.color2,
    // by default isSelected is false
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [color1,color2]),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}