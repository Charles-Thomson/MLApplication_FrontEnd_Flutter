import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze/built_maze.dart';
import 'package:ann_app/widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ann_app/widgets/nav_bar_buttons/testing_pop_out.dart';

import 'package:ann_app/widgets/function_selection_widgets/bottom_nav_function_settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List tileData = List.generate(16, (index) => 1); // +1 as it's a loop
  get stringCurrentTileData => tileData.join(",");
  Map<String, String> configData = {
    'WEIGHT_INITALIZATION_HEURISTIC': "1",
    "HIDDEN_LAYER_ACTIVATION_FUNCTION": "1",
    "OUTPUT_LAYER_ACTIVATION_FUNCTION": "1",
    "WEIGHTS_CONCATENATION_FUNCTIONS": "2",

    "MAX_GENERATION_SIZE": "2",
    "STARTING_FITNESS_THRESHOLD": "3.0",
    "DESIERED_FIT_GENERATION_SIZE": "5",
    "ENV_MAP": "",
    "ENV_MAP_DIMENSIONS": "4",
    "ENVIRONMENT_START_STATE": "1",
    "MAX_EPISODE_DURATION": "10",
    "NUMBER_OF_GENERATIONS" : "10"
  };

  void updateConfigData(String configKey, String newValue){
    configData[configKey] = newValue;
    print(configData);
  }

  int updateTileListData(int index, var tileState){
    if(tileData[index] >= 3){
      tileData[index] = 1;
    }else{
      tileData[index] += 1;
    }
    print("The current list of index's:  $tileData ");
    int returnVal = tileData[index];
    return returnVal;
  }

  FloatingActionButtonLocation frontDocked = FloatingActionButtonLocation.startDocked;
  FloatingActionButtonLocation endDocked = FloatingActionButtonLocation.endDocked;
  FloatingActionButtonLocation dockedLocation = FloatingActionButtonLocation.startDocked;


  void floatingActionButtonHandling(){
    setState(() {
      if(dockedLocation == endDocked){
        dockedLocation = frontDocked;
        print("Tile data requested $tileData");
      }else if(dockedLocation == frontDocked) {
        dockedLocation = endDocked;
        print("Tile data requested $tileData");
      }
    });
  }

  passmap(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    return response.body;
  }

  String url = '';
  String map = '';

  String data = '';
  String finaldata = '';
  List tagsJson = [];


  void testApiCall() async {
    var testQuery = "TestQuery";
    String url = "";
    try{
      var payload = {};
      configData["ENV_MAP"] = stringCurrentTileData;
      payload['payloadBody'] = configData;
      print(configData["ENV_MAP"].runtimeType);
      String encodedPayload = json.encode(payload);
      url = "http://10.0.2.2:5000/PAYLOAD?query=$encodedPayload";
      data = await passmap(url);
      print(data);
      print("SYSTEM -> Data Passed to backend");

      // String tileDataString = tileData.join(',');
      // url = "http://10.0.2.2:5000/run_map?query=$tileDataString";
      // data = await passmap(url);
      // tagsJson = jsonDecode(data)['output'];
      // finaldata = tagsJson.toString();
      // print("in the call");
      // print(finaldata);

    }catch(e){
      print("In the catch");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: CustomBottomNavBar(dockedLocation, updateConfigData: (configKey, newValue){
        updateConfigData(configKey, newValue);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: testApiCall,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.start_outlined)
        ,),
      floatingActionButtonLocation: dockedLocation,

      body: Column(
        children:  [
          const SizedBox(height: 100),
          Center(
            child: BuiltMaze(
              updateTileData_CallBack: (index, tileState){
                int newTileState = updateTileListData(index, tileState);
                return newTileState;
                }
              )
            ),
          ]
         ),
      );
     // This trailing comma makes auto-formatting nicer for build methods.
  }
}