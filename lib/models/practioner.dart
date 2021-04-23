import 'dart:convert';

import 'Review.dart';

// Type enum representing the practioner type.
enum PractionerType { none, counsellor, therapist, listener }

// Practioner class
class Practioner {
  final String id;
  final String name;
  final PractionerType type;
  final String experience;
  final String aboutMe;
  final int fee;
  final double rating;
  final List<dynamic> speciality;
  final List<dynamic> languages;

  Practioner(this.id, this.name, this.type, this.experience, this.aboutMe,
      this.fee, this.rating, this.speciality, this.languages);

  String typeToString() {
    String value;
    switch (this.type) {
      case PractionerType.none:
        value = "Unknown";
        break;
      case PractionerType.counsellor:
        value = "Counsellor";
        break;
      case PractionerType.therapist:
        value = "Threapist";
        break;
      case PractionerType.listener:
        value = "Listener";
        break;
    }
    return value;
  }

  static Practioner fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Practioner(
        data['id'],
        data['name'],
        data['type'],
        data['experience'],
        data['about'],
        data['fee'],
        data['rating'],
        data['speciality'],
        data['languages']);
  }

  // Return list of practioner
  static List<Practioner> fromJsonArray(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString)['practioners'];

    return data
        .map<Practioner>((dynamic value) => Practioner(
            value['id'],
            value['name'],
            PractionerType.values[value['type']],
            value['experience'],
            value['about'],
            value['fee'],
            value['rating'],
            value['speciality'],
            value['languages']))
        .toList();
  }

  List<Review> reviews() {
    return Review.fromJsonArray(jsonEncode(this.reviewsJson()));
  }

  Map<String, dynamic> reviewsJson() {
    return {
      "reviews": [
        {
          "id": "1",
          "reviewer": "Ankita Rathi",
          "timestamp": "2020-07-20",
          "text":
              "Dr Sushmita is an extremely great counsellor who was highly patient and understanding. I would be definitely be booking a session again",
          "rating": 5.0
        },
        {
          "id": "2",
          "reviewer": "Ankita Rathi",
          "timestamp": "2020-07-20",
          "text":
              "Dr Sushmita is an extremely great counsellor who was highly patient and understanding. I would be definitely be booking a session again",
          "rating": 2.7
        }
      ]
    };
  }
}
