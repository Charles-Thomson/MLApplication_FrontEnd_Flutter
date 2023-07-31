import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ann_app/API/app_config_data_payload.dart';
import 'package:ann_app/API/api_endpoints.dart' as end_points;
String url = '';
String map = '';

String data = '';
String finalData = '';
List tagsJson = [];

Future<List<List>> testApiCall() async {
  //Map configData = getCurrentConfigData;
  http.Client client = http.Client();
  // try{
    var payload = {};
    payload['payloadBody'] = getCurrentConfigData;
    // print(payload);

    String encodedPayload = json.encode(payload);
    url = "http://10.0.2.2:8000/run_main_system/$encodedPayload/";
    // url = "http://10.0.2.2:8000/get_data/";

    data = await passPayload(url);
    print(data);

    // // Works as a return
    Map tagsJson = jsonDecode(data);
    print("JSON DECODED");
    List<List> formattedData = formatPayloadData(tagsJson);

    return formattedData;
   // return [];

  // }catch(e){
  //   print("In the catch");
  //   return [];
  // }

}

List<List> formatPayloadData(Map payloadData){
  print("In format payload");
  List<List> formattedData = [];
  for (var key in payloadData.keys){
    Map thisData = payloadData[key];

    double highestFitness = double.parse(thisData["HIGHEST_FITNESS"].toString());
    List highestFitnessPath = json.decode(thisData["HIGHEST_FITNESS_PATH"].toString());
    List highestFitnessByStep = json.decode(thisData["HIGHEST_FITNESS_BY_STEP"].toString());

    double lowestFitness = double.parse(thisData["LOWEST_FITNESS"].toString());
    List lowestFitnessPath = json.decode(thisData["LOWEST_FITNESS_PATH"].toString());
    List lowestFitnessByStep = json.decode(thisData["LOWEST_FITNESS_BY_STEP"].toString());

    List returnData = [highestFitness,highestFitnessPath,highestFitnessByStep,lowestFitness,lowestFitnessPath, lowestFitnessByStep];
    formattedData.add(returnData);
  }
  return formattedData;

}

passPayload(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

