class BannerModel {
  BannerImg? bannerImg;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BannerModel(
      {this.bannerImg, this.sId, this.createdAt, this.updatedAt, this.iV});

  BannerModel.fromJson(Map<String, dynamic> json) {
    bannerImg = json['bannerImg'] != null
        ? BannerImg.fromJson(json['bannerImg'])
        : null;
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bannerImg != null) {
      data['bannerImg'] = bannerImg!.toJson();
    }
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class BannerImg {
  String? publicId;
  String? url;

  BannerImg({this.publicId, this.url});

  BannerImg.fromJson(Map<String, dynamic> json) {
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
