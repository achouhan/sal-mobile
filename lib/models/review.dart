// Review class
import 'dart:convert';

class Review {
  final String comment;
  final String firstName;
  final String lastName;
  final String modifiedAt;
  final String rating;

  String get name => this.firstName + ' ' + this.lastName;

  Review(this.comment, this.firstName, this.lastName, this.modifiedAt,
      this.rating);

  static Review fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Review(data['comment'], data['first_name'], data['last_name'],
        data['modified_at'], data['rating']);
  }

  // Return list of practitioner
  static List<Review> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        .map<Review>((dynamic value) => Review(
            value['comment'],
            value['first_name'],
            value['last_name'],
            value['modified_at'],
            value['rating']))
        .toList();
  }
}
