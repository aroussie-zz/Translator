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

//  Verb.forDatabase({this.id
//    this.original_title, this.original_firstPerson, this.original_secondPerson, this.original_thirdPerson,
//    this.original_fourthPerson, this.original_fifthPerson, this.original_sixthPerson,
//    this.translated_title, this.translated_firstPerson, this.translated_secondPerson, this.translated_thirdPerson,
//    this.translated_fourthPerson, this.translated_fifthPerson, this.translated_sixthPerson});

  Verb.fromDatabase({Map<String, dynamic> json}) {
    this.id = json['id'];
    this.original_title = json['originalTitle'];
    this.original_firstPerson = json['originalFirstPerson'];
    this.original_secondPerson = json['originalSecondPerson'];
    this.original_thirdPerson = json['originalThirdPerson'];
    this.original_fourthPerson = json['originalFourthPerson'];
    this.original_fifthPerson = json['originalFifthPerson'];
    this.original_sixthPerson = json['originalSixthPerson'];

    this.translated_title = json['translatedTitle'];
    this.translated_firstPerson = json['translatedFirstPerson'];
    this.translated_secondPerson = json['translatedSecondPerson'];
    this.translated_thirdPerson = json['translatedThirdPerson'];
    this.translated_fourthPerson = json['translatedFourthPerson'];
    this.translated_fifthPerson = json['translatedFifthPerson'];
    this.translated_sixthPerson = json['translatedSixthPerson'];

  }


  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }

    map['originalTitle'] = original_title;
    map['originalFirstPerson'] = original_firstPerson;
    map['originalSecondPerson'] = original_secondPerson;
    map['originalThirdPerson'] = original_thirdPerson;
    map['originalFourthPerson'] = original_fourthPerson;
    map['originalFifthPerson'] = original_fifthPerson;
    map['originalSixthPerson'] = original_sixthPerson;
    map['translatedTitle'] = translated_title;
    map['translatedFirstPerson'] = translated_firstPerson;
    map['translatedSecondPerson'] = translated_secondPerson;
    map['translatedThirdPerson'] = translated_thirdPerson;
    map['translatedFourthPerson'] = translated_fourthPerson;
    map['translatedFifthPerson'] = translated_fifthPerson;
    map['translatedSixthPerson'] = translated_sixthPerson;

    return map;
  }

}