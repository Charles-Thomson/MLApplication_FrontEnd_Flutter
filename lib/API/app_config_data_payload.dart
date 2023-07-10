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

Map<String, String> testData = {
  'WEIGHT_INITIALIZATION_HEURISTIC': "HE",
  "HIDDEN_LAYER_ACTIVATION_FUNCTION": "Relu",
  "OUTPUT_LAYER_ACTIVATION_FUNCTION": "Arg max",
  "WEIGHTS_CONCATENATION_FUNCTION": "Merging",
  "MAX_GENERATION_SIZE": "200",
  "STARTING_FITNESS_THRESHOLD": "3.0",
  "DESIRED_FIT_GENERATION_SIZE": "6",
  "ENV_MAP": "1,3,2,1,1,1,1,1,2,3,1,1,1,1,1,1",
  "MAX_EPISODE_DURATION": "10",
  "NUMBER_OF_GENERATIONS" : "10",
  "ENV_MAP_DIMENSIONS": "4",
  "ENVIRONMENT_START_STATE": "0",
};


void updateConfigDataPayload(String configKey, String newValue){
  configData[configKey] = newValue;
  print([configKey, newValue]);
  //print(configData);
}
//=> configData[configKey] = newValue;

void resetConfigDataPayload() => configData.updateAll((key, value) => value = "");

get getCurrentConfigData => configData;
get getTestConfigData => testData;

void printCurrentConfig() => print(configData);


