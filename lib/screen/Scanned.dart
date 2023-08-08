import 'package:flutter/material.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';
import 'package:flutter_coop_driver_mixay/Providers/scan_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/Scans.dart';

class ScannedScreen extends StatefulWidget {
  const ScannedScreen({super.key});

  @override
  State<ScannedScreen> createState() => _ScannedScreenState();
}

class _ScannedScreenState extends State<ScannedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สถานะการสแกน'),
      ),
      body: Consumer(
        builder: (context, ScanProvider provider, Widget? child) {
          var count = provider.scans.length; //นับจำนวนข้อมูล
          if (count < 0) {
            return const Center(
              child: Text(
                'ไม่พบข้อมูล',
                style: TextStyle(fontSize: 20, color: MxColors.titleColorBlack),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  Scans data = provider.scans[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: MxColors.mainColorRed,
                        child: FittedBox(
                          child: Text('รูป'),
                        ),
                      ),
                      title: Text(data.tracking.toString()),
                      subtitle:
                          Text(DateFormat('yyyy/MM/dd').format(data.date!)),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
