
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as mazeCionfig;


// Start as Default Values
Map<String, String> configData = {
  'WEIGHT_INITIALIZATION_HEURISTIC': "HE",
  "HIDDEN_LAYER_ACTIVATION_FUNCTION": "Relu",
  "OUTPUT_LAYER_ACTIVATION_FUNCTION": "Arg max",
  "WEIGHTS_CONCATENATION_FUNCTION": "Merging",
  "MAX_GENERATION_SIZE": "100",
  "STARTING_FITNESS_THRESHOLD": "3.0",
  "DESIRED_FIT_GENERATION_SIZE": "6",
  "ENV_MAP": "",
  "MAX_EPISODE_DURATION": "10",
  "NUMBER_OF_GENERATIONS" : "10",
  "ENV_MAP_DIMENSIONS": "",
  "ENVIRONMENT_START_STATE": "0",
};

Map<String, String> configDataDefaults = {
  'WEIGHT_INITIALIZATION_HEURISTIC': "HE",
  "HIDDEN_LAYER_ACTIVATION_FUNCTION": "Relu",
  "OUTPUT_LAYER_ACTIVATION_FUNCTION": "Arg max",
  "WEIGHTS_CONCATENATION_FUNCTION": "Merging",
  "MAX_GENERATION_SIZE": "100",
  "STARTING_FITNESS_THRESHOLD": "3.0",
  "DESIRED_FIT_GENERATION_SIZE": "6",
  "ENV_MAP": "",
  "MAX_EPISODE_DURATION": "10",
  "NUMBER_OF_GENERATIONS" : "10",
  "ENV_MAP_DIMENSIONS": "",
  "ENVIRONMENT_START_STATE": "0",
};

// Check the map data for: Single start, at least one goal node
bool checkMapDataValidity(List<int> tileData){
  print(tileData);
  var counter = <int, int>{0: 0,1: 0, 2: 0, 3: 0};
  for(int value in tileData){
    counter.update(value, (count) => count + 1, ifAbsent: () => 1);
  }

  print(counter);
  if(counter[1]! > 1 || counter[1] == 0){
    print("Start State invalid");
    return false;
  }

  if(counter[3] == 0){
    print("Goal State invalid");
    return false;
  }


  return true;
}

int getMapStartLocation(List<int> tileData){
  int startLocationValue = 1;
  int startLocationIndex = tileData.indexOf(startLocationValue);

  return startLocationIndex;
}

String get getMapDimensionsAsString =>  mazeCionfig.totalXStates.toString();


bool validateAndSetMapData(List<int> tileData){
  configData["ENV_MAP_DIMENSIONS"] = getMapDimensionsAsString;

  bool mapValid = checkMapDataValidity(tileData);

  if(mapValid == true){
    int startLocationIndex = getMapStartLocation(tileData);
    tileData[startLocationIndex] = 0;
    configData["ENVIRONMENT_START_STATE"] = startLocationIndex.toString();
    configData["ENV_MAP"] = tileData.join(",");
    return true;
  }
  return false;
}


void updateConfigDataPayload(String configKey, String newValue){
  configData[configKey] = newValue;
  print([configKey, newValue]);
  //print(configData);
}
//=> configData[configKey] = newValue;

//void resetConfigDataPayload() => configData.updateAll((key, value) => value = "");

void resetConfigDataPayload() => configData = configDataDefaults;

get getCurrentConfigData => configData;
get getTestConfigData => configDataDefaults;

void printCurrentConfig() => print(configData);


