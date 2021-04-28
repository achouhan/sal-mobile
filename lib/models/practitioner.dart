import 'review.dart';

// Type enum representing the practitioner type.
enum PractitionerType { none, counsellor, listener, therapist }

// Practitioner class
class Practitioner {
  final String id;
  final String firstName;
  final String lastName;
  final PractitionerType type;
  final String education;
  final String experience;
  final String about;
  final int price;
  final double averageRating;
  final int totalRating;
  final String photoUrl;

  List<Review> reviews;
  List<String> topics;
  List<dynamic> speciality;
  List<String> languages;

  Practitioner(
      {this.id,
      this.firstName,
      this.lastName,
      this.type,
      this.experience,
      this.about,
      this.price,
      this.averageRating,
      this.totalRating,
      this.education,
      this.photoUrl});

  String get name => this.firstName + ' ' + this.lastName;

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

  // Return list of practitioner
  static List<Practitioner> fromJson(Map<String, dynamic> json) {
    final String mediaUrl = json['media_url'];
    final Iterable<dynamic> data = json['counsellors'];

    return data
        .map<Practitioner>((dynamic value) => Practitioner(
            id: value['id'],
            firstName: value['first_name'],
            lastName: value['last_name'],
            type: PractitionerType.values[int.parse(value['type'])],
            experience: value['experience'],
            about: value['about'],
            price: int.parse(value['price']),
            photoUrl: mediaUrl + value['photo'],
            education: value['education'],
            averageRating: double.parse(value['average_rating']),
            totalRating: int.parse(value['total_rating'])))
        .toList();
  }

  void updateDetails(Map<String, dynamic> json) {
    List<dynamic> _languages = json['languages'];
    this.languages = _languages.map((value) => value['language'].toString()).toList();

    this.reviews = Review.fromJsonArray(json['reviews']);
    List<dynamic> _topics = json['topics'];
    this.topics = _topics.map((value) => value['topic'].toString()).toList();
  }
}
