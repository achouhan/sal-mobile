// Topics metadata class
class Topic {
  final String id;
  final String label;

  Topic(this.id, this.label);

  static Topic fromJson(Map<String, dynamic> parsedJson) {
    return Topic(parsedJson['id'], parsedJson['topic']);
  }
}

// Language metadata class
class Language {
  final String id;
  final String label;

  Language(this.id, this.label);

  static Language fromJson(Map<String, dynamic> parsedJson) {
    return Language(parsedJson['id'], parsedJson['language']);
  }
}

class Metadata {
  final List<Language> languages;
  final List<Topic> topics;

  Metadata(this.languages, this.topics);

  static Metadata fromJson(Map<String, dynamic> json) {
    List<Language> languages =
        (json['languages'] as List).map((i) => Language.fromJson(i)).toList();
    List<Topic> topics =
        (json['topics'] as List).map((i) => Topic.fromJson(i)).toList();
    return Metadata(languages, topics);
  }
}
