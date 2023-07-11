import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ann_app/API/app_config_data_payload.dart';
String url = '';
String map = '';

String data = '';
String finalData = '';
List tagsJson = [];


// Payload back needs to be ->
// Each generation:
// Highest + lowest Fitness
// Longest + Shortest path
// Best Path as fitness by step


Future<List> testApiCall() async {
  Map configData = getCurrentConfigData;
  try{
    var payload = {};
    payload['payloadBody'] = getTestConfigData;
    //print("SYSTEM -> PAYLOAD: ");
    //print(payload);

    String encodedPayload = json.encode(payload);
    url = "http://10.0.2.2:5000/TESTPAYLOAD?query=$encodedPayload";
    data = await passPayload(url);

    // Works as a return
    Map tagsJson = jsonDecode(data);
    // print(tagsJson["HIGHEST_FITNESS"]);
    // print(tagsJson["HIGHEST_FITNESS_PATH"]);
    // print(tagsJson["LOWEST_FITNESS"]);
    // print(tagsJson["LOWEST_FITNESS_PATH"]);

    double highestFitness = double.parse(tagsJson["HIGHEST_FITNESS"].toString());
    List highestFitnessPath = json.decode(tagsJson["HIGHEST_FITNESS_PATH"].toString());
    double lowestFitness = double.parse(tagsJson["LOWEST_FITNESS"].toString());
    List lowestFitnessPath = json.decode(tagsJson["LOWEST_FITNESS_PATH"].toString());

    List returnData = [highestFitness,highestFitnessPath,lowestFitness,lowestFitnessPath];
    //print(returnData);

    return returnData;

  }catch(e){
    print("In the catch");
    return [];
  }

}

passPayload(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}