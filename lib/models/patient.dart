class Patient {
  String? name;
  String? age;
  String? CDH1;
  String? PTEN;
  String? TP53;
  String? ATM;
  String? ATM_1;
  String? ATM_2;
  String? NBN;
  String? NBN_1;
  String? NBN_2;
  String? AKT1;
  String? BRCA1;
  String? BRCA2;
  String? BRCA2_1;
  String? BRCA2_2;
  String? BRCA2_3;
  double? predictionScore;

  Patient({
    this.name,
    this.age,
    this.CDH1,
    this.PTEN,
    this.TP53,
    this.ATM,
    this.ATM_1,
    this.ATM_2,
    this.NBN,
    this.NBN_1,
    this.NBN_2,
    this.AKT1,
    this.BRCA1,
    this.BRCA2,
    this.BRCA2_1,
    this.BRCA2_2,
    this.BRCA2_3,
    this.predictionScore
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age':age,
      'CDH1': CDH1,
      'PTEN': PTEN,
      'TP53':TP53,
      'ATM': ATM,
      'ATM_1': ATM_1,
      'ATM_2':ATM_2,
      'NBN': NBN,
      'NBN_1': NBN_1,
      'NBN_2': NBN_2,
      'AKT1': AKT1,
      'BRCA1':BRCA1,
      'BRCA2': BRCA2,
      'BRCA2_1':BRCA2_1,
      'BRCA2_2':BRCA2_2,
      'BRCA2_3':BRCA2_3,
      'prediction':predictionScore,
    };
  }

  Patient fromJson(Map<String, dynamic> user) {
    return Patient(
      name: user['name'],
      age: user['age'],
      CDH1: user['CDH1'],
      PTEN: user['PTEN'],
      TP53: user['TP53'],
      ATM: user['ATM'],
      ATM_1: user['ATM_1'],
      ATM_2: user['ATM_2'],
      NBN: user['NBN'],
      NBN_1: user['NBN_1'],
      NBN_2: user['NBN_2'],
      AKT1: user['AKT1'],
      BRCA1: user['BRCA1'],
      BRCA2: user['BRCA2'],
      BRCA2_1: user['BRCA2_1'],
      BRCA2_2: user['BRCA2_2'],
      BRCA2_3: user['BRCA2_3'],
      predictionScore: user['prediction'],
    );
  }
}
