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
    this.date,
    this.time,
    this.status,
  });

  String id;
  String uid;
  String title;
  String description;
  String priority;
  DateTime date;
  String time;
  String status;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json["id"],
    uid: json["uid"],
    title: json["title"],
    description: json["description"],
    priority: json["priority"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "title": title,
    "description": description,
    "priority": priority,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "status": status,
  };
}
