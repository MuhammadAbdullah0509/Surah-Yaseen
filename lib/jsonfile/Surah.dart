class Surah {
  Surah({
    required this.id,
    required this.indonesian,
    required this.turkish,
    required this.totalVerses,
    required this.verses,
    required this.translation,
    required this.urdu,
    required this.type,
    required this.english,
    required this.transliteration,
    required this.french,
    required this.name,
  });

  late final int id;
  late final String indonesian;
  late final String turkish;
  late final int totalVerses;
  late final List<Verses> verses;
  late final String translation;
  late final String urdu;
  late final String type;
  late final String english;
  late final String transliteration;
  late final String french;
  late final String name;

  Surah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indonesian = json['indonesian'];
    turkish = json['turkish'];
    totalVerses = json['total_verses'];
    verses = List.from(json['verses'])
        .map((verses) => Verses.fromJson(verses))
        .toList();
    translation = json['translation'];
    urdu = json['urdu'];
    type = json['type'];
    english = json['english'];
    transliteration = json['transliteration'];
    french = json['french'];
    name = json['name'];
  }

  toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['indonesian'] = indonesian;
    _data['turkish'] = turkish;
    _data['total_verses'] = totalVerses;
    _data['verses'] = verses.map((e) => e.toJson()).toList();
    _data['translation'] = translation;
    _data['urdu'] = urdu;
    _data['type'] = type;
    _data['english'] = english;
    _data['transliteration'] = transliteration;
    _data['french'] = french;
    _data['name'] = name;
    return _data;
  }
}

class Verses {
  Verses({
    required this.french,
    required this.urdu,
    required this.indonesian,
    required this.id,
    required this.english,
    required this.text,
    required this.turkish,
    required this.translation,
  });

  late final String french;
  late final String urdu;
  late final String indonesian;
  late final int id;
  late final String english;
  late final String? text;
  late final String turkish;
  late final String translation;

  Verses.fromJson(Map<String, dynamic> json) {
    french = json['french'];
    urdu = json['urdu'];
    indonesian = json['indonesian'];
    id = json['id'];
    english = json['english'];
    text = json['text'];
    turkish = json['turkish'];
    translation = json['translation'];
  }

  toJson() {
    final data = {};
    data['french'] = french;
    data['urdu'] = urdu;
    data['indonesian'] = indonesian;
    data['id'] = id;
    data['english'] = english;
    data['text'] = text;
    data['turkish'] = turkish;
    data['translation'] = translation;
    return data;
  }
}
