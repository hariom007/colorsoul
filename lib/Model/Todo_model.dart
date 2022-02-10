
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

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
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
