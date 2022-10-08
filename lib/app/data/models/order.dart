import 'product.dart';

class Order {
  String? id;
  String? customer;
  String? date;
  String? time;
  int? discount;
  int? total;
  int? bayar;
  List<Product>? products;

  Order(
      {this.id,
      this.customer,
      this.date,
      this.time,
      this.discount,
      this.total,
      this.bayar,
      this.products});

  Order.fromJson(Map<String, dynamic> json, String idDocument) {
    id = idDocument;
    customer = json['customer'];
    date = json['date'];
    time = json['time'];
    discount = json['discount'];
    total = json['total'];
    bayar = json['bayar'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer'] = customer;
    data['date'] = date;
    data['time'] = time;
    data['discount'] = discount;
    data['total'] = total;
    data['bayar'] = bayar;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
