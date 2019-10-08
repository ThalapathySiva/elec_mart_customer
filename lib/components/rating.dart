import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingStar extends StatefulWidget {
  final Function onratingChanged;
  final double size, rating;
  final Color color, borderColor;

  RatingStar(
      {this.borderColor,
      this.color,
      this.rating = 0,
      this.onratingChanged,
      this.size});
  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
        allowHalfRating: false,
        onRatingChanged: widget.onratingChanged,
        starCount: 5,
        rating: widget.rating,
        size: widget.size,
        color: widget.color,
        borderColor: widget.borderColor,
        spacing: 0.0);
  }
}
