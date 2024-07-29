class TotalWithDrawl {
  int userNo;
  int totalTicketsWithdrawn;

  TotalWithDrawl({
    required this.userNo,
    required this.totalTicketsWithdrawn
  });

  factory TotalWithDrawl.fromJson(Map<String, dynamic> json) {
    return TotalWithDrawl(
      userNo: json['UserNo'] ?? 0,
      totalTicketsWithdrawn: json['TotalTicketsWithdrawn'] ?? 0,
    );
  }
}