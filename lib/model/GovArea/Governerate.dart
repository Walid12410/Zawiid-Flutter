class Governorate {
  Governorate({
    required this.governerateId,
    required this.governerateName,
  });

  final int governerateId;
  final String governerateName;

  factory Governorate.fromJson(Map<String, dynamic> json){
    return Governorate(
      governerateId: json["GovernerateID"] ?? 0,
      governerateName: json["GovernerateName"] ?? '',
    );
  }

}
