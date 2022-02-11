import 'dart:convert';

List<TextFeedbackModel> textFeedbackModelFromJson(String str) => List<TextFeedbackModel>.from(json.decode(str).map((x) => TextFeedbackModel.fromJson(x)));

String textFeedbackModelToJson(List<TextFeedbackModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TextFeedbackModel {
  TextFeedbackModel({
    this.id,
    this.title,
    this.username,
    this.retailerId,
    this.feedbackDetail,
  });

  String id;
  String title;
  String username;
  String retailerId;
  String feedbackDetail;

  factory TextFeedbackModel.fromJson(Map<String, dynamic> json) => TextFeedbackModel(
    id: json["id"],
    title: json["title"],
    username: json["username"],
    retailerId: json["retailer_id"],
    feedbackDetail: json["feedback_detail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "username": username,
    "retailer_id": retailerId,
    "feedback_detail": feedbackDetail,
  };
}
