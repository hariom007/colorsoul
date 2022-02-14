// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) => List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
  TaskModel({
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

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
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
