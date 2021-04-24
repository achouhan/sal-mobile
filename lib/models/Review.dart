// Review class
import 'dart:convert';

import 'package:intl/intl.dart';

class Review {
  final String id;
  final String reviewer;
  final String timeStamp;
  final String text;
  final double rating;

  Review(
    this.id,
    this.reviewer,
    this.timeStamp,
    this.text,
    this.rating,
  );

  static Review fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Review(data['id'], data['reviewer'],
        formatedTimeStamp(data['timestamp']), data['text'], data['rating']);
  }

  // Return list of practioner
  static List<Review> fromJsonArray(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString)['reviews'];

    return data
        .map<Review>((dynamic value) => Review(
            value['id'],
            value['reviewer'],
            formatedTimeStamp(value['timestamp']),
            value['text'],
            value['rating']))
        .toList();
  }

  static String formatedTimeStamp(String timestamp) {
    DateTime _datetime = DateTime.parse(timestamp);
    String _formatedTimeStamp = new DateFormat('DD MMM yy').format(_datetime);
    return _formatedTimeStamp;
  }
}
