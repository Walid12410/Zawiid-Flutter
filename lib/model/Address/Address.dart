class Address {
  final int addressNo;
  final int addressType;
  final String contactPhoneNumber;
  final int governorate;
  final int area;
  final String block;
  final String street;
  final String building;
  final String floorDoor;
  final int userNo;

  Address({
    required this.addressNo,
    required this.addressType,
    required this.contactPhoneNumber,
    required this.governorate,
    required this.area,
    required this.block,
    required this.street,
    required this.building,
    required this.floorDoor,
    required this.userNo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressNo: json['AddressNo'] ?? 0,
      addressType: json['AddressType'] ?? 0,
      contactPhoneNumber: json['ContactPhoneNumber'] ?? '',
      governorate: json['Governerate'] ?? 0,
      area: json['Area'] ?? 0,
      block: json['Block'] ?? '',
      street: json['Street'] ?? '',
      building: json['Building'] ?? '',
      floorDoor: json['Floor_Door'] ?? '',
      userNo: json['UserNo'] ?? 0,
    );
  }
}
