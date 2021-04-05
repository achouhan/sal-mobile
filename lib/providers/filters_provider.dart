import 'package:sal_patient_client/models/practioner.dart';
import 'package:sal_patient_client/utils/utils.dart';
import 'package:flutter/material.dart';

class FiltersProvider extends ChangeNotifier {
  final filters = Map<String, dynamic>();
  final types = Set<PractionerType>();

  // List of possible topics(Hard coded for now)
  static final _topics = [
    'Anxiety Management',
    'Stress - Work / Personal Relationship',
    'Depression',
    'Anger Management',
    'Parenting',
    'Teenage Tantrums',
    'Grief / Trauma',
    'Self-Improvement / Motivation',
    'Life Coaching',
    'Others'
  ];

  // List of supported languages
  static final _languages = [
    'English',
    'Hindi',
  ];

  // List of all practioners
  static final _practionerTypes = [
    PractionerType.counsellor,
    PractionerType.listener,
  ];

  dynamic filter(String key) => this.filters[key];

  void _addfilter(String key, dynamic value) => this.filters[key] = value;

  void delete(String filterValue) {
    PractionerType matchedType;

    // Check type first
    for (var type in this.types) {
      if (Utils.describeEnum(type.toString()) == filterValue) {
        matchedType = type;
        break;
      }
    }

    if (matchedType != null) {
      this.types.remove(matchedType);
    } else {
      String matchedKey;
      for (var key in this.filters.keys) {
        if (this.filters[key] == filterValue) {
          matchedKey = key;
          break;
        }
      }
      // Delete value
      if (matchedKey != null) {
        this.filters.remove(matchedKey);
      }
    }
    notifyListeners();
  }

  // Returns count of filters
  int count() => this.filters.length;

  // Returns display labels for all filter
  List<String> allFilterDisplayLabels() {
    List<String> displayLabels = [];

    // Add types first
    this.types.forEach((element) {
      displayLabels.add(Utils.describeEnum(element.toString()));
    });

    // Add rest of the filters
    this.filters.values.forEach((element) {
      displayLabels.add(element as String);
    });

    return displayLabels;
  }

  // Returns selected language
  String getLanguage() => this.filters['language'];

  void setLanguage(String language) => this._addfilter('language', language);

  // Returns selected topic
  String getTopic() => this.filters['topic'];

  // Set topic
  void setTopic(String topic) => this._addfilter('topic', topic);

  // Set practioner types
  void setType(PractionerType type) {
    if (this.types.contains(type)) {
      this.types.remove(type);
    } else {
      this.types.add(type);
    }
  }

  // All supported topics
  static List<String> getAllTopics() => _topics;

  // All languages
  static List<String> getAllLanguages() => _languages;

  // All practioners
  static List<PractionerType> getAllPractioners() => _practionerTypes;
}
