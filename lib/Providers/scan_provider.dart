import 'package:flutter/foundation.dart';

import '../model/Scans.dart';

class ScanProvider with ChangeNotifier {
  //ตัวอย่างข้อมูล
  List<Scans> scans = [];

  //ดึงข้อมูล
  List<Scans> getScan() {
    return scans;
  }

  void addScan(Scans status) {
    scans.insert(0, status);
    //แจ้งเตือน Consumer
    notifyListeners();
  }
}
