class Translation {

  String originalSentence;
  String translatedSentence;
  String originalLanguage;
  String translationLanguage;

  Translation({this.originalSentence, this.translatedSentence,
      this.originalLanguage, this.translationLanguage});

  Translation.dummy(int randomNumber){
    this.originalSentence = "Je suis l'originale $randomNumber";
    this.translatedSentence = "I'm the original";
    this.originalLanguage = "French";
    this.translationLanguage = "English";
  }


}