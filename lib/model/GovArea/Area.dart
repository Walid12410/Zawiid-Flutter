class Area {
  Area({
    required this.areaId,
    required this.areaName,
    required this.governerateId,
  });

  final int areaId;
  final String areaName;
  final int governerateId;

  factory Area.fromJson(Map<String, dynamic> json){
    return Area(
      areaId: json["AreaID"] ?? 0,
      areaName: json["AreaName"] ?? '',
      governerateId: json["GovernerateID"] ?? 0,
    );
  }
}
