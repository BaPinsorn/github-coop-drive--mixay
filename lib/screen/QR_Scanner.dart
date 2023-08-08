// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:http/http.dart' as http;

import '../Colors.dart/MxColors.dart';
import 'ScanConfirmation.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({Key? key}) : super(key: key);

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  String qrText = "";
  bool isScanned =
      false; // New boolean flag to track if QR code is already scanned

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MxColors.mainColorRed,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MxColors.mainColorWhite,
            title: const Text(
              'SCAN',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: MxColors.titleColorBlack),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: MxColors.titleColorBlack),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Tracking No : $qrText',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   height: 61,
              //   color: MxColors.mainColorRed, // Set the background color here
              //   // Add other child widgets here if needed
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanned) {
        // Check if QR code is not already scanned
        setState(() {
          qrText = scanData.code!;
          isScanned = true; // Set the flag to true after scanning the QR code
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanConfirmationScreen(qrText: qrText),
          ),
        );
        //   ส่ง Tracking ไปยัง API
        //   sendTrackingNumberToAPI(qrText);

        //   เมื่อเลขพัสดุตรงกันให้โชว์
        //   if (qrText == "1003071830034") {
        //     showToastWithCustomStyle();
        //   } else if (qrText != "173-30516-1002") {
        //     Fluttertoast.showToast(
        //       msg: 'ไม่มีเลขพัสดุนี้',
        //       fontSize: 20,
        //       textColor:MxColors.iconColorGrey,
        //       gravity: ToastGravity.TOP,
        //       toastLength: Toast
        //           .LENGTH_LONG, // Set the duration in milliseconds (5 seconds in this example)
        //       backgroundColor:MxColors.mainColorWhite,
        //     );
        //   }
      }
    });
  }

  // ส่ง Tracking ไปยัง API
  // void sendTrackingNumberToAPI(String trackingNumber) async {
  //   // ignore: prefer_const_declarations
  //   final apiUrl = 'https://api.mixayexpress.com/api/dropships_all';
  //   var payload = {
  //     "tracking_number": trackingNumber,
  //   };
  //   try {
  //     var response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(payload),
  //     );

  //     if (response.statusCode == 200) {
  //       print('API request successful!');
  //     } else {
  //       print('API request failed whith status code:  ${response.statusCode}');
  //       Fluttertoast.showToast(
  //         msg: "Failed to send tracking number to API.",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: MxColors.mainColorRed,
  //         textColor: MxColors.mainColorWhite,
  //         fontSize: 16.0,
  //       );
  //     }
  //   } catch (error) {
  //     print('Error sending API request: $error');
  //     Fluttertoast.showToast(
  //       msg: "Error sending trackin number to API",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor:MxColors.mainColorRed,
  //       textColor: MxColors.mainColorWhite,
  //       fontSize: 16.0,
  //     );
  //   }
  // }

  // เมื่อเลขพัสดุตรงกันให้โชว์
  // void showToastWithCustomStyle() {
  //   Fluttertoast.showToast(
  //     msg: 'พัสดุในสาขา xxx เตรียมขึ้นรถ xxx ชิ้น',
  //     fontSize: 20,
  //     textColor:MxColors.iconColorGrey,
  //     gravity: ToastGravity.TOP,
  //     toastLength: Toast
  //         .LENGTH_LONG, // Set the duration in milliseconds (5 seconds in this example)
  //     backgroundColor: MxColors.mainColorWhite,
  //   );
  // }
}
