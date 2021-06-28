import 'package:cancer_spy/firebase/user_helper.dart';
import 'package:cancer_spy/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientHelper {
  static const COLLECTION_NAME = 'Patient';

  final _firestore = FirebaseFirestore.instance;

  submitPredictionData(Patient patient) async {
    var response = {};

    await _firestore
        .collection(COLLECTION_NAME)
        .doc(UserHelper().myId())
        .collection(COLLECTION_NAME)
        .add(patient.toJson())
        .then((value) {
      response['error'] = 0;
    }).catchError(
      (err) {
        response['error'] = 1;
        response['message'] = err.toString();
      },
    );

    return response;
  }

  getPatientData() async {
    var response = {};
    List<Patient> patients = [];

    await _firestore
        .collection(COLLECTION_NAME)
        .doc(UserHelper().myId())
        .collection(COLLECTION_NAME)
        .get()
        .then((value) {
      response['error'] = 0;
      for (int i = 0; i < value.docs.length; i++) {
        Patient patient = Patient().fromJson(value.docs[i].data());
        patients.add(patient);
      }
      response['data'] = patients;
    }).catchError(
      (err) {
        response['error'] = 1;
        response['message'] = err.toString();
      },
    );

    return response;
  }
}
