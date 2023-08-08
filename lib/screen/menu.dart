import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coop_driver_mixay/Colors.dart/MxColors.dart';
// import 'package:flutter_coop_driver_mixay/screen/ScanConfirmation.dart';
import 'package:flutter_coop_driver_mixay/screen/Scanned.dart';
import '../model/MenuBox.dart';

import 'Branches.dart';
import 'Timetable.dart';
import 'Warehouse.dart';

Widget _buildFramedLogo() {
  return Container(
    padding: const EdgeInsets.all(0),
    decoration: const BoxDecoration(
      // border: Border.all(
      // color: MxColors.mainColorWhite,
      //   width: 2,
      // ),
      shape: BoxShape.circle, // Set the shape to circle
    ),
    width: 50,
    height: 50,
    child: Image.asset('assets/images/logo.png'),
  );
}

class MenuScreen extends StatelessWidget {
  void top() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: MxColors.mainColorRed,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));
  }

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    top();
    return Scaffold(
        backgroundColor: MxColors.backgroundColorGrey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFramedLogo(),
                  const SizedBox(
                      width: 15), // Add some spacing between the logo and text
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Mixay driver".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: MxColors.mainColorRed),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            backgroundColor: MxColors.mainColorWhite,
            elevation: 1,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 60, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 430,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: MxColors.mainColorRed),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '*****Driver ... Menu*****'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: MxColors.mainColorWhite,
                            ),
                          ),
                          MenuBox(
                            imagePath: 'assets/images/1.png',
                            text: 'สแกนรับจากสาขา',
                            imageHeight: 35,
                            imageWidth: 35,
                            sizedboxwidth: 10,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BranchScreen()),
                              );
                            },
                          ),
                          MenuBox(
                            imagePath: 'assets/images/2.png',
                            text: 'สแกนจากรถเข้าคลัง',
                            imageHeight: 35,
                            imageWidth: 35,
                            sizedboxwidth: 10,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WarehousesScreen()),
                              );
                            },
                          ),
                          MenuBox(
                            imagePath: 'assets/images/3.png',
                            text: 'สแกนจากคลังเข้ารถ',
                            imageHeight: 35,
                            imageWidth: 35,
                            sizedboxwidth: 10,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TimetableScreen()),
                              );
                            },
                          ),
                          MenuBox(
                            imagePath: 'assets/images/4.png',
                            text: 'สแกนจากรถเข้าสาขา',
                            imageHeight: 65,
                            imageWidth: 65,
                            sizedboxwidth: 10,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BranchScreen()),
                              );
                            },
                          ),
                          MenuBox(
                            imagePath: 'assets/images/4.png',
                            text: 'สถานะการสแกน',
                            imageHeight: 65,
                            imageWidth: 65,
                            sizedboxwidth: 10,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScannedScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
