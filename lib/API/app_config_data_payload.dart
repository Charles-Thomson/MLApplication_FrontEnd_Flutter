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

void updateConfigDataPayload(String configKey, String newValue){
  configData[configKey] = newValue;
  print([configKey, newValue]);
  //print(configData);
}
//=> configData[configKey] = newValue;

void resetConfigDataPayload() => configData.updateAll((key, value) => value = "");

