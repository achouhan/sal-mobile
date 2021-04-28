import 'package:sal_patient_client/models/practitioner.dart';
import 'package:sal_patient_client/network/metadata_repository.dart';
import 'package:sal_patient_client/utils/utils.dart';
import 'package:sal_patient_client/models/Metadata.dart';
import 'package:flutter/material.dart';

class FiltersProvider extends ChangeNotifier {
  final filters = Map<String, dynamic>();
  final types = Set<PractitionerType>();

  RangeValues priceRange = RangeValues(0, 0);

  // List of topics
  List<String> _topics;

  // List of supported languages
  List<String> _languages;

  // Metadata
  Metadata _metadata;

  // List of all practitioners
  static final _practitionerTypes = [
    PractitionerType.counsellor,
    PractitionerType.listener,
  ];

  Future<void> loadMetadata(MetadataRepository metadataRepository) async {
    this._metadata = await metadataRepository.getMetadata();
    // Populate topics
    this._topics = this._metadata.topics.map((value) => value.label).toList();
    // Populate languages
    this._languages =
        this._metadata.languages.map((value) => value.label).toList();
  }

  dynamic filter(String key) => this.filters[key];

  void _addfilter(String key, dynamic value) => this.filters[key] = value;

  void delete(String filterValue) {
    PractitionerType matchedType;

    /// NOTE: Need to revisit filter logic again
    if (filterValue == this.displayPriceRange()) {
      this.priceRange = RangeValues(0, 0);
    }

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

  void deleteAll() {
    this.filters.clear();
    this.types.clear();

    notifyListeners();
  }

  void refresh() {
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

    String priceRange = this.displayPriceRange();
    if (priceRange != '0-0') {
      displayLabels.add(priceRange);
    }

    return displayLabels;
  }

  // Returns selected language
  String getLanguage() => this.filters['language'];

  void setLanguage(String language) => this._addfilter('language', language);

  // Returns selected topic
  String getTopic() => this.filters['topic'];

  // Set topic
  void setTopic(String topic) => this._addfilter('topic', topic);

  // Set practitioner types
  void setType(PractitionerType type) {
    if (this.types.contains(type)) {
      this.types.remove(type);
    } else {
      this.types.add(type);
    }
  }

  Map<String, dynamic> getQueryFilters() {
    var _queryFilters = Map<String, dynamic>();
    if (this.types.length == 1) {
      _queryFilters["type"] = this.types.first.index.toString();
    }

    for (var key in this.filters.keys) {
      if (key == 'language') {
        for (var language in this._metadata.languages) {
          if (language.label == this.filters[key]) {
            _queryFilters[key] = language.id.toString();
            break;
          }
        }
      } else if (key == 'topic') {
        for (var topic in this._metadata.topics) {
          if (topic.label == this.filters[key]) {
            _queryFilters[key] = topic.id.toString();
            break;
          }
        }
      } else {
        _queryFilters[key] = this.filters[key];
      }
    }

    if (this.priceRange.end > 0) {
      _queryFilters['price'] = this.priceRange.start.ceil().toString() +
          ',' +
          this.priceRange.end.ceil().toString();
    }

    return _queryFilters;
  }

  String displayPriceRange() {
    return this.priceRange.start.ceil().toString() +
        '-' +
        this.priceRange.end.ceil().toString();
  }

  // All supported topics
  List<String> getAllTopics() => _topics;

  // All languages
  List<String> getAllLanguages() => _languages;

  // All practitioners
  static List<PractitionerType> getAllPractitioners() => _practitionerTypes;
}
