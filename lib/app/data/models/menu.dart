class Menu {
  String? name;
  int? icon;
  String? route;

  Menu({this.name, this.icon, this.route});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['route'] = route;
    return data;
  }
}
