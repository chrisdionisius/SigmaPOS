import 'category.dart';

class Store {
  String? id;
  String? name;
  String? userUid;
  List<Category>? categories;

  Store({this.id, this.name, this.userUid, this.categories});

  Store.fromJson(Map<String, dynamic> json, String storeId) {
    id = storeId;
    name = json['name'];
    userUid = json['userUid'];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v, 'a'));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['userUid'] = userUid;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
