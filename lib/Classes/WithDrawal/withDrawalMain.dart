class WithdrawalMain {
  int withdrawalID;
  DateTime startDate;
  DateTime endDate;
  DateTime createDate;
  int productNo;
  String ticketPrice;
  int nbrOfTickets;
  int nbrOfTicketsLeft;
  int ownerUserNo;

  WithdrawalMain({
    required this.withdrawalID,
    required this.startDate,
    required this.endDate,
    required this.createDate,
    required this.productNo,
    required this.ticketPrice,
    required this.nbrOfTickets,
    required this.nbrOfTicketsLeft,
    required this.ownerUserNo,
  });

  factory WithdrawalMain.fromJson(Map<String, dynamic> json) {
    return WithdrawalMain(
      withdrawalID: json['WithDrawalID'] ?? 0,
      startDate: DateTime.parse(json['StartDate']['date']),
      endDate: DateTime.parse(json['EndDate']['date']),
      createDate: DateTime.parse(json['CreateDate']['date']),
      productNo: json['ProductNo'] ?? 0,
      ticketPrice: json['TicketPrice'] ?? "",
      nbrOfTickets: json['NbrOfTickets'] ?? 0,
      nbrOfTicketsLeft: json['NbrOfTicketsLeft'] ?? 0,
      ownerUserNo: json['OwnerUserNo'] ?? 0,
    );
  }
}