import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Preview extends StatefulWidget {

  String imgname;

  Preview({this.imgname});

  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset("assets/images/productsdata/back1.png",width: 20,height: 20),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: PhotoView(
          minScale: PhotoViewComputedScale.contained*1,
          maxScale: PhotoViewComputedScale.covered*2,
          imageProvider: AssetImage(widget.imgname),
          backgroundDecoration: BoxDecoration(
            color: Colors.white
          )
        )
      ),
    );
  }
}
