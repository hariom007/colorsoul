import 'dart:io';

import 'package:colorsoul/Values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class qrScannerPage extends StatefulWidget {
  @override
  _qrScannerPageState createState() => _qrScannerPageState();
}

class _qrScannerPageState extends State<qrScannerPage> {

  final key = GlobalKey(debugLabel: 'QR');
  QRViewController _qrViewController;
  bool flashlight=false;
  bool cameraFlip=false;
  Barcode result;

  var scanData;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrViewController.pauseCamera();
    } else if (Platform.isIOS) {
      _qrViewController.resumeCamera();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _qrViewController.dispose();
  }

  bool flashOn = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        QRView(
          key: key,
          onQRViewCreated: onQRViewCreate,
          overlay: QrScannerOverlayShape(
              cutOutSize: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              borderLength: 40,
              borderWidth: 8,
              borderRadius: 5,
              borderColor: AppColors.white
          ),
        ),

        Positioned(
          top: 50,
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      await _qrViewController.toggleFlash();
                      setState(() {
                        flashOn = !flashOn;
                      });
                    },
                    child:
                    flashOn == false ?
                    Icon(
                      Icons.flash_on,
                      color: AppColors.white,
                    )
                        :
                    Icon(
                      Icons.flash_off,
                      color: AppColors.white,
                    )
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 50,right: 30,
          child: GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: AppColors.white,
            ),
          ),
        )

      ],
    );
  }

  void onQRViewCreate(QRViewController controller) {
    setState(() {
      _qrViewController = controller;
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          result = scanData;
          _qrViewController.dispose();
          if(result!=null) {

            //print(${result.code.toString()}");
            Navigator.pop(context,"${result.code.toString()}");
          }
        });
      });
    });
  }

}