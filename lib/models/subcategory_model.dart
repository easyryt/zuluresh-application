class SubCategoryModel {
  SubCategoryImg? subCategoryImg;
  String? sId;
  String? categoryId;
  String? subCategoryName;
  int? iV;

  SubCategoryModel({
    this.subCategoryImg,
    this.sId,
    this.categoryId,
    this.subCategoryName,
    this.iV,
  });

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    subCategoryImg = json['subCategoryImg'] != null
        ? SubCategoryImg.fromJson(json['subCategoryImg'])
        : null;
    sId = json['_id'];
    categoryId = json['categoryId'];
    subCategoryName = json['subCategoryName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subCategoryImg != null) {
      data['subCategoryImg'] = subCategoryImg!.toJson();
    }
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['subCategoryName'] = subCategoryName;
    data['__v'] = iV;
    return data;
  }
}

class SubCategoryImg {
  String? publicId;
  String? url;

  SubCategoryImg({
    this.publicId,
    this.url,
  });

  SubCategoryImg.fromJson(Map<String, dynamic> json) {
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
