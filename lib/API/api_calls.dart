import 'package:http/http.dart' as http;
String url = '';
String map = '';

String data = '';
String finalData = '';
List tagsJson = [];

void testApiCall() async {
  //var testQuery = "TestQuery";
  //String url = "";
  try{
    //var payload = {};
    // setMapData(); <- need to attch to the call for the button before this is called
    // print(configData); // test

    // payload['payloadBody'] = configData;
    // String encodedPayload = json.encode(payload);
    // url = "http://10.0.2.2:5000/PAYLOAD?query=$encodedPayload";
    // data = await pass-map(url);
    // print(data);
    // print("SYSTEM -> Data Passed to backend");

    // String tileDataString = tileData.join(',');
    // url = "http://10.0.2.2:5000/run_map?query=$tileDataString";
    // data = await pass-map(url);
    // tagsJson = jsonDecode(data)['output'];
    // final-data = tagsJson.toString();
    // print("in the call");
    // print(final-data);

  }catch(e){
    // print("In the catch");
  }

}

passMap(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}