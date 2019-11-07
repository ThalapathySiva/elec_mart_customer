import 'dart:convert';

import 'package:elec_mart_customer/models/UserModel.dart';

class ReviewsModel {
  final String name;
  final String text;
  final double rating;
  final bool canReview;
  final List images;
  final double averageRating;
  final UserModel user;

  ReviewsModel({
    this.averageRating,
    this.user,
    this.canReview,
    this.text,
    this.name,
    this.images,
    this.rating,
  });

  factory ReviewsModel.fromJson(Map<dynamic, dynamic> json) {
    return ReviewsModel(
        name: json['name'],
        text: json['text'],
        images: json['images'] != null ? jsonDecode(json['images']) : [],
        canReview: json['canReview'],
        rating: json['rating'] != null
            ? double.parse(json['rating'].toString())
            : null,
        averageRating: json['averageRating'] != null
            ? double.parse(json['averageRating'].toString())
            : null,
        user: json["customer"] != null
            ? UserModel.fromJson(json['customer'])
            : UserModel());
  }
}
