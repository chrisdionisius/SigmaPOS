import 'category.dart';

class Store {
  String? id;
  String? name;
  String? ownerUid;
  String? registerCode;
  List<Category>? categories;

  Store(
      {this.id, this.name, this.ownerUid, this.registerCode, this.categories});

  Store.fromJson(Map<String, dynamic> json, String storeId) {
    id = storeId;
    name = json['name'];
    ownerUid = json['owner_uid'];
    registerCode = json['register_code'];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v, 'a'));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['name'] = name;
    data['owner_uid'] = ownerUid;
    data['register_code'] = registerCode;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
