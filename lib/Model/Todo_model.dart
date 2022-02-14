// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

List<TodoModel> todoModelFromJson(String str) => List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
  TodoModel({
    this.id,
    this.uid,
    this.title,
    this.description,
    this.priority,
    this.dateTime,
    this.status,
  });

  String id;
  String uid;
  String title;
  String description;
  String priority;
  DateTime dateTime;
  String status;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json["id"],
    uid: json["uid"],
    title: json["title"],
    description: json["description"],
    priority: json["priority"],
    dateTime: DateTime.parse(json["date_time"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "title": title,
    "description": description,
    "priority": priority,
    "date_time": dateTime.toIso8601String(),
    "status": status,
  };
}
