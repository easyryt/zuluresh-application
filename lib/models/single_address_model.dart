class SingleAddressModel {
  String? sId;
  String? name;
  String? phoneNo;
  String? houseFlatNo;
  String? blockName;
  String? street;
  String? landMark;
  String? pinCode;
  String? locality;
  String? saveAddressAs;
  String? userId;
  String? userID;
  bool? setAsDefault;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SingleAddressModel(
      {this.sId,
        this.name,
        this.phoneNo,
        this.houseFlatNo,
        this.blockName,
        this.street,
        this.landMark,
        this.pinCode,
        this.locality,
        this.saveAddressAs,
        this.userId,
        this.userID,
        this.setAsDefault,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SingleAddressModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    houseFlatNo = json['houseFlatNo'];
    blockName = json['blockName'];
    street = json['street'];
    landMark = json['landMark'];
    pinCode = json['pinCode'];
    locality = json['locality'];
    saveAddressAs = json['saveAddressAs'];
    userId = json['userId'];
    userID = json['userID'];
    setAsDefault = json['setAsDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phoneNo'] = phoneNo;
    data['houseFlatNo'] = houseFlatNo;
    data['blockName'] = blockName;
    data['street'] = street;
    data['landMark'] = landMark;
    data['pinCode'] = pinCode;
    data['locality'] = locality;
    data['saveAddressAs'] = saveAddressAs;
    data['userId'] = userId;
    data['userID'] = userID;
    data['setAsDefault'] = setAsDefault;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
