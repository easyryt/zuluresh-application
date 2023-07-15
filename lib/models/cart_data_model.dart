class CartDataModel {
  List<ProductsData>? productsData;
  int? totalItems;
  int? discount;
  String? cartId;
  int? totalPrice;
  int? shipping;

  CartDataModel(
      {this.productsData,
      this.totalItems,
      this.discount,
      this.cartId,
      this.totalPrice,
      this.shipping});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    if (json['productsData'] != null) {
      productsData = <ProductsData>[];
      json['productsData'].forEach((v) {
        productsData!.add(ProductsData.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    discount = json['Discount'];
    cartId = json['cartId'];
    totalPrice = json['TotalPrice'];
    shipping = json['Shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productsData != null) {
      data['productsData'] = productsData!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = totalItems;
    data['Discount'] = discount;
    data['cartId'] = cartId;
    data['TotalPrice'] = totalPrice;
    data['Shipping'] = shipping;
    return data;
  }
}

class ProductsData {
  String? sId;
  String? title;
  String? category;
  int? price;
  int? productQuantity;
  int? productMrp;
  String? productImage;
  int? pieces;

  ProductsData({
    this.sId,
    this.title,
    this.category,
    this.price,
    this.productQuantity,
    this.productImage,
    this.productMrp,
    this.pieces,
  });

  ProductsData.fromJson(Map<String, dynamic> json) {
    sId = json['Product_id'];
    title = json['Product_title'];
    category = json['Product_category'];
    price = json['Product_price'];
    productQuantity = json['Product_quantity'];
    productImage = json['Product_image'];
    productMrp = json['Product_MRP'];
    pieces = json['Pieces'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Product_id'] = sId;
    data['Product_title'] = title;
    data['Product_category'] = category;
    data['Product_price'] = price;
    data['Product_quantity'] = productQuantity;
    data['Product_MRP'] = productMrp;
    data['Product_image'] = productImage;
    data['Pieces'] = pieces;
    return data;
  }
}
