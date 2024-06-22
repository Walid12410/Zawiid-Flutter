class BirthDate {
  BirthDate({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  final DateTime? date;
  final int timezoneType;
  final String timezone;

  factory BirthDate.fromJson(Map<String, dynamic> json){
    return BirthDate(
      date: DateTime.tryParse(json["date"] ?? ""),
      timezoneType: json["timezone_type"] ?? 0,
      timezone: json["timezone"] ?? '',
    );
  }
}