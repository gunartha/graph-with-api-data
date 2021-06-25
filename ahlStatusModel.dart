// To parse this JSON data, do
//
//     final ahlStatusModel = ahlStatusModelFromJson(jsonString);

import 'dart:convert';

AhlStatusModel ahlStatusModelFromJson(String str) =>
    AhlStatusModel.fromJson(json.decode(str));

String ahlStatusModelToJson(AhlStatusModel data) => json.encode(data.toJson());

class AhlStatusModel {
  AhlStatusModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory AhlStatusModel.fromJson(Map<String, dynamic> json) => AhlStatusModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.ahlStatus,
    this.jml,
  });

  String ahlStatus;
  String jml;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        ahlStatus: json["ahl_status"],
        jml: json["jml"],
      );

  Map<String, dynamic> toJson() => {
        "ahl_status": ahlStatus,
        "jml": jml,
      };
}
