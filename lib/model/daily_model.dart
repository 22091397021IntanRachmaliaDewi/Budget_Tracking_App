import 'dart:convert';

class DailyModel {
  String id;
  final String icon;
  final String name;
  final String date;
  final String price;

  DailyModel({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
    required this.price,
  });

  factory DailyModel.fromJson(String str) => DailyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyModel.fromMap(Map<String, dynamic> json) => DailyModel(
        id: json["id"],
        icon: json["icon"],
        name: json["name"],
        date: json["date"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "icon": icon,
        "name": name,
        "date": date,
        "price": price,
      };

  @override
  String toString() {
    return 'DailyModel(id: $id, icon: $icon, name: $name, date: $date, price: $price)';
  }
}

const List daily = [
  {"icon": "asset/bank.png", "name": "Bank", "date": "Fri 10AM", "price": "Rp 340.00"},
  {"icon": "asset/auto.png", "name": "Automobile", "date": "Mon 8AM", "price": "Rp 70.00"},
  {"icon": "asset/gift.png", "name": "Gift", "date": "Sat 6PM", "price": "Rp 110.00"},
  {"icon": "asset/eating.png", "name": "Eating", "date": "Sun 5PM", "price": "Rp 60.00"},
  {"icon": "asset/charity.png", "name": "Charity", "date": "Wed 12PM", "price": "Rp 1200.00"}
];
