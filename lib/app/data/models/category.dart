import 'product.dart';

class Category {
  int? id;
  String? name;
  List<Product>? products;

  Category({this.id, this.name, this.products});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    data['name'] = name;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
