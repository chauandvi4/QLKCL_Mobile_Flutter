import 'package:qlkcl/models/key_value.dart';

class Constant {
  static const String baseUrl = 'https://qlkcl.herokuapp.com';
  static const String login = '/api/token';
  static const String register = '/api/user/member/register';
  static const String getMember = '/api/user/member/get';
  static const String getListMembers = '/api/user/member/filter';
  static const String createMember = '/api/user/member/create';
  static const String updateMember = '/api/user/member/update';
  static const String denyMember = '/api/user/member/refuse';
  static const String acceptMember = '/api/user/member/accept';
  static const String finishMember = '/api/user/member/finish_quarantine';
  static const String homeManager = '/api/user/home/manager';
  static const String getListTests = '/api/form/test/filter';
  static const String createTest = '/api/form/test/create';
  static const String updateTest = '/api/form/test/update';
  static const String getTest = '/api/form/test/get';
  static const String getQuarantine = '/api/quarantine_ward/ward/get';
  static const String getListQuarantine = '/api/quarantine_ward/ward/filter';
  static const String getListQuarantineNoToekn =
      '/api/quarantine_ward/ward/filter_register';
  static const String getListCountry = '/api/address/country/filter';
  static const String getListCity = '/api/address/city/filter';
  static const String getListDistrict = '/api/address/district/filter';
  static const String getListWard = '/api/address/ward/filter';
  static const String getListBuilding = '/api/quarantine_ward/building/filter';
  static const String getListFloor = '/api/quarantine_ward/floor/filter';
  static const String getListRoom = '/api/quarantine_ward/room/filter';
  static const String requestOtp = '/api/oauth/reset_password/set';
  static const String sendOtp = '/api/oauth/reset_password/otp';
  static const String createPass = '/api/oauth/reset_password/confirm';
  static const String changePass = '/api/oauth/change_password/confirm';
  static const String createQuarantine = '/api/quarantine_ward/ward/create';
  static const String updateQuarantine = '/api/quarantine_ward/ward/update';
  static const String getBuilding = '/api/quarantine_ward/building/get';
  static const String createBuilding = '/api/quarantine_ward/building/create';
  static const String updateBuilding = '/api/quarantine_ward/building/update';
  static const String deleteBuilding = '/api/quarantine_ward/building/delete';
  static const String getFloor = '/api/quarantine_ward/floor/get';
  static const String createFloor = '/api/quarantine_ward/floor/create';
  static const String updateFloor = '/api/quarantine_ward/floor/update';
  static const String deleteFloor = '/api/quarantine_ward/floor/delete';
  static const String getRoom = '/api/quarantine_ward/room/get';
  static const String createRoom = '/api/quarantine_ward/room/create';
  static const String updateRoom = '/api/quarantine_ward/room/update';
  static const String deleteRoom = '/api/quarantine_ward/room/delete';
  static const String filterMedDecl = '/api/form/medical-declaration/filter';
  static const String getMedDecl = '/api/form/medical-declaration/get';
  static const String createMedDecl = '/api/form/medical-declaration/create';
  static const String getListNotMem = '/api/user/member/not_member_filter';
}

enum Permission {
  add,
  edit,
  view,
  delete,
  change_status,
}

List<KeyValue> genderList = [
  KeyValue(id: "MALE", name: "Nam"),
  KeyValue(id: "FEMALE", name: "Nữ")
];

List<KeyValue> testStateList = [
  KeyValue(id: "WAITING", name: "Đang chờ kết quả"),
  KeyValue(id: "DONE", name: "Đã có kết quả")
];

List<KeyValue> testTypeList = [
  KeyValue(id: "QUICK", name: "Test nhanh"),
  KeyValue(id: "RT-PCR", name: "Real time PCR")
];

List<KeyValue> testValueList = [
  KeyValue(id: "NONE", name: "Chưa có kết quả"),
  KeyValue(id: "NEGATIVE", name: "Âm tính"),
  KeyValue(id: "POSITIVE", name: "Dương tính")
];

List<KeyValue> medDeclValueList = [
  KeyValue(id: "NORMAL", name: "Bình thường"),
  KeyValue(id: "UNWELL", name: "Có dấu hiệu nghi nhiễm"),
  KeyValue(id: "SERIOUS", name: "Nghi nhiễm")
];

List<KeyValue> roleList = [
  KeyValue(id: "1", name: "ADMINISTRATOR"),
  KeyValue(id: "2", name: "SUPER_MANAGER"),
  KeyValue(id: "3", name: "MANAGER"),
  KeyValue(id: "4", name: "STAFF"),
  KeyValue(id: "5", name: "MEMBER"),
];

List<KeyValue> nationalityList = [
  KeyValue(id: 1, name: 'Việt Nam'),
];

List<KeyValue> backgroundDiseaseList = [
  KeyValue(id: 1, name: "Tiểu đường"),
  KeyValue(id: 2, name: "Ung thư"),
  KeyValue(id: 3, name: "Tăng huyết áp"),
  KeyValue(id: 4, name: "Bệnh hen suyễn"),
  KeyValue(id: 5, name: "Bệnh gan"),
  KeyValue(id: 6, name: "Bệnh thận mãn tính"),
  KeyValue(id: 7, name: "Tim mạch"),
  KeyValue(id: 8, name: "Bệnh lý mạch máu não"),
];

List<KeyValue> quarantineStatusList = [
  KeyValue(id: "RUNNING", name: "Đang hoạt động"),
  KeyValue(id: "LOCKED", name: "Khóa"),
  KeyValue(id: "UNKNOWN", name: "Chưa rõ"),
];

List<KeyValue> quarantineTypeList = [
  KeyValue(id: "CONCENTRATE", name: "Tập trung"),
  KeyValue(id: "PRIVATE", name: "Tư nhân"),
];

List<KeyValue> symptomMainList = [
  KeyValue(id: 1, name: "Ho ra máu"),
  KeyValue(id: 2, name: "Thở dốc, khó thở"),
  KeyValue(id: 3, name: "Đau tức ngực kéo dài"),
  KeyValue(id: 4, name: "Lơ mơ, không tỉnh táo"),
];

List<KeyValue> symptomExtraList = [
  KeyValue(id: 5, name: "Mệt mỏi"),
  KeyValue(id: 6, name: "Ho"),
  KeyValue(id: 7, name: "Ho có đờm"),
  KeyValue(id: 8, name: "Đau họng"),
  KeyValue(id: 9, name: "Đau đầu"),
  KeyValue(id: 10, name: "Chóng mặt"),
  KeyValue(id: 11, name: "Chán ăn"),
  KeyValue(id: 12, name: "Nôn / Buồn nôn"),
  KeyValue(id: 13, name: "Tiêu chảy"),
  KeyValue(id: 14, name: "Xuất huyết ngoài da"),
  KeyValue(id: 15, name: "Nổi ban ngoài da"),
  KeyValue(id: 16, name: "Ớn lạnh / gai rét"),
  KeyValue(id: 17, name: "Viêm kết mạc (mắt đỏ)"),
  KeyValue(id: 18, name: "Mất vị giác, khứu giác"),
  KeyValue(id: 19, name: "Đau nhức cơ"),
];

const int PAGE_SIZE = 10;
const int PAGE_SIZE_MAX = 0;
