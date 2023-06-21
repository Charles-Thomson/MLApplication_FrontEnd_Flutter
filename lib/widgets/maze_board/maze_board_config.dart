
// testing
double tileHeight = 40;
double tileWidth = 40;

int totalXStates = 4;
int totalYStates = 5;
int totalMazeStates = totalXStates * totalYStates;

double tileGridHeight = tileHeight * totalXStates;
double tileGridWidth  = tileWidth * totalYStates;

double edgeRadius = 20;
// working at 30
double rimOffSet = 30;

// Used in built_maze
double mazeHeight = tileGridHeight + (edgeRadius * 2);
double mazeWidth = tileGridWidth + (edgeRadius * 2);

//Used in rim_painter -> RimContainerCutout
double rimContainerCutOutHeight = tileGridHeight + 10;
double rimContainerCutOutWidth = tileGridWidth + 10;

// Used in agent_animation
double animationGridHeight = tileGridHeight;
double animationGridWidth = tileGridWidth;

double agentDrawHeight = tileHeight;
double agentDrawWidth = tileWidth;

void updateInConfig(Map<String, String> updateData){
  print("Config update Called");
  totalXStates = int.parse(updateData["mapSizeX"]!);
  totalYStates = int.parse(updateData["mapSizeY"]!);

  tileHeight = double.parse(updateData["tileHeight"]!);
  tileWidth  = double.parse(updateData["tileWidth"]!);

  tileGridHeight = tileHeight * totalXStates;
  tileGridWidth  = tileWidth * totalYStates;

  mazeHeight = tileGridHeight + (edgeRadius * 2);
  mazeWidth = mazeWidth + (edgeRadius * 2);

  rimContainerCutOutHeight = tileGridHeight + 10;
  rimContainerCutOutWidth = tileGridWidth + 10;

  animationGridHeight = tileGridHeight;
  animationGridWidth = tileGridWidth;

  agentDrawHeight = tileHeight;
  agentDrawWidth = tileWidth;
}



