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


List<ImageFeedbackModel> imageFeedbackModelFromJson(String str) => List<ImageFeedbackModel>.from(json.decode(str).map((x) => ImageFeedbackModel.fromJson(x)));

String imageFeedbackModelToJson(List<ImageFeedbackModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageFeedbackModel {
  ImageFeedbackModel({
    this.id,
    this.username,
    this.retailerId,
    this.imageUrl,
  });

  String id;
  String username;
  String retailerId;
  List<String> imageUrl;

  factory ImageFeedbackModel.fromJson(Map<String, dynamic> json) => ImageFeedbackModel(
    id: json["id"],
    username: json["username"],
    retailerId: json["retailer_id"],
    imageUrl: List<String>.from(json["image_url"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "retailer_id": retailerId,
    "image_url": List<dynamic>.from(imageUrl.map((x) => x)),
  };
}
