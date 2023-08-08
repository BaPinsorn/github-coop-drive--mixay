import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';
import 'package:flutter_coop_driver_mixay/Providers/scan_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/Scans.dart';
import 'Scanned.dart';

class ScanConfirmationScreen extends StatefulWidget {
  final String qrText;
  final trackingcontrollor =
      TextEditingController(); //รับค่าเลข Tracking number

  ScanConfirmationScreen({Key? key, required this.qrText}) : super(key: key);

  @override
  _ScanConfirmationScreenState createState() => _ScanConfirmationScreenState();
}

class _ScanConfirmationScreenState extends State<ScanConfirmationScreen> {
  late TextEditingController _packageNumberController;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController drivernamecontroller = TextEditingController();

  Future<void> insertrecord() async {
    if (datecontroller.text != "" ||
        timecontroller.text != "" ||
        drivernamecontroller.text != "") {
      try {
        String uri = "http://10.0.2.2/tracking_scanned_api/insert_record.php";

        var res = await http.post(Uri.parse(uri), body: {
          "date": datecontroller.text,
          "time": timecontroller.text,
          "drivername": drivernamecontroller.text,
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Record Inserted");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill All fields");
    }
  }

  @override
  void initState() {
    super.initState();
    _packageNumberController = TextEditingController(text: widget.qrText);
  }

  @override
  void dispose() {
    _packageNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ยืนยันการสแกน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'หมายเลขพัสดุ',
                ),
                controller: _packageNumberController,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'วันที่',
                ),
                controller: datecontroller,
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'เวลา',
                ),
                controller: timecontroller,
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ชื่อคนขับ',
                ),
                controller: drivernamecontroller,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MxColors.mainColorRed),
                ),
                onPressed: () {
                  insertrecord();
                  // var tracking = _packageNumberController.text;

                  // //เตรียมข้อมูล
                  // Scans status = Scans(
                  //   tracking: tracking,
                  //   date: DateTime.now(),
                  // );

                  // //เรียก Provider
                  // var provider =
                  //     Provider.of<ScanProvider>(context, listen: false);
                  // provider.addScan(status);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ScannedScreen()),
                  // );
                },
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(color: MxColors.mainColorWhite),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
