import 'dart:convert';

List<GroupModel> groupModelFromJson(String str) => List<GroupModel>.from(json.decode(str).map((x) => GroupModel.fromJson(x)));
String groupModelToJson(List<GroupModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupModel {
  GroupModel({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
