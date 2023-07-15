class SuccessOrderModel {
  ShippingInfo? shippingInfo;
  List<Items>? items;
  int? shippingPrice;
  double? totalPrice;
  int? totalItems;
  PaymentMethod? paymentMethod;
  String? orderStatus;
  String? userId;
  String? orderId;
  String? userID;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SuccessOrderModel(
      {this.shippingInfo,
      this.items,
      this.shippingPrice,
      this.totalPrice,
      this.totalItems,
      this.paymentMethod,
      this.orderStatus,
      this.userId,
      this.orderId,
      this.userID,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SuccessOrderModel.fromJson(Map<String, dynamic> json) {
    shippingInfo = json['shippingInfo'] != null
        ? ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    shippingPrice = json['shippingPrice'];
    totalPrice = json['totalPrice'].toDouble();
    totalItems = json['totalItems'];
    paymentMethod = json['paymentMethod'] != null
        ? PaymentMethod.fromJson(json['paymentMethod'])
        : null;
    orderStatus = json['orderStatus'];
    userId = json['userId'];
    orderId = json['orderId'];
    userID = json['userID'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['shippingPrice'] = shippingPrice;
    data['totalPrice'] = totalPrice;
    data['totalItems'] = totalItems;
    if (paymentMethod != null) {
      data['paymentMethod'] = paymentMethod!.toJson();
    }
    data['orderStatus'] = orderStatus;
    data['userId'] = userId;
    data['orderId'] = orderId;
    data['userID'] = userID;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ShippingInfo {
  String? name;
  String? phoneNo;
  String? houseFlatNo;
  String? blockName;
  String? street;
  String? landMark;
  String? pinCode;
  String? locality;
  String? saveAddressAs;
  DeliverySlot? deliverySlot;

  ShippingInfo(
      {this.name,
      this.phoneNo,
      this.houseFlatNo,
      this.blockName,
      this.street,
      this.landMark,
      this.pinCode,
      this.locality,
      this.saveAddressAs,
      this.deliverySlot});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNo = json['phoneNo'];
    houseFlatNo = json['houseFlatNo'];
    blockName = json['blockName'];
    street = json['street'];
    landMark = json['landMark'];
    pinCode = json['pinCode'];
    locality = json['locality'];
    saveAddressAs = json['saveAddressAs'];
    deliverySlot = json['deliverySlot'] != null
        ? DeliverySlot.fromJson(json['deliverySlot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNo'] = phoneNo;
    data['houseFlatNo'] = houseFlatNo;
    data['blockName'] = blockName;
    data['street'] = street;
    data['landMark'] = landMark;
    data['pinCode'] = pinCode;
    data['locality'] = locality;
    data['saveAddressAs'] = saveAddressAs;
    if (deliverySlot != null) {
      data['deliverySlot'] = deliverySlot!.toJson();
    }
    return data;
  }
}

class DeliverySlot {
  String? day;
  String? startTime;
  String? endTime;

  DeliverySlot({this.day, this.startTime, this.endTime});

  DeliverySlot.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}

class Items {
  String? productId;
  int? quantity;
  String? sId;

  Items({this.productId, this.quantity, this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['_id'] = sId;
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
