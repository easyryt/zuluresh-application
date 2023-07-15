class SingleProductModel {
  String? sId;
  String? title;
  String? description;
  int? pieces;
  int? mRP;
  int? price;
  String? discount;
  List<ProductImg>? productImg;
  String? category;
  String? subCategory;
  int? stock;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SingleProductModel(
      {this.sId,
        this.title,
        this.description,
        this.pieces,
        this.mRP,
        this.price,
        this.discount,
        this.productImg,
        this.category,
        this.subCategory,
        this.stock,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SingleProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    pieces = json['pieces'];
    mRP = json['MRP'];
    price = json['price'];
    discount = json['discount'];
    if (json['productImg'] != null) {
      productImg = <ProductImg>[];
      json['productImg'].forEach((v) {
        productImg!.add(ProductImg.fromJson(v));
      });
    }
    category = json['category'];
    subCategory = json['sub_category'];
    stock = json['Stock'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['pieces'] = pieces;
    data['MRP'] = mRP;
    data['price'] = price;
    data['discount'] = discount;
    if (productImg != null) {
      data['productImg'] = productImg!.map((v) => v.toJson()).toList();
    }
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['Stock'] = stock;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ProductImg {
  String? publicId;
  String? url;
  String? sId;

  ProductImg({this.publicId, this.url, this.sId});

  ProductImg.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    data['_id'] = sId;
    return data;
  }
}
