import 'dart:convert';

import 'package:http/http.dart' as http;

class PredictionApiServices {
  static const String URL =
      'http://breast-cancer-fyp.herokuapp.com/api/cancer_prediction';

  static prediction(body) async{
    var res = {};

    var url = Uri.parse(URL);

    await http
        .post(url,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: json.encode(body))
        .then((response) {

      final prediction =
          (double.parse(response.body.toString().replaceAll("\"", '')) * 100);
      res['error'] = 0;
      res['prediction'] = prediction;
    }).catchError((err) {
      res['error'] = 1;
      res['message'] = err.toString();
    });

    return res;
  }

}
