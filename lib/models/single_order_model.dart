class SingleOrderModel {
  ShippingInfo? shippingInfo;
  PaymentMethod? paymentMethod;
  String? sId;
  List<Items>? items;
  int? shippingPrice;
  double? totalPrice;
  int? totalItems;
  String? orderStatus;
  String? userId;
  String? orderId;
  String? userID;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SingleOrderModel(
      {this.shippingInfo,
        this.paymentMethod,
        this.sId,
        this.items,
        this.shippingPrice,
        this.totalPrice,
        this.totalItems,
        this.orderStatus,
        this.userId,
        this.orderId,
        this.userID,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SingleOrderModel.fromJson(Map<String, dynamic> json) {
    shippingInfo = json['shippingInfo'] != null
        ? ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    paymentMethod = json['paymentMethod'] != null
        ? PaymentMethod.fromJson(json['paymentMethod'])
        : null;
    sId = json['_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    shippingPrice = json['shippingPrice'];
    totalPrice = json['totalPrice'].toDouble();
    totalItems = json['totalItems'];
    orderStatus = json['orderStatus'];
    userId = json['userId'];
    orderId = json['orderId'];
    userID = json['userID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    if (paymentMethod != null) {
      data['paymentMethod'] = paymentMethod!.toJson();
    }
    data['_id'] = sId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['shippingPrice'] = shippingPrice;
    data['totalPrice'] = totalPrice;
    data['totalItems'] = totalItems;
    data['orderStatus'] = orderStatus;
    data['userId'] = userId;
    data['orderId'] = orderId;
    data['userID'] = userID;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ShippingInfo {
  DeliverySlot? deliverySlot;
  String? name;
  String? phoneNo;
  String? houseFlatNo;
  String? blockName;
  String? street;
  String? landMark;
  String? pinCode;
  String? locality;
  String? saveAddressAs;

  ShippingInfo(
      {this.deliverySlot,
        this.name,
        this.phoneNo,
        this.houseFlatNo,
        this.blockName,
        this.street,
        this.landMark,
        this.pinCode,
        this.locality,
        this.saveAddressAs});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    deliverySlot = json['deliverySlot'] != null
        ? DeliverySlot.fromJson(json['deliverySlot'])
        : null;
    name = json['name'];
    phoneNo = json['phoneNo'];
    houseFlatNo = json['houseFlatNo'];
    blockName = json['blockName'];
    street = json['street'];
    landMark = json['landMark'];
    pinCode = json['pinCode'];
    locality = json['locality'];
    saveAddressAs = json['saveAddressAs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliverySlot != null) {
      data['deliverySlot'] = deliverySlot!.toJson();
    }
    data['name'] = name;
    data['phoneNo'] = phoneNo;
    data['houseFlatNo'] = houseFlatNo;
    data['blockName'] = blockName;
    data['street'] = street;
    data['landMark'] = landMark;
    data['pinCode'] = pinCode;
    data['locality'] = locality;
    data['saveAddressAs'] = saveAddressAs;
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
