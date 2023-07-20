import 'package:ann_app/API/api_calls.dart' as api_calls;
import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/built_maze.dart';
import 'package:ann_app/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;
import 'package:ann_app/widgets/floating_action_button/custom_floating_button.dart';
import 'package:ann_app/API/app_config_data_payload.dart' as api_payload;

//TODO: Refactor layouts to use Flexible ?
//TODO: Refactor size to use media query
//TODO: Consider refactoring parameter selection and function selection into on pop-out
//TODO: Color of bar graph lines needs to correspond to Chip

//BUG: Higher number of buttons making outliers un-clickable - due to the offset maybe ?
//BUG: Work out bug with the rendering on the button press to open Hero
//BUG: The shading on the map isn't accurate when the map size changes
//BUG: Values arnt being saved in the function selection drop down for the UI
//BUG: Guard handling for the Map data


// TODO TODAY/NEXT:
// Testing and clean up needed
// Need a future builder ? on waiting for the return payload
// Need a clear of the back end DB'S on each run
// Create a unified payload file ?

// file clean up


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
  List animationData = [];
  bool mapValid = false;

  List<List> payloadData = [];

  List<int> tileData = List.generate(maze_config.totalMazeStates, (index) => 0);

  void rebuildTileData() => tileData = List.generate(maze_config.totalMazeStates, (index) => 0);

  int updateTileData(int index, var tileState) => tileData[index] >= 3 ? tileData[index] = 0 : tileData[index] += 1;

  void updateFABState(){
    print("In update FAB homepage");
      setState(() { floatingABState == 0 ? floatingABState = 1 : floatingABState = 0;}
      );
  }


  void updateFABStateCallBack(){
    print("In update FAB");
    if(mapValid == true){
      setState(() { floatingABState == 0 ? floatingABState = 1 : floatingABState = 0;}
    );}
  }

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

  void placeHolderAPICallBack() async {
     bool mapValid = api_payload.validateAndSetMapData(tileData);

     if(mapValid == true){
       api_payload.printCurrentConfig();
       List<List> data = await api_calls.testApiCall();
       print("SYSTEM -> API call back made");
       setState(() {
         mapValid = true;
         payloadData = data;
       });
       print(payloadData.length);
       updateFABState();

     } else {
       print("Map is not valid");
       setState(() {
         mapValid = false;
       });
     }



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
      },

      payloadData: payloadData,
      ),



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