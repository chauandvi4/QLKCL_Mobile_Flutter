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
  KeyValue(id: "FEMALE", name: "N???")
];

List<KeyValue> testStateList = [
  KeyValue(id: "WAITING", name: "??ang ch??? k???t qu???"),
  KeyValue(id: "DONE", name: "???? c?? k???t qu???")
];

List<KeyValue> testTypeList = [
  KeyValue(id: "QUICK", name: "Test nhanh"),
  KeyValue(id: "RT-PCR", name: "Real time PCR")
];

List<KeyValue> testValueList = [
  KeyValue(id: "NONE", name: "Ch??a c?? k???t qu???"),
  KeyValue(id: "NEGATIVE", name: "??m t??nh"),
  KeyValue(id: "POSITIVE", name: "D????ng t??nh")
];

List<KeyValue> medDeclValueList = [
  KeyValue(id: "NORMAL", name: "B??nh th?????ng"),
  KeyValue(id: "UNWELL", name: "C?? d???u hi???u nghi nhi???m"),
  KeyValue(id: "SERIOUS", name: "Nghi nhi???m")
];

List<KeyValue> roleList = [
  KeyValue(id: "1", name: "ADMINISTRATOR"),
  KeyValue(id: "2", name: "SUPER_MANAGER"),
  KeyValue(id: "3", name: "MANAGER"),
  KeyValue(id: "4", name: "STAFF"),
  KeyValue(id: "5", name: "MEMBER"),
];

List<KeyValue> nationalityList = [
  KeyValue(id: 1, name: 'Vi???t Nam'),
];

List<KeyValue> backgroundDiseaseList = [
  KeyValue(id: 1, name: "Ti???u ???????ng"),
  KeyValue(id: 2, name: "Ung th??"),
  KeyValue(id: 3, name: "T??ng huy???t ??p"),
  KeyValue(id: 4, name: "B???nh hen suy???n"),
  KeyValue(id: 5, name: "B???nh gan"),
  KeyValue(id: 6, name: "B???nh th???n m??n t??nh"),
  KeyValue(id: 7, name: "Tim m???ch"),
  KeyValue(id: 8, name: "B???nh l?? m???ch m??u n??o"),
];

List<KeyValue> quarantineStatusList = [
  KeyValue(id: "RUNNING", name: "??ang ho???t ?????ng"),
  KeyValue(id: "LOCKED", name: "Kh??a"),
  KeyValue(id: "UNKNOWN", name: "Ch??a r??"),
];

List<KeyValue> quarantineTypeList = [
  KeyValue(id: "CONCENTRATE", name: "T???p trung"),
  KeyValue(id: "PRIVATE", name: "T?? nh??n"),
];

List<KeyValue> symptomMainList = [
  KeyValue(id: 1, name: "Ho ra m??u"),
  KeyValue(id: 2, name: "Th??? d???c, kh?? th???"),
  KeyValue(id: 3, name: "??au t???c ng???c k??o d??i"),
  KeyValue(id: 4, name: "L?? m??, kh??ng t???nh t??o"),
];

List<KeyValue> symptomExtraList = [
  KeyValue(id: 5, name: "M???t m???i"),
  KeyValue(id: 6, name: "Ho"),
  KeyValue(id: 7, name: "Ho c?? ?????m"),
  KeyValue(id: 8, name: "??au h???ng"),
  KeyValue(id: 9, name: "??au ?????u"),
  KeyValue(id: 10, name: "Ch??ng m???t"),
  KeyValue(id: 11, name: "Ch??n ??n"),
  KeyValue(id: 12, name: "N??n / Bu???n n??n"),
  KeyValue(id: 13, name: "Ti??u ch???y"),
  KeyValue(id: 14, name: "Xu???t huy???t ngo??i da"),
  KeyValue(id: 15, name: "N???i ban ngo??i da"),
  KeyValue(id: 16, name: "???n l???nh / gai r??t"),
  KeyValue(id: 17, name: "Vi??m k???t m???c (m???t ?????)"),
  KeyValue(id: 18, name: "M???t v??? gi??c, kh???u gi??c"),
  KeyValue(id: 19, name: "??au nh???c c??"),
];

const int PAGE_SIZE = 10;
const int PAGE_SIZE_MAX = 0;
