import 'package:flutter/material.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';

import '../model/ListModel.dart';

class WarehousesScreen extends StatefulWidget {
  const WarehousesScreen({super.key});

  @override
  State<WarehousesScreen> createState() => _WarehousesScreenState();
}

class _WarehousesScreenState extends State<WarehousesScreen> {
  List<ListModel> model = [
    ListModel('คลังที่ 1', 'description'),
    ListModel('คลังที่ 2', 'description'),
    ListModel('คลังที่ 3', 'description'),
    ListModel('คลังที่ 4', 'description'),
    ListModel('คลังที่ 5', 'description'),
    ListModel('คลังที่ 6', 'description'),
    ListModel('คลังที่ 7', 'description'),
    ListModel('คลังที่ 8', 'description'),
    ListModel('คลังที่ 9', 'description'),
    ListModel('คลังที่ 10', 'description'),
    ListModel('คลังที่ 11', 'description'),
    ListModel('คลังที่ 12', 'description'),
    ListModel('คลังที่ 13', 'description'),
    ListModel('คลังที่ 14', 'description'),
    ListModel('คลังที่ 15', 'description'),
    ListModel('คลังที่ 16', 'description'),
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
            "เลือกคลัง".toUpperCase(),
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
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
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
