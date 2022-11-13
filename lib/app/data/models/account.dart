class Account {
  String? id;
  String? email;
  String? name;
  String? role;
  String? storeUid;

  Account({this.name, this.role, this.storeUid});

  Account.fromJson(Map<String, dynamic> json, String uid) {
    id = uid;
    email = json['email'];
    name = json['name'];
    role = json['role'];
    storeUid = json['store_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    data['store_uid'] = storeUid;
    return data;
  }
}
