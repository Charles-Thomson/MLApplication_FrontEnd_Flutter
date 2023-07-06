import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/built_maze.dart';
import 'package:ann_app/widgets/bottom_nav_bar.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;
import 'package:ann_app/widgets/custom_floating_button.dart';
import 'package:ann_app/API/app_config_data_payload.dart' as api_payload;

//TODO: Refactor layouts to use Flexible ?
//TODO: Consider refactoring parameter selection and function selection into on pop-out
//TODO: Color of bar graph lines needs to correspond to Chip

//BUG: Higher number of buttons making outliers un-clickable - due to the offset maybe ?
//BUG: Work out bug with the rendering on the button press to open Hero
//BUG: The shading on the map isn't accurate when the map size changes
//BUG: Values arnt being saved in the function selection drop down for the UI


// TODO TODAY/NEXT:
// The API submission/ any setState call is clearing the Map
// Add the reset button to floating action button

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
  int floatingABState = 0;
  int currentAnimationLocation = 0;
  bool animationVisible = false;
  List<int> tileData = List.generate(maze_config.totalMazeStates, (index) => 0);

  get stringCurrentTileData => tileData.join(",");

  void rebuildTileData() => tileData = List.generate(maze_config.totalMazeStates, (index) => 0);

  int updateTileData(int index, var tileState) => tileData[index] >= 3 ? tileData[index] = 0 : tileData[index] += 1;

  void updateFABStateCallBack() => setState(() { floatingABState == 0 ? floatingABState = 1 : floatingABState = 0;});

  void resetAll(){
    print("SYSTEM -> RESET ALL CALLED");
    maze_config.updateInConfig(); // resets the maze_config to defaults
    api_payload.resetConfigDataPayload(); // resets the api payload
    setState(() {
      loadingValue = 0.0;
      floatingABState = 0;
      currentAnimationLocation = 0;
      animationVisible = false;
      rebuildTileData();
    });
  }

  void updateMazeMapSize(Map<String, String> newMapData){
    maze_config.updateInConfig(updateData: newMapData);
    setState(() {
      rebuildTileData();
    });
  }


  void updateLoadingValue() {
    double newLoadingValue = 0.0;
    for (var value in api_payload.configData.values) {
      value == "" ? null : newLoadingValue += (1 / 9);
    }
    setState(() {
      loadingValue = newLoadingValue;
    });
  }

  // no guard for multiple start tiles
  void setMapData(){
    int mapDimensions = maze_config.totalXStates * maze_config.totalYStates;
    api_payload.configData["ENV_MAP_DIMENSIONS"] = mapDimensions.toString();
    int startLocationValue = 1;
    int startLocationIndex = tileData.indexOf(startLocationValue);
    tileData[startLocationIndex] = 0;
    api_payload.configData["ENVIRONMENT_START_STATE"] = startLocationIndex.toString();
    api_payload.configData["ENV_MAP"] = stringCurrentTileData;
  }



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

  void placeHolderAPICallBack(){
    // Make a pop out to confirm the submission
    // Add in some form of future builder with a loading widget
    // Loading based on the progress of the back end ?
    print("SYSTEM -> API call back made");

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        buttonState: floatingABState,

      runAnimationCallBack: (animationPath){
        runAnimationCallBack(animationPath);
      },

      updateConfigData: (configKey, newValue){
        api_payload.updateConfigDataPayload(configKey, newValue);
        updateLoadingValue();
      },

      updateMazeMap: (newMapData){
        updateMazeMapSize(newMapData);
      }),

      floatingActionButton:
          CustomFloatingButton(
              floatingActionButtonState: floatingABState,
              loadingValue: loadingValue,

              updateFloatingActionButtonStateCallBack: (){
                updateFABStateCallBack();
              },
              apiSubmissionCallBack: (){
              placeHolderAPICallBack(); },

              resetAllCallBack: (){
                resetAll();}
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
                        int newTileState = updateTileData(index, tileState);
                        return newTileState;
                        },
                      animationVisible: animationVisible,
                      agentAnimationLocation: currentAnimationLocation,
                      tileData: tileData,
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