import 'package:flutter/material.dart';
import 'package:ann_app/widgets/agent/agent_body.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;

class AgentAnimation extends StatefulWidget{
  const AgentAnimation({super.key});

  @override
  State<AgentAnimation> createState() => _AgentAnimation();

}

class _AgentAnimation extends State<AgentAnimation>{
  // will need to be passed
  final int rows = 4;
  final int cols = 4;

  // will need to be passed
  final double mazeX = maze_config.animationGridHeight;
  final double mazeY = maze_config.animationGridWidth;

  final List<int> agentPath = [0, 1, 2, 3, 5,15];

  double currentX = 0;
  double currentY = 0;

  double xStep = 0 ;
  double yStep = 0 ;
  
  void setStepDistance(){
    xStep = mazeX / cols;
    yStep = mazeY / rows;
  }

  List<double> calculateNewLocation(int state){
    int xGridLocation = (state / cols).floor();
    int yGridLocation = state.remainder(cols);

    double newXLocation = xGridLocation * xStep;
    double newYLocation = yGridLocation * yStep;
    
    return [newXLocation, newYLocation];
  }

  Future<void> runAnimation() async {
    for(int state in agentPath){
      await Future.delayed(const Duration(seconds: 2), (){
        List<double> newLocation = calculateNewLocation(state);
        double newLocationX = newLocation[1];
        double newLocationY = newLocation[0];
        setState(() {
          currentY = newLocationY;
          currentX = newLocationX;
        });
      }
      );
    }
  }

  @override
  Widget build(BuildContext context){
    setStepDistance();
    return Column(
      children: [
        Stack(children: [
          Container(
            height: maze_config.animationGridHeight,
            width: maze_config.animationGridWidth,
            color: Colors.black.withOpacity(0.3),
          ),
          AnimatedPositioned(
              left: currentX,
              top: currentY,
              duration: const Duration(seconds: 2),
              child: CustomPaint(
                  painter: AgentBody(),
                  size: Size(maze_config.agentDrawWidth, maze_config.animationGridHeight)
              )
          )
        ]
        ),
        // ElevatedButton(onPressed: () {runAnimation();},
        //     child: const Text("Start Animation"))
      ],
    );
  }
}