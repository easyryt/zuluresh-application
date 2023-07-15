class OrderDetailsModel {
  Address? address;
  List<ProductDetails>? productDetails;
  int? totalPrice;
  int? discount;
  String? orderId;
  PaymentInfo? paymentInfo;
  PaymentMethod? paymentMethod;
  String? orderStatus;
  int? shipping;

  OrderDetailsModel(
      {this.address,
      this.productDetails,
      this.totalPrice,
      this.discount,
      this.orderId,
      this.paymentInfo,
      this.paymentMethod,
      this.orderStatus,
      this.shipping});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['ProductDetails'] != null) {
      productDetails = <ProductDetails>[];
      json['ProductDetails'].forEach((v) {
        productDetails!.add(ProductDetails.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
    discount = json['Discount'];
    orderId = json['orderId'];
    paymentInfo = json['PaymentInfo'] != null
        ? PaymentInfo.fromJson(json['PaymentInfo'])
        : null;
    paymentMethod = json['PaymentMethod'] != null
        ? PaymentMethod.fromJson(json['PaymentMethod'])
        : null;
    orderStatus = json['Order_Status'];
    shipping = json['Shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (productDetails != null) {
      data['ProductDetails'] = productDetails!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['Discount'] = discount;
    data['orderId'] = orderId;
    if (paymentInfo != null) {
      data['PaymentInfo'] = paymentInfo!.toJson();
    }
    if (paymentMethod != null) {
      data['PaymentMethod'] = paymentMethod!.toJson();
    }
    data['Order_Status'] = orderStatus;
    data['Shipping'] = shipping;
    return data;
  }
}

class Address {
  String? name;
  String? phone;
  String? houseNo;
  String? block;
  String? street;
  String? landmark;
  String? pincode;
  String? locality;
  String? addressAs;
  String? deliverySlot;

  Address(
      {this.name,
      this.phone,
      this.houseNo,
      this.block,
      this.street,
      this.landmark,
      this.pincode,
      this.locality,
      this.addressAs,
      this.deliverySlot});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    houseNo = json['houseNo'];
    block = json['block'];
    street = json['street'];
    landmark = json['Landmark'];
    pincode = json['pincode'];
    locality = json['locality'];
    addressAs = json['AddressAs'];
    deliverySlot = json['deliverySlot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['houseNo'] = houseNo;
    data['block'] = block;
    data['street'] = street;
    data['Landmark'] = landmark;
    data['pincode'] = pincode;
    data['locality'] = locality;
    data['AddressAs'] = addressAs;
    data['deliverySlot'] = deliverySlot;
    return data;
  }
}

class ProductDetails {
  String? productId;
  String? productTitle;
  String? productCategory;
  String? productImg;
  int? productMRP;
  int? productPrice;
  int? productQuantity;
  int? weight;

  ProductDetails(
      {this.productId,
      this.productTitle,
      this.productCategory,
      this.productImg,
      this.productMRP,
      this.productPrice,
      this.productQuantity,
      this.weight});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['Product_id'];
    productTitle = json['Product_title'];
    productCategory = json['Product_category'];
    productImg = json['ProductImg'];
    productMRP = json['Product_MRP'];
    productPrice = json['Product_price'];
    productQuantity = json['Product_quantity'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Product_id'] = productId;
    data['Product_title'] = productTitle;
    data['Product_category'] = productCategory;
    data['ProductImg'] = productImg;
    data['Product_MRP'] = productMRP;
    data['Product_price'] = productPrice;
    data['Product_quantity'] = productQuantity;
    data['weight'] = weight;
    return data;
  }
}

class PaymentInfo {
  String? id;
  Status? status;
  String? paidAt;

  PaymentInfo({this.id, this.status, this.paidAt});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    paidAt = json['paidAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['paidAt'] = paidAt;
    return data;
  }
}

class Status {
  String? type;

  Status({this.type});

  Status.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    return data;
  }
}

class PaymentMethod {
  bool? cod;
  bool? online;

  PaymentMethod({this.cod, this.online});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['online'] = online;
    return data;
  }
}
