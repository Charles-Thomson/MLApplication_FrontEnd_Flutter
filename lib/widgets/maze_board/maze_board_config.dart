
int totalXStates = 6;
int totalYStates = 6;
int totalMazeStates = totalXStates * totalYStates;

double tileSize = 40;
double tileGridHeight = tileSize  * totalXStates ;
double tileGridWidth  = tileSize  * totalYStates ;

double edgeRadius = 20;
// working at 30
double rimOffSet = 30;

// Used in built_maze
double mazeHeight = tileGridHeight + (edgeRadius * 2) ;
double mazeWidth = tileGridWidth + (edgeRadius * 2) ;

//Used in rim_painter -> RimContainerCutout
double rimContainerCutOutHeight = tileGridHeight + 10;
double rimContainerCutOutWidth = tileGridWidth + 10;

// Used in agent_animation
double animationGridHeight = tileGridHeight;
double animationGridWidth = tileGridWidth;

double agentDrawHeight = tileSize;
double agentDrawWidth = tileSize;

void updateInConfig(Map<String, String> updateData){
  totalXStates = int.parse(updateData["mapSizeX"]!);
  totalYStates = int.parse(updateData["mapSizeY"]!);
  tileSize  = double.parse(updateData["tileSize"]!);
  totalMazeStates = totalXStates * totalYStates;

  tileGridHeight = tileSize * totalXStates;
  tileGridWidth  = tileSize * totalYStates;

  mazeHeight = tileGridHeight + (edgeRadius * 2);
  mazeWidth = tileGridWidth + (edgeRadius * 2);

  rimContainerCutOutHeight = tileGridHeight + 10;
  rimContainerCutOutWidth = tileGridWidth + 10;

  animationGridHeight = tileGridHeight;
  animationGridWidth = tileGridWidth;

  agentDrawHeight = tileSize;
  agentDrawWidth = tileSize;
}



