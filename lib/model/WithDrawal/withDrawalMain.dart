class Ticket {
  final int withdrawalID;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createDate;
  final int productNo;
  final String ticketPrice;
  final int nbrOfTickets;
  final int nbrOfTicketsLeft;
  final int? ownerUserNo;
  final String ticketTitle;
  final String productName;
  final String size;
  final int markNo;
  final int colorNo;
  final String markName;
  final String colorName;
  final String image;

  Ticket({
    required this.withdrawalID,
    required this.startDate,
    required this.endDate,
    required this.createDate,
    required this.productNo,
    required this.ticketPrice,
    required this.nbrOfTickets,
    required this.nbrOfTicketsLeft,
    this.ownerUserNo,
    required this.ticketTitle,
    required this.productName,
    required this.size,
    required this.markNo,
    required this.colorNo,
    required this.markName,
    required this.colorName,
    required this.image
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      withdrawalID: json['WithDrawalID'] ?? 0,
      startDate: DateTime.parse(json['StartDate']['date'] ?? '1970-01-01T00:00:00Z'),
      endDate: DateTime.parse(json['EndDate']['date'] ?? '1970-01-01T00:00:00Z'),
      createDate: DateTime.parse(json['CreateDate']['date'] ?? '1970-01-01T00:00:00Z'),
      productNo: json['ProductNo'] ?? 0,
      ticketPrice: json['TicketPrice'] ?? "0.0",
      nbrOfTickets: json['NbrOfTickets'] ?? 0,
      nbrOfTicketsLeft: json['NbrOfTicketsLeft'] ?? 0,
      ownerUserNo: json['OwnerUserNo'],
      ticketTitle: json['TicketTitle'] ?? '',
      productName: json['ProductName'] ?? '',
      size: json['size'] ?? '',
      markNo: json['MarkNo'] ?? 0,
      colorNo: json['ColorNo'] ?? 0,
      markName: json['MarkName'] ?? '',
      colorName: json['ColorName'] ?? '',
      image: json['ProductImage'] ?? ''
    );
  }
}
