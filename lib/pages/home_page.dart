import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/built_maze.dart';
import 'package:ann_app/widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;

//TODO: Work out bug with the rendering on the button press to open Hero
//TODO: Refactor layouts to use Flexible ?
//TODO: Refactor down cards and clean up design
//TODO: Bug with higher number of buttons making outliers un-clickable - due to the offset maybe ?

// TODO: Do we refactor to use x , y location over states

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List tileData = List.generate(maze_config.mapSizeStates, (index) => 0); // +1 as it's a loop
  get stringCurrentTileData => tileData.join(",");
  Map<String, String> configData = {
    'WEIGHT_INITIALIZATION_HEURISTIC': "",
    "HIDDEN_LAYER_ACTIVATION_FUNCTION": "",
    "OUTPUT_LAYER_ACTIVATION_FUNCTION": "",
    "WEIGHTS_CONCATENATION_FUNCTIONS": "",
    "MAX_GENERATION_SIZE": "",
    "STARTING_FITNESS_THRESHOLD": "",
    "DESIRED_FIT_GENERATION_SIZE": "",
    "ENV_MAP": "",
    "MAX_EPISODE_DURATION": "",
    "NUMBER_OF_GENERATIONS" : "",
    "ENV_MAP_DIMENSIONS": "",
    "ENVIRONMENT_START_STATE": "",
  };

  void updateConfigData(String configKey, String newValue){
    configData[configKey] = newValue;
  }

  int updateTileListData(int index, var tileState){
    if(tileData[index] >= 3){
      tileData[index] = 0;
    }else{
      tileData[index] += 1;
    }
    int returnVal = tileData[index];
    return returnVal;
  }

  FloatingActionButtonLocation frontDocked = FloatingActionButtonLocation.startDocked;
  FloatingActionButtonLocation endDocked = FloatingActionButtonLocation.endDocked;
  FloatingActionButtonLocation dockedLocation = FloatingActionButtonLocation.startDocked;

  // Will be used to update the size of the map when selected in mapHero
  void updateMapSize(){

  }


  void floatingActionButtonHandling(){
    setState(() {
      if(dockedLocation == endDocked){
        dockedLocation = frontDocked;
        // print("Tile data requested $tileData");
      }else if(dockedLocation == frontDocked) {
        dockedLocation = endDocked;
        // print("Tile data requested $tileData");
      }
    });
  }

  passMap(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    return response.body;
  }

  String url = '';
  String map = '';

  String data = '';
  String finalData = '';
  List tagsJson = [];

  // no guard for multiple start tiles
  void setMapData(){
    double mapDimensions = sqrt(tileData.length);
    configData["ENV_MAP_DIMENSIONS"] = mapDimensions.toString();
    int startLocationValue = 1;
    int startLocationIndex = tileData.indexOf(startLocationValue);
    tileData[startLocationIndex] = 0;
    configData["ENVIRONMENT_START_STATE"] = startLocationIndex.toString();
    configData["ENV_MAP"] = stringCurrentTileData;
  }

  void testCallPayloadSetting(){
    setMapData();
    // print(configData);

  }

  void testApiCall() async {
    //var testQuery = "TestQuery";
    //String url = "";
    try{
      //var payload = {};
      setMapData();
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
        onPressed: testCallPayloadSetting,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.start_outlined)
        ,),
      floatingActionButtonLocation: dockedLocation,

      body: Column(
        children:  [
          const SizedBox(height: 100),
          Stack(
            children: [
            Center(
              child: BuiltMaze(
                updateTileDataCallBack: (index, tileState){
                  int newTileState = updateTileListData(index, tileState);
                  return newTileState;
                  }
                )
              ),
          const SizedBox(
            height: 100
          ),

          ]
         ),
  ]
      ));
     // This trailing comma makes auto-formatting nicer for build methods.
  }
}