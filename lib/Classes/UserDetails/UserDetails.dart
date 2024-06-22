import 'UserBirthDate.dart';

class UserInformation {
  UserInformation({
    required this.userNo,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.govNo,
    required this.areaNo,
    required this.email,
    required this.tel,
  });

  final int userNo;
  final String firstName;
  final String lastName;
  final BirthDate? birthDate;
  final String gender;
  final int govNo;
  final int areaNo;
  final String email;
  final String tel;

  factory UserInformation.fromJson(Map<String, dynamic> json){
    return UserInformation(
      userNo: json["UserNo"] ?? 0,
      firstName: json["FirstName"] ?? '',
      lastName: json["LastName"] ?? '',
      birthDate: json['BirthDate'] != null ? BirthDate.fromJson(json['BirthDate']) : null,
      gender: json["Gender"] ?? '',
      govNo: json["GovNo"] ?? 0,
      areaNo: json["AreaNo"] ?? 0,
      email: json["Email"] ?? '',
      tel: json["Tel"] ?? '',
    );
  }

}



