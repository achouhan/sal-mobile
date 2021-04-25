import 'dart:convert';

import 'review.dart';

// Type enum representing the practitioner type.
enum PractitionerType { none, counsellor, therapist, listener }

// Practitioner class
class Practitioner {
  final String id;
  final String name;
  final PractitionerType type;
  final String experience;
  final String aboutMe;
  final int fee;
  final double rating;
  final List<dynamic> speciality;
  final List<dynamic> languages;

  Practitioner(this.id, this.name, this.type, this.experience, this.aboutMe,
      this.fee, this.rating, this.speciality, this.languages);

  String typeToString() {
    String value;
    switch (this.type) {
      case PractitionerType.none:
        value = "Unknown";
        break;
      case PractitionerType.counsellor:
        value = "Counsellor";
        break;
      case PractitionerType.therapist:
        value = "Threapist";
        break;
      case PractitionerType.listener:
        value = "Listener";
        break;
    }
    return value;
  }

  static Practitioner fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Practitioner(
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

  // Return list of practitioner
  static List<Practitioner> fromJsonArray(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString)['practitioners'];

    return data
        .map<Practitioner>((dynamic value) => Practitioner(
            value['id'],
            value['name'],
            PractitionerType.values[value['type']],
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
