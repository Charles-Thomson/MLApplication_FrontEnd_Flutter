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

    var decoded_data = jsonDecode(data);

    List<List> formattedData = formatPayloadData(decoded_data);

    return formattedData;


  // }catch(e){
  //   print("In the catch");
  //   return [];
  // }

}

List<List> formatPayloadData(List<dynamic> payloadData){
  print("In format payload");
  List<List> formattedData = [];
  for(int i = 0; i < payloadData.length / 2; i += 2){
    Map high_fit_data = payloadData[i];
    Map low_fit_data = payloadData[i+1];

    print(high_fit_data["traversed_path"]);
    print(high_fit_data["traversed_path"].runtimeType);

    double higest_fitness = double.parse(high_fit_data["fitness"]);

    List<String> higest_fitness_path = high_fit_data["traversed_path"].split(',');
    List<String> higest_fitness_path_as_fitness = high_fit_data["fitness_by_step"].split(',');

    double lowest_fitness = double.parse(low_fit_data["fitness"]);
    List<String> lowest_fitness_path = low_fit_data["traversed_path"].split(',');
    List<String> lowest_fitness_path_as_fitness = low_fit_data["fitness_by_step"].split(',');

    List<int> higest_fitness_path_int = higest_fitness_path.map(int.parse).toList();
    List<double> higest_fitness_path_as_fitness_int = higest_fitness_path_as_fitness.map(double.parse).toList();

    List<int> lowest_fitness_path_int = lowest_fitness_path.map(int.parse).toList();
    List<double> lowest_fitness_path_as_fitness_int = lowest_fitness_path_as_fitness.map(double.parse).toList();



    List data = [higest_fitness,higest_fitness_path_int, higest_fitness_path_as_fitness_int, lowest_fitness,lowest_fitness_path_int,lowest_fitness_path_as_fitness_int];
    print(data);
    formattedData.add(data);
  }

  return formattedData;

}

passPayload(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

