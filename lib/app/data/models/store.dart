import 'category.dart';

class Store {
  int? id;
  String? name;
  String? owner;
  List<Category>? categories;

  Store({this.id, this.name, this.owner, this.categories});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    owner = json['owner'];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['owner'] = owner;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
