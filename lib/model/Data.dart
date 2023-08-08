// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  final bool success;
  final List<Datum> data;
  final String message;

  Data({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  final int id;
  final String name;
  final String addressNo;
  final int villageId;
  final int districtId;
  final int provinceId;
  final String postcode;
  final String phoneNo;
  final String latitude;
  final String longitude;
  final bool status;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final dynamic bankAccname;
  final dynamic bankNo;
  final dynamic bankName;
  final Zone zone;
  final String zoneFarLevel;
  final dynamic discount;
  final bool coolStart;
  final bool coolEnd;
  final dynamic managerName;
  final dynamic managerPhone;
  final String warehouse;
  final int walletCreditSafe;
  final bool golden3;
  final int salesShare;
  final bool statusWarehouse;
  final String typeManage;
  final String salesShareEnd;
  final String salesShareCod;
  final bool showEndSearch;
  final bool lockPayOnSendEndStatus;
  final String frontImage;
  final String addressDetail;
  final List<DropshipHour> dropshipHours;

  Datum({
    required this.id,
    required this.name,
    required this.addressNo,
    required this.villageId,
    required this.districtId,
    required this.provinceId,
    required this.postcode,
    required this.phoneNo,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.bankAccname,
    required this.bankNo,
    required this.bankName,
    required this.zone,
    required this.zoneFarLevel,
    required this.discount,
    required this.coolStart,
    required this.coolEnd,
    required this.managerName,
    required this.managerPhone,
    required this.warehouse,
    required this.walletCreditSafe,
    required this.golden3,
    required this.salesShare,
    required this.statusWarehouse,
    required this.typeManage,
    required this.salesShareEnd,
    required this.salesShareCod,
    required this.showEndSearch,
    required this.lockPayOnSendEndStatus,
    required this.frontImage,
    required this.addressDetail,
    required this.dropshipHours,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        addressNo: json["address_no"],
        villageId: json["village_id"],
        districtId: json["district_id"],
        provinceId: json["province_id"],
        postcode: json["postcode"],
        phoneNo: json["phone_no"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        bankAccname: json["bank_accname"],
        bankNo: json["bank_no"],
        bankName: json["bank_name"],
        zone: zoneValues.map[json["zone"]]!,
        zoneFarLevel: json["zone_far_level"],
        discount: json["discount"],
        coolStart: json["cool_start"],
        coolEnd: json["cool_end"],
        managerName: json["manager_name"],
        managerPhone: json["manager_phone"],
        warehouse: json["warehouse"],
        walletCreditSafe: json["wallet_credit_safe"],
        golden3: json["golden3"],
        salesShare: json["sales_share"],
        statusWarehouse: json["status_warehouse"],
        typeManage: json["type_manage"],
        salesShareEnd: json["sales_share_end"],
        salesShareCod: json["sales_share_cod"],
        showEndSearch: json["show_end_search"],
        lockPayOnSendEndStatus: json["lock_pay_on_send_end_status"],
        frontImage: json["front_image"],
        addressDetail: json["address_detail"],
        dropshipHours: List<DropshipHour>.from(
            json["dropship_hours"].map((x) => DropshipHour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address_no": addressNo,
        "village_id": villageId,
        "district_id": districtId,
        "province_id": provinceId,
        "postcode": postcode,
        "phone_no": phoneNo,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "code": code,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "bank_accname": bankAccname,
        "bank_no": bankNo,
        "bank_name": bankName,
        "zone": zoneValues.reverse[zone],
        "zone_far_level": zoneFarLevel,
        "discount": discount,
        "cool_start": coolStart,
        "cool_end": coolEnd,
        "manager_name": managerName,
        "manager_phone": managerPhone,
        "warehouse": warehouse,
        "wallet_credit_safe": walletCreditSafe,
        "golden3": golden3,
        "sales_share": salesShare,
        "status_warehouse": statusWarehouse,
        "type_manage": typeManage,
        "sales_share_end": salesShareEnd,
        "sales_share_cod": salesShareCod,
        "show_end_search": showEndSearch,
        "lock_pay_on_send_end_status": lockPayOnSendEndStatus,
        "front_image": frontImage,
        "address_detail": addressDetail,
        "dropship_hours":
            List<dynamic>.from(dropshipHours.map((x) => x.toJson())),
      };
}

class DropshipHour {
  final int id;
  final int dayCode;
  final String timeStart;
  final String timeEnd;
  final int dropshipId;

  DropshipHour({
    required this.id,
    required this.dayCode,
    required this.timeStart,
    required this.timeEnd,
    required this.dropshipId,
  });

  factory DropshipHour.fromJson(Map<String, dynamic> json) => DropshipHour(
        id: json["id"],
        dayCode: json["day_code"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        dropshipId: json["dropship_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day_code": dayCode,
        "time_start": timeStart,
        "time_end": timeEnd,
        "dropship_id": dropshipId,
      };
}

enum Zone { N, S, VT }

final zoneValues = EnumValues({"N": Zone.N, "S": Zone.S, "VT": Zone.VT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
