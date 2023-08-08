import 'package:flutter/material.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';

import '../model/ListModel.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  List<ListModel> model = [
    ListModel('รอบที่ 1', 'description'),
    ListModel('รอบที่ 2', 'description'),
    ListModel('รอบที่ 3', 'description'),
    ListModel('รอบที่ 4', 'description'),
    ListModel('รอบที่ 5', 'description'),
    ListModel('รอบที่ 6', 'description'),
    ListModel('รอบที่ 7', 'description'),
    ListModel('รอบที่ 8', 'description'),
    ListModel('รอบที่ 9', 'description'),
    ListModel('รอบที่ 10', 'description'),
    ListModel('รอบที่ 11', 'description'),
    ListModel('รอบที่ 12', 'description'),
    ListModel('รอบที่ 13', 'description'),
    ListModel('รอบที่ 14', 'description'),
    ListModel('รอบที่ 15', 'description'),
    ListModel('รอบที่ 16', 'description'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MxColors.mainColorRed,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          toolbarHeight: 30,
          title: Text(
            "เลือกรอบรถ".toUpperCase(),
            style: const TextStyle(
              fontSize: 25,
              color: MxColors.mainColorWhite,
            ),
          ),
          centerTitle: false,
          backgroundColor: MxColors.mainColorRed,
          elevation: 2,
          // leading: Image.asset('assets/images/logo.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: const BoxDecoration(
            color: MxColors.mainColorWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (BuildContext context, int index) {
                ListModel branch = model[index];
                return SizedBox(
                  height: 70,
                  child: ListTile(
                    leading: const Icon(Icons.qr_code_scanner, size: 35),
                    title: Text(
                      branch.name,
                      style: const TextStyle(fontSize: 25),
                    ),
                    subtitle: Text(branch.description),
                    // trailing: const Icon(Icons.next_plan),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
