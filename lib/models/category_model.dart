class CategoryModel {
  CategoryImg? categoryImg;
  String? sId;
  String? categoryName;
  int? iV;

  CategoryModel({this.categoryImg, this.sId, this.categoryName, this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryImg = json['categoryImg'] != null
        ? CategoryImg.fromJson(json['categoryImg'])
        : null;
    sId = json['_id'];
    categoryName = json['categoryName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryImg != null) {
      data['categoryImg'] = categoryImg!.toJson();
    }
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    data['__v'] = iV;
    return data;
  }
}

class CategoryImg {
  String? publicId;
  String? url;

  CategoryImg({this.publicId, this.url});

  CategoryImg.fromJson(Map<String, dynamic> json) {
    publicId = json['public_Id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_Id'] = publicId;
    data['url'] = url;
    return data;
  }
}
