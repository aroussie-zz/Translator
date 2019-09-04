class Translation {
  int id;
  String originalSentence;
  String translatedSentence;
  String originalLanguage;
  String translationLanguage;
  String type;

  Translation(
      {this.id,
      this.originalSentence,
      this.translatedSentence,
      this.originalLanguage,
      this.translationLanguage,
      this.type});

  Translation.forDatabase(
      {this.originalSentence,
      this.translatedSentence,
      this.type});

  Translation.dummy(int randomNumber) {
    this.id = randomNumber;
    this.originalSentence = "Je suis l'originale $randomNumber";
    this.translatedSentence = "I'm the original";
    this.originalLanguage = "French";
    this.translationLanguage = "English";
    this.type = "French -> English";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': null,
      'originalSentence': originalSentence,
      'translatedSentence': translatedSentence,
      'type': type
    };
  }
}
