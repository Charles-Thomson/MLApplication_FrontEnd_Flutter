import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/built_maze.dart';
import 'package:ann_app/widgets/bottom_nav_bar.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;
import 'package:ann_app/widgets/custom_floating_button.dart';
import 'package:ann_app/API/app_config_data_payload.dart';

//TODO: Refactor layouts to use Flexible ?
//TODO: Consider refactoring parameter selection and function selection into on pop-out
//TODO: Color of bar graph lines needs to correspond to Chip

//BUG: Higher number of buttons making outliers un-clickable - due to the offset maybe ?
//BUG: Work out bug with the rendering on the button press to open Hero
//BUG: The shading on the map isn't accurate when the map size changes
//BUG: Values arnt being saved in the function selection drop down for the UI


// TODO TODAY/NEXT:
// Add the reset button to floation action button

// CLEAN UP ->
// Move all the elements out of home page

// Move all the Json data handling to the top of the widget tree and pass down ?
// Connect up the button to the API
// Then Clean UP everything before moving to back end


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double loadingValue = 0.0;
  int floatingActionButtonState = 0;
  int currentAnimationLocation = 0;
  bool animationVisible = false;

  void resetAll(){
    setState(() {
      loadingValue = 0.0;
      floatingActionButtonState = 0;
      currentAnimationLocation = 0;
      animationVisible = false;
      List.generate(maze_config.totalMazeStates, (index) => 0);
    });
    // need to reset the API data
    // need to reset the maze_config data

  }



  List tileData = List.generate(maze_config.totalMazeStates, (index) => 0);

  get stringCurrentTileData => tileData.join(",");

  void updateConfigDataPayload(String configKey, String newValue) => configData[configKey] = newValue;

  void updateFloatingActionButtonStateCallBack() => setState(() {
    floatingActionButtonState == 0 ?
    floatingActionButtonState = 1 : floatingActionButtonState = 0;
  });

  void updateMazeMap(Map<String, String> newMapData){
    maze_config.updateInConfig(newMapData);
    setState(() {
      tileData = List.generate(maze_config.totalMazeStates, (index) => 0);
    });
  }

  void updateLoadingValue() {
    double newLoadingValue = 0.0;
    for (var value in configData.values) {
      value == "" ? null : newLoadingValue += (1 / 9);
    }
    setState(() {
      loadingValue = newLoadingValue;
    });
  }

  // no guard for multiple start tiles
  void setMapData(){
    int mapDimensions = maze_config.totalXStates * maze_config.totalYStates;
    configData["ENV_MAP_DIMENSIONS"] = mapDimensions.toString();
    int startLocationValue = 1;
    int startLocationIndex = tileData.indexOf(startLocationValue);
    tileData[startLocationIndex] = 0;
    configData["ENVIRONMENT_START_STATE"] = startLocationIndex.toString();
    configData["ENV_MAP"] = stringCurrentTileData;
  }

  int updateTileListData(int index, var tileState) =>
      tileData[index] >= 3 ? tileData[index] = 0 : tileData[index] += 1;

  Future<void> runAnimationCallBack(List<int> animationPath) async {
    for(int newLocation in animationPath){
      await Future.delayed(const Duration(seconds: 2), (){
        setState(() {
          currentAnimationLocation = newLocation;
          animationVisible = true;
        });
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        buttonState: floatingActionButtonState,

      runAnimationCallBack: (animationPath){
        runAnimationCallBack(animationPath);
      },

      updateConfigData: (configKey, newValue){
        updateConfigDataPayload(configKey, newValue);
        updateLoadingValue();
      },

      updateMazeMap: (newMapData){
        updateMazeMap(newMapData);
      }),

      floatingActionButton:
          CustomFloatingButton(
              loadingValue: loadingValue,
              updateFloatingActionButtonStateCallBack: (){
                updateFloatingActionButtonStateCallBack();
              }
           ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
                      agentAnimationLocation: currentAnimationLocation,
                      ),
                  )
                  ),
              ),
            ),
          ]
         ),
        ]
    ));
  }
}