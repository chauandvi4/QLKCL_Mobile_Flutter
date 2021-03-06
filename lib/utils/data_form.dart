import 'package:qlkcl/helper/function.dart';

Map<String, String> loginDataForm(
    {required String phoneNumber, required String password}) {
  return {'phone_number': phoneNumber, 'password': password};
}

Map<String, dynamic> registerDataForm(
    {required String phoneNumber,
    required String password,
    required String quarantineWard}) {
  return {
    'phone_number': phoneNumber,
    'password': password,
    'quarantine_ward_id': quarantineWard
  };
}

Map<String, dynamic> createMemberDataForm({
  required String phoneNumber,
  required String fullName,
  String? email,
  required String birthday,
  required String gender,
  required String nationality,
  required String country,
  required String city,
  required String district,
  required String ward,
  required String address,
  String? identity,
  String? healthInsurance,
  String? passport,
  required String quarantineWard,
  String? quarantineRoom,
  String? label,
  String? quarantinedAt,
  bool? positiveBefore,
  String? backgroundDisease,
  String? otherBackgroundDisease,
}) {
  var data = {
    "phone_number": phoneNumber,
    "full_name": fullName,
    "email": email,
    "birthday": birthday,
    "gender": gender,
    "nationality_code": nationality,
    "country_code": country,
    "city_id": city,
    "district_id": district,
    "ward_id": ward,
    "detail_address": address,
    "health_insurance_number": healthInsurance,
    "identity_number": identity,
    "passport_number": passport,
    "quarantine_ward_id": quarantineWard,
    "quarantine_room_id": quarantineRoom,
    "label": label,
    "quarantined_at": quarantinedAt,
    "positive_tested_before": positiveBefore,
    "background_disease": backgroundDisease,
    "other_background_disease": otherBackgroundDisease,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> updateMemberDataForm({
  required String code,
  String? fullName,
  String? email,
  String? birthday,
  String? gender,
  String? nationality,
  String? country,
  String? city,
  String? district,
  String? ward,
  String? address,
  String? identity,
  String? healthInsurance,
  String? passport,
  String? quarantineWard,
  String? quarantineRoom,
  String? label,
  String? quarantinedAt,
  bool? positiveBefore,
  String? backgroundDisease,
  String? otherBackgroundDisease,
}) {
  var data = {
    "code": code,
    "full_name": fullName,
    "email": email,
    "birthday": birthday,
    "gender": gender,
    "nationality_code": nationality,
    "country_code": country,
    "city_id": city,
    "district_id": district,
    "ward_id": ward,
    "detail_address": address,
    "health_insurance_number": healthInsurance,
    "identity_number": identity,
    "passport_number": passport,
    "quarantine_ward_id": quarantineWard,
    "quarantine_room_id": quarantineRoom,
    "label": label,
    "quarantined_at": quarantinedAt,
    "positive_tested_before": positiveBefore,
    "background_disease": backgroundDisease,
    "other_background_disease": otherBackgroundDisease,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> filterMemberDataForm({
  required String keySearch,
  String? quarantineWard,
  String? quarantineBuilding,
  String? quarantineFloor,
  String? quarantineRoom,
  String? quarantineAtMin,
  String? quarantineAtMax,
  List<String>? label,
  required int page,
}) {
  var data = {
    "search": keySearch,
    "quarantine_ward_id": quarantineWard,
    "quarantine_building_id": quarantineBuilding,
    "quarantine_floor_id": quarantineFloor,
    "quarantine_room_id": quarantineRoom,
    "created_at_min": quarantineAtMin,
    "created_at_max": quarantineAtMax,
    "label": label,
    "page": page,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> createTestDataForm({
  required String userCode,
  String? status,
  String? type,
  String? result,
}) {
  var data = {
    "user_code": userCode,
    "status": status,
    "type": type,
    "result": result,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> updateTestDataForm({
  required String code,
  String? status,
  String? type,
  String? result,
}) {
  var data = {
    "code": code,
    "status": status,
    "type": type,
    "result": result,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> filterTestDataForm({
  required String keySearch,
  String? status,
  String? createAtMin,
  String? createAtMax,
  required int page,
}) {
  var data = {
    "search": keySearch,
    "status": status,
    "created_at_min": createAtMin,
    "created_at_max": createAtMax,
    "page": page,
  };
  return prepareDataForm(data);
}

Map<String, String> requestOtpDataForm({
  required String email,
}) {
  var data = {
    "email": email,
  };
  return prepareDataForm(data);
}

Map<String, String> sendOtpDataForm({
  required String email,
  required String otp,
}) {
  var data = {
    "email": email,
    'otp': otp,
  };
  return prepareDataForm(data);
}

Map<String, String> createPassDataForm({
  required String email,
  required String otp,
  required String newPassword,
  required String confirmPassword,
}) {
  var data = {
    "email": email,
    'confirm_otp': otp,
    'new_password': newPassword,
    'confirm_password': confirmPassword,
  };
  return prepareDataForm(data);
}

Map<String, String> changePassDataForm({
  required String oldPassword,
  required String newPassword,
  required String confirmPassword,
}) {
  var data = {
    'old_password': oldPassword,
    'new_password': newPassword,
    'confirm_password': confirmPassword,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> createQuarantineDataForm({
  required String email,
  required String fullName,
  required String country,
  required String city,
  required String district,
  required String ward,
  String? address,
  String? latitude,
  String? longtitude,
  required String status,
  String? type,
  required int quarantineTime,
  required String mainManager,
}) {
  var data = {
    "email": email,
    "full_name": fullName,
    "country": country,
    "city": city,
    "district": district,
    "ward": ward,
    "address": address,
    "latitude": latitude,
    "longtitude": longtitude,
    "staus": status,
    "type": type,
    "quarantine_time": quarantineTime,
    "main_manager": mainManager,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> createRoomDataForm({
  required int capacity,
  required int quarantineFloor,
  required String name,
  
}) {
  var data = {
    "name": name,
    "quarantine_floor": quarantineFloor,
    "capacity": capacity,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> updateQuarantineDataForm({
  required int id,
  String? email,
  String? fullName,
  String? country,
  String? city,
  String? district,
  String? ward,
  String? address,
  String? latitude,
  String? longtitude,
  String? status,
  String? type,
  int? quarantineTime,
  String? mainManager,
}) {
  var data = {
    "id": id,
    "email": email,
    "full_name": fullName,
    "country": country,
    "city": city,
    "district": district,
    "ward": ward,
    "address": address,
    "latitude": latitude,
    "longtitude": longtitude,
    "staus": status,
    "type": type,
    "quarantine_time": quarantineTime,
    "main_manager": mainManager,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> filterQuarantineDataForm({
  required String keySearch,
  String? createAtMin,
  String? createAtMax,
  required int page,
}) {
  var data = {
    "search": keySearch,
    "created_at_min": createAtMin,
    "created_at_max": createAtMax,
    "page": page,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  data.removeWhere((key, value) => value == null);
  return data;
}

Map<String, dynamic> createBuildingDataForm({
  required String name,
  required int quarantineWard,
}) {
  var data = {
    "name": name,
    "quarantine_ward": quarantineWard,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> updateBuildingDataForm({
  String? name,
  int? quarantineWard,
  required int id,
}) {
  var data = {
    "id": id,
    "quarantine_ward": quarantineWard,
    "name": name,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> updateFloorDataForm({
  String? name,
  int? quarantineBuilding,
  required int id,
}) {
  var data = {
    "id": id,
    "quarantine_building": quarantineBuilding,
    "name": name,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> createFloorDataForm({
  required int quarantineBuilding,
  required String name,
  
}) {
  var data = {
    "name": name,
    "quarantine_building": quarantineBuilding,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> updateRoomDataForm({
  String? name,
  int? quarantineFloor,
  int? capacity,
  required int id,
}) {
  var data = {
    "id": id,
    "quarantine_floor": quarantineFloor,
    "name": name,
    "capacity": capacity,
  };
  data.removeWhere((key, value) => key == "" || value == "");
  return data;
}

Map<String, dynamic> filterMemberByRoomDataForm({
  int? quarantineWard,
  int? quarantineBuilding,
  int? quarantineFloor,
  int? quarantineRoom,
}) {
  var data = {
    "quarantine_ward_id": quarantineWard,
    "quarantine_building_id": quarantineBuilding,
    "quarantine_floor_id": quarantineFloor,
    "quarantine_room_id": quarantineRoom,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> createMedDeclDataForm({
  String? phoneNumber,
  int? heartBeat,
  double? temperature,
  int? breathing,
  double? spo2,
  double? bloodPressure,
  String? mainSymtoms,
  String? extraSymtoms,
  String? otherSymtoms,
}) {
  var data = {
    "phone_number": phoneNumber,
    "heartbeat": heartBeat,
    "temperature": temperature,
    "breathing": breathing,
    "spo2": spo2,
    "blood_pressure": bloodPressure,
    "main_symptoms": mainSymtoms,
    "extra_symptoms": extraSymtoms,
    "other_symptoms": otherSymtoms,
  };
  return prepareDataForm(data);
}

Map<String, dynamic> filterMedDeclDataForm({
  String? userCode,
  String? createAtMax,
  String? createAtMin,
  int? page,
  int? pageSize,
  String? search,
}) {
  var data = {
    "user_code": userCode,
    "created_at_max": createAtMax,
    "created_at_min": createAtMin,
    "page": page,
    "page_size": pageSize,
    "search": search,
  };
  return prepareDataForm(data);
}


