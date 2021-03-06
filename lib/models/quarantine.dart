import 'dart:convert';

import 'package:qlkcl/networking/api_helper.dart';
import 'package:qlkcl/utils/constant.dart';
import 'package:qlkcl/networking/response.dart';

Quarantine quarantineFromJson(String str) =>
    Quarantine.fromJson(json.decode(str));

String quarantineToJson(Quarantine data) => json.encode(data.toJson());

class Quarantine {
  Quarantine({
    required this.id,
    required this.country,
    required this.city,
    required this.district,
    required this.ward,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    this.address,
    this.latitude,
    this.longitude,
    required this.status,
    this.type,
    required this.quarantineTime,
    this.trash,
    required this.createdAt,
    required this.updatedAt,
    required this.mainManager,
    this.createdBy,
    this.updatedBy,
    required this.currentMem,
    required this.capacity,
  });

  final int id;
  final dynamic country;
  final dynamic city;
  final dynamic district;
  final dynamic ward;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String status;
  final String? type;
  final int quarantineTime;
  final bool? trash;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic mainManager;
  final dynamic createdBy;
  final dynamic updatedBy;
  final int currentMem;
  final int? capacity;

  factory Quarantine.fromJson(Map<String, dynamic> json) => Quarantine(
        id: json["id"],
        country: json["country"],
        city: json["city"],
        district: json["district"],
        ward: json["ward"],
        email: json["email"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        type: json["type"],
        quarantineTime: json["quarantine_time"],
        trash: json["trash"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mainManager: json["main_manager"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        currentMem: json["num_current_member"],
        capacity: json["total_capacity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country.toJson(),
        "city": city.toJson(),
        "district": district.toJson(),
        "ward": ward.toJson(),
        "email": email,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "type": type,
        "quarantine_time": quarantineTime,
        "trash": trash,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "main_manager": mainManager,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "num_current_member": currentMem,
        "total_capacity": capacity,
      };
}

Future<dynamic> fetchQuarantine({id}) async {
  ApiHelper api = ApiHelper();
  final response = await api.getHTTP(Constant.getQuarantine + '?id=' + id);
  return response["data"];
}

Future<dynamic> fetchQuarantineList({data}) async {
  ApiHelper api = ApiHelper();
  final response = await api.postHTTP(Constant.getListQuarantine, data);
  return response != null && response['data'] != null
      ? response['data']['content']
      : null;
}

Future<dynamic> createQuarantine(Map<String, dynamic> data) async {
  ApiHelper api = ApiHelper();
  final response = await api.postHTTP(Constant.createQuarantine, data);
  if (response == null) {
    return Response(success: false, message: "L???i k???t n???i!");
  } else {
    if (response['error_code'] == 0) {
      return Response(
          success: true,
          message: "T???o khu c??ch ly th??nh c??ng!",
          data: response['data']);
    } else if (response['message']['full_name'] != null &&
        response['message']['full_name'] == "Exist") {
      return Response(
          success: false, message: "T??n khu c??ch ly ???? ???????c s??? d???ng!");
    } else {
      // return Response(success: false, message: jsonEncode(response['message']));
      return Response(success: false, message: "C?? l???i x???y ra!");
    }
  }
}

Future<dynamic> updateQuarantine(Map<String, dynamic> data) async {
  ApiHelper api = ApiHelper();
  final response = await api.postHTTP(Constant.updateQuarantine, data);

  if (response == null) {
    return Response(success: false, message: "L???i k???t n???i!");
  } else {
    if (response['error_code'] == 0) {
      return Response(
          success: true,
          message: "C???p nh???t th??ng tin th??nh c??ng!",
          data: response['data']);
    } else if (response['message']['full_name'] != null &&
        response['message']['full_name'] == "Exist") {
      return Response(
          success: false, message: "T??n khu c??ch ly ???? ???????c s??? d???ng!");
    } else {
      return Response(success: false, message: "C?? l???i x???y ra!");
    }
  }
}

Future<dynamic> fetchBuildingList(Map<String, dynamic> data) async {
  ApiHelper api = ApiHelper();
  final response = await api.postHTTP(Constant.getListBuilding, data);
  return response != null && response['data'] != null
      ? response['data']['content']
      : null;
}
