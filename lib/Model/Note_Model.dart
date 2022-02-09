// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

List<NoteModel> noteModelFromJson(String str) => List<NoteModel>.from(json.decode(str).map((x) => NoteModel.fromJson(x)));

String noteModelToJson(List<NoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteModel {
  NoteModel({
    this.id,
    this.uid,
    this.title,
    this.note,
    this.colorCode,
    this.imageUrl,
  });

  String id;
  String uid;
  String title;
  String note;
  String colorCode;
  List<String> imageUrl;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json["id"],
    uid: json["uid"],
    title: json["title"],
    note: json["note"],
    colorCode: json["color_code"],
    imageUrl: List<String>.from(json["image_url"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "title": title,
    "note": note,
    "color_code": colorCode,
    "image_url": List<dynamic>.from(imageUrl.map((x) => x)),
  };
}
