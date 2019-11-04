class Verb{

  int id;
  String original_title;
  String original_firstPerson;
  String original_secondPerson;
  String original_thirdPerson;
  String original_fourthPerson;
  String original_fifthPerson;
  String original_sixthPerson;

  String translated_title;
  String translated_firstPerson;
  String translated_secondPerson;
  String translated_thirdPerson;
  String translated_fourthPerson;
  String translated_fifthPerson;
  String translated_sixthPerson;

  Verb({this.id, this.original_title, this.original_firstPerson, this.original_secondPerson, this.original_thirdPerson,
      this.original_fourthPerson, this.original_fifthPerson, this.original_sixthPerson,
    this.translated_title, this.translated_firstPerson, this.translated_secondPerson, this.translated_thirdPerson,
    this.translated_fourthPerson, this.translated_fifthPerson, this.translated_sixthPerson});

  Verb.dummy(int randomNumber){
    this.id = randomNumber;
    original_title = "BE";
    original_firstPerson = "I am";
    original_secondPerson = "You are";
    original_thirdPerson = "He/She is";
    original_fourthPerson = "We are";
    original_fifthPerson = "You are";
    original_sixthPerson = "They are";

    translated_title = "ÊTRE";
    translated_firstPerson = "Je suis";
    translated_secondPerson = "Tu es";
    translated_thirdPerson = "Il/Elle/On est";
    translated_fourthPerson = "Nous sommes";
    translated_fifthPerson = "Vous êtes";
    translated_sixthPerson = "Ils/Elles sont";
  }

  Verb.forDatabase({
    this.original_title, this.original_firstPerson, this.original_secondPerson, this.original_thirdPerson,
    this.original_fourthPerson, this.original_fifthPerson, this.original_sixthPerson,
    this.translated_title, this.translated_firstPerson, this.translated_secondPerson, this.translated_thirdPerson,
    this.translated_fourthPerson, this.translated_fifthPerson, this.translated_sixthPerson});


  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
      print("ID WAS NOT NULL BUT WAS $id");
    }

    map['originalTitle'] = original_title;
    map['originalFirstPerson'] = original_firstPerson;
    map['originalSecondPerson'] = original_secondPerson;
    map['originalThirdPerson'] = original_thirdPerson;
    map['originalFourthPerson'] = original_fourthPerson;
    map['originalFifthPerson'] = translated_fifthPerson;
    map['originalSixthPerson'] = translated_sixthPerson;
    map['translatedTitle'] = translated_title;
    map['translatedFirstPerson'] = translated_firstPerson;
    map['translatedSecondPerson'] = translated_secondPerson;
    map['translatedThirdPerson'] = translated_thirdPerson;
    map['translatedFourthPerson'] = translated_fourthPerson;
    map['translatedFifthPerson'] = translated_firstPerson;
    map['translatedSixthPerson'] = translated_sixthPerson;

    return map;
  }


}