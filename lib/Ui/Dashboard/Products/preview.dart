import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Preview extends StatefulWidget {

  String imgname;
  Preview({this.imgname});

  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  int currentPage = 0;
  PageController _controller;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset("assets/images/productsdata/back1.png",width: 20,height: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: 1,
                  itemBuilder: (context,index) =>
                  PhotoView(
                    minScale: PhotoViewComputedScale.contained*1,
                    maxScale: PhotoViewComputedScale.covered*2,
                    imageProvider: CachedNetworkImageProvider("${widget.imgname}"),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.white
                    )
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => buildDot(index: index)
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          gradient: currentPage == index ? LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.white,Colors.black,Colors.black]) : LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.white,Colors.grey]),
          borderRadius: BorderRadius.circular(6)
      ),
    );
  }
}
