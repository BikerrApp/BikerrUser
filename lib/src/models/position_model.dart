class PositionModel extends Object {
  int? id;
  int? deviceId;
  String? type;
  String? protocol;
  String? serverTime;
  String? deviceTime;
  String? fixTime;
  bool? outdated;
  bool? valid;
  double? latitude;
  double? longitude;
  double? altitude;
  double? speed;
  double? course;
  String? address;
  double? accuracy;
  bool? blocked;
  Map<String, dynamic>? attributes;

  PositionModel({
     this.id,
     this.deviceId,
     this.type,
     this.protocol,
     this.serverTime,
     this.deviceTime,
     this.fixTime,
     this.outdated,
     this.valid,
     this.latitude,
     this.longitude,
     this.altitude,
     this.speed,
     this.course,
     this.address,
     this.accuracy,
     this.blocked,
     this.attributes,
  });

  PositionModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    deviceId = json["deviceId"];
    type = json["type"];
    protocol = json["protocol"];
    serverTime = json["serverTime"];
    deviceTime = json["deviceTime"];
    fixTime = json["fixTime"];
    outdated = json["outdated"];
    valid = json["valid"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    altitude = json["altitude"];
    speed = json["speed"];
    course = json["course"];
    address = json["address"];
    accuracy = json["accuracy"];
    attributes = json["attributes"];
    blocked = json["blocked"];
  }
}
