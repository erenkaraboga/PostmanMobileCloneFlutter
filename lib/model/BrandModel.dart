class BrandModel {
  int? id;
  String? name;
  String? madeby;
  String? imageUrl;

  BrandModel({this.id, this.name, this.madeby, this.imageUrl});

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    madeby = json['madeby'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['madeby'] = madeby;
    data['imageUrl'] = imageUrl;
    return data;
  }
}