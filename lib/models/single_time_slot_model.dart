class SingleTimeSlotModel {
  String? sId;
  String? day;
  String? startTime;
  String? endTime;
  int? iV;

  SingleTimeSlotModel(
      {this.sId, this.day, this.startTime, this.endTime, this.iV});

  SingleTimeSlotModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    day = json['day'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['day'] = day;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['__v'] = iV;
    return data;
  }
}
