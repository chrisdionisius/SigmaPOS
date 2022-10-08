class Product {
  int? id;
  String? name;
  int? price;
  int? amount;

  Product({this.id, this.name, this.price, this.amount});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['amount'] = amount;
    return data;
  }
}
