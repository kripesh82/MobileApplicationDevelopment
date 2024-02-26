class CategoryModel {
  String? name, image, id;

  CategoryModel({this.name, this.image,this.id});

  CategoryModel.fromJson(Map<dynamic, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    name = map['name'];
    image = map['image'];
    id = map['catId'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'catTd': id,
    };
  }
}