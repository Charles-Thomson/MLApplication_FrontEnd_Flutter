import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/built_maze.dart';
import 'package:ann_app/widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;
import 'package:ann_app/widgets/custom_floating_button.dart';

//TODO: Work out bug with the rendering on the button press to open Hero
//TODO: Refactor layouts to use Flexible ?
//TODO: Refactor down cards and clean up design
//TODO: Bug with higher number of buttons making outliers un-clickable - due to the offset maybe ?

//TODO: Maze map selection requires x tp be greater then y to see y selection
// TODO: Do we refactor to use x , y location over states


// TODO: Consider refactoring parameter selection and function selection into on pop-out
// TODO: The shading on the map isn't accurate when the map size changes


// TODO TODAY/NEXT:
// Colour selection of chip and bar on graph need to be the same
// Pull number of chips from num of generations ->
// BUG not passing the last chips data



// Connect up the button to the API
// Then Clean UP everything before moving to back end


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // TODO: THIS ISN'T REBUILDING TO CORRECT SIZE ON THE NEW MAZE
  List tileData = List.generate(maze_config.totalMazeStates, (index) => 0); // +1 as it's a loop
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
    print(configData);
    updateLoadingValue();
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

  FloatingActionButtonLocation startDocked = FloatingActionButtonLocation.startDocked;
  FloatingActionButtonLocation centerDocked = FloatingActionButtonLocation.centerDocked;
  FloatingActionButtonLocation endDocked = FloatingActionButtonLocation.endDocked;

  FloatingActionButtonLocation dockedLocation = FloatingActionButtonLocation.startDocked;

  void floatingActionButtonLocationHandling(){
    setState(() {
      if(dockedLocation == startDocked) {
        dockedLocation = endDocked;
      }else if(dockedLocation == endDocked){
        dockedLocation = startDocked;
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

  void updateMazeMap(Map<String, String> newMapData){
    maze_config.updateInConfig(newMapData);
    print("Map update received");
    print(newMapData);

    // call for a general reset
    setState(() {
    });
    print("Post set State");

  }

  int agentAnimationLocation = 0;

  // just needs to pass one int at a time (the next location as state)
  Future<void> runAnimation(List<int> animationPath) async {
    for(int newState in animationPath){
      print(newState);
      await Future.delayed(const Duration(seconds: 2), (){
        setState(() {
          agentAnimationLocation = newState;
        });
      }
      );
    }

  }

  // will take a list<int> animationPath from the return call
  void testAnimation(){
    setState(() {
      animationVisible = true;
      animationPath = [6,7,8,9,10];
      //startAnimation = true;
    });
    floatingActionButtonLocationHandling();
    //runAnimation(animationPath);
  }

  void updateLoadingValue(){
    double holdingValue = 0.0;
    for(var value in configData.values){
      if(value != ""){
        holdingValue += (1 / 9);
      }
    }
    setState(() {
      loadingValue = holdingValue;
    });

  }

  List<int> animationPath = [];
  bool animationVisible = false;
  bool startAnimation = false;
  double loadingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    print(loadingValue);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Callback for updating the maze in here
      bottomNavigationBar: CustomBottomNavBar(dockedLocation,

      updateConfigData: (configKey, newValue){
        updateConfigData(configKey, newValue);
      },

      updateMazeMap: (newMapData){
        updateMazeMap(newMapData);
      }),

      floatingActionButton:
      CustomFloatingButton(
          loadingValue: loadingValue,
          floatingActionButtonLocationHandling: floatingActionButtonLocationHandling
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // FloatingActionButton(
      //   onPressed: updateLoadingValue,
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.start_outlined)
      //   ,),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Column(
        children:  [
          const SizedBox(
              height: 100
          ),
          Stack(
            children: [


            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: SingleChildScrollView(
                    child: BuiltMaze(
                      updateTileDataCallBack: (index, tileState){
                        int newTileState = updateTileListData(index, tileState);
                        return newTileState;
                        },
                      animationVisible: animationVisible,
                      agentAnimationLocation: agentAnimationLocation,
                      ),
                  )
                  ),
              ),
            ),
          ]
         ),
  ]
      ));
     // This trailing comma makes auto-formatting nicer for build methods.
  }
}