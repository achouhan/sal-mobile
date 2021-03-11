import 'dart:convert';
import 'package:SAL_App/UI/Models/Practioner.dart';

class HttpClient {
  HttpClient._internal();

  static final HttpClient _instance = HttpClient._internal();

  factory HttpClient() => _instance;

  static HttpClient get shared => _instance;

  Future<List<Practioner>> getPractioners() async {
    return Practioner.fromJsonArray(jsonEncode(this.mockedJson()));
  }

  Map<String, dynamic> mockedJson() {
    return {
      "practioners": [
        {
          "id": "1",
          "name": "Dr. Snehal Mehta",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "rating": 5.0
        },
        {
          "id": "2",
          "name": "Dr. Ankur Jain",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "rating": 2.7
        },
        {
          "id": "3",
          "name": "Dr. Simma Singh",
          "experience": "5 years experience",
          "fee": 500,
          "type": 1,
          "rating": 4.5
        },
        {
          "id": "4",
          "name": "Dr. Snehal Mehta 1",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "rating": 5.0
        },
        {
          "id": "5",
          "name": "Dr. Ankur Jain 1",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "rating": 2.7
        },
        {
          "id": "6",
          "name": "Dr. Simma Singh 1",
          "experience": "5 years experience",
          "fee": 500,
          "type": 1,
          "rating": 4.5
        },
         {
          "id": "7",
          "name": "Dr. Snehal Mehta 2",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "rating": 5.0
        },
        {
          "id": "8",
          "name": "Dr. Ankur Jain 2",
          "experience": "7 years experience",
          "fee": 500,
          "type": 1,
          "rating": 2.7
        },
        {
          "id": "9",
          "name": "Dr. Simma Singh 2",
          "experience": "5 years experience",
          "fee": 500,
          "type": 1,
          "rating": 4.5
        }
      ]
    };
  }
}
