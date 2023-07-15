class BestSellerDealsCombosSingleProductModel {
  String? sId;
  String? title;
  String? description;
  int? weightperKg;
  int? mRP;
  int? price;
  String? discount;
  List<ProductImg>? productImg;
  String? category;
  String? subCategory;
  int? stock;
  String? setAs;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BestSellerDealsCombosSingleProductModel(
      {this.sId,
        this.title,
        this.description,
        this.weightperKg,
        this.mRP,
        this.price,
        this.discount,
        this.productImg,
        this.category,
        this.subCategory,
        this.stock,
        this.setAs,
        this.createdAt,
        this.updatedAt,
        this.iV});

  BestSellerDealsCombosSingleProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    weightperKg = json['weightperKg'];
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
    setAs = json['setAs'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['weightperKg'] = weightperKg;
    data['MRP'] = mRP;
    data['price'] = price;
    data['discount'] = discount;
    if (productImg != null) {
      data['productImg'] = productImg!.map((v) => v.toJson()).toList();
    }
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['Stock'] = stock;
    data['setAs'] = setAs;
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
