import 'dart:convert';
import 'package:sal_patient_client/models/practitioner.dart';

class HttpClient {
  HttpClient._internal();

  static final HttpClient _instance = HttpClient._internal();

  factory HttpClient() => _instance;

  static HttpClient get shared => _instance;

  Future<List<Practitioner>> getPractitioners() async {
    return Practitioner.fromJsonArray(jsonEncode(this.mockedJson()));
  }

  Map<String, dynamic> mockedJson() {
    return {
      "practitioners": [
        {
          "id": "1",
          "name": "Dr. Snehal Mehta",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "speciality": ["Parenting, Stress"],
          "languages": ["English", "Hindi"],
          "about":
              "Snehal has been a therapist for many years and believes in helping people wholeheartedly. She wants to provide her services to from all over the country and not just her city. She loves to help people.",
          "rating": 5.0
        },
        {
          "id": "2",
          "name": "Dr. Ankur Jain",
          "experience": "7 years experience",
          "fee": 100,
          "type": 1,
          "speciality": ["Lfe Coaching', Stress"],
          "languages": ["English"],
          "about":
              "Ankur has been a therapist for many years and believes in helping people wholeheartedly. He wants to provide her services to from all over the country and not just her city. He loves to help people.",
          "rating": 2.7
        },
        {
          "id": "3",
          "name": "Dr. Simma Singh",
          "experience": "5 years experience",
          "fee": 50,
          "type": 1,
          "speciality": ["Depression', Stress"],
          "languages": ["English"],
          "about":
              "Simma has been a therapist for many years and believes in helping people wholeheartedly. She wants to provide her services to from all over the country and not just her city. She loves to help people.",
          "rating": 4.5
        },
        {
          "id": "4",
          "name": "Dr. Snehal Mehta 1",
          "experience": "7 years experience",
          "fee": 20,
          "type": 1,
          "speciality": ["Depression', Stress"],
          "languages": ["English"],
          "about":
              "Snehal has been a therapist for many years and believes in helping people wholeheartedly. She wants to provide her services to from all over the country and not just her city. She loves to help people.",
          "rating": 5.0
        },
        {
          "id": "5",
          "name": "Dr. Ankur Jain 1",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "speciality": ["Depression', Stress"],
          "languages": ["English', Hindi"],
          "about":
              "Ankur has been a therapist for many years and believes in helping people wholeheartedly. He wants to provide her services to from all over the country and not just her city. He loves to help people.",
          "rating": 2.7
        },
        {
          "id": "6",
          "name": "Dr. Simma Singh 1",
          "experience": "5 years experience",
          "fee": 500,
          "type": 1,
          "speciality": ["Depression', Stress"],
          "languages": ["English', Hindi"],
          "about":
              "Simma has been a therapist for many years and believes in helping people wholeheartedly. She wants to provide her services to from all over the country and not just her city. She loves to help people.",
          "rating": 4.5
        },
        {
          "id": "7",
          "name": "Dr. Snehal Mehta 2",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "speciality": ["Depression', Stress"],
          "languages": ["English', Hindi"],
          "about":
              "Snehal has been a therapist for many years and believes in helping people wholeheartedly. She wants to provide her services to from all over the country and not just her city. She loves to help people.",
          "rating": 5.0
        },
        {
          "id": "8",
          "name": "Dr. Ankur Jain 2",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "speciality": ["Depression', Stress"],
          "languages": ["English', Hindi"],
          "about":
              "Ankur has been a therapist for many years and believes in helping people wholeheartedly. He wants to provide her services to from all over the country and not just her city. He loves to help people.",
          "rating": 2.7
        },
        {
          "id": "9",
          "name": "Dr. Simma Singh 2",
          "experience": "5 years experience",
          "fee": 500,
          "type": 1,
          "speciality": ["Depression', Stress"],
          "languages": ["English', Hindi"],
          "about":
              "Simma has been a therapist for many years and believes in helping people wholeheartedly. She wants to provide her services to from all over the country and not just her city. She loves to help people.",
          "rating": 4.5
        }
      ]
    };
  }
}
