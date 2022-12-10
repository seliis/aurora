enum AuroraDataTypes {
  event,
  notice,
  request,
  zone,
}

class AuroraData {
  AuroraData(
    this.dataFrom,
    this.dataType,
    this.dataBody,
  );

  final String dataFrom;
  final String dataType;
  final Map<String, dynamic> dataBody;

  static AuroraData fromJson(Map<String, dynamic> jsonData) {
    return AuroraData(
      jsonData["dataFrom"],
      jsonData["dataType"],
      jsonData["dataBody"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dataFrom": dataFrom,
      "dataType": dataType,
      "dataBody": dataBody,
    };
  }
}

class AuroraNoticeData {
  AuroraNoticeData(
    this.content,
  );

  final String content;

  static AuroraNoticeData fromJson(Map<String, dynamic> jsonData) {
    return AuroraNoticeData(
      jsonData["content"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "content": content,
    };
  }
}

class AuroraZoneData {
  AuroraZoneData(
    this.name,
    this.radius,
    this.latitude,
    this.longitude,
  );

  final String name;
  final double radius;
  final double latitude;
  final double longitude;

  static AuroraZoneData fromJson(Map<String, dynamic> jsonData) {
    return AuroraZoneData(
      jsonData["name"],
      double.parse(jsonData["radius"].toString()), // Would double or int be better?
      jsonData["latitude"],
      jsonData["longitude"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "radius": radius,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
