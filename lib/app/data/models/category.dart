import 'product.dart';

class Category {
  String? id;
  String? name;
  List<Product>? products;

  Category({this.id, this.name, this.products});

  Category.fromJson(Map<String, dynamic> json, String idDocument) {
    id = idDocument;
    name = json['name'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v, 'a'));
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
