

// Used in built_maze
double mazeHeight = 200;
double mazeWidth = 200;

double edgeRadius = 20;
// working at 30
double rimOffSet = 30;

// Used in multiple tile files
int mapSize = 4;
int mapSizeX = 4;
int mapSizeY = 4;
int mapSizeStates = mapSize * mapSize;

double tileGridWidth = mazeWidth - (edgeRadius * 2);
double tileGridHeight = mazeHeight - (edgeRadius * 2);
double tileHeight = tileGridWidth / mapSizeY;
double tileWidth = tileGridHeight / mapSizeX;

//Used in rim_painter -> RimContainerCutout
double rimContainerCutOutHeight = tileGridHeight + 10;
double rimContainerCutOutWidth = tileGridWidth + 10;

// Used in agent_animation
double animationGridHeight = tileGridHeight;
double animationGridWidth = tileGridWidth;

double agentDrawHeight = tileHeight;
double agentDrawWidth = tileWidth;
