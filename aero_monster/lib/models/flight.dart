class Flight {
  int id;
  int from;
  int to;
  String date;
  num price;
  Flight({
    required this.id,
    required this.from,
    required this.to,
    required this.date,
    required this.price,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
        id: json['id'],
        from: json['from'],
        to: json['to'],
        date: json['date'],
        price: json['price']);
  }
}
