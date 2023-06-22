import 'package:flutter/material.dart';
import 'package:ann_app/widgets/agent/agent_body.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;

class AgentAnimation extends StatefulWidget{
  AgentAnimation({super.key,required this.agentAnimationLocation});


  final int agentAnimationLocation;

  @override
  State<AgentAnimation> createState() => _AgentAnimation();

}

class _AgentAnimation extends State<AgentAnimation>{

  final int totalXStates = maze_config.totalYStates;
  final int totalYStates = maze_config.totalXStates;


  final double animationGridWidth = maze_config.tileGridHeight;
  final double animationGridHeight = maze_config.tileGridWidth;

  late double currentX;
  late double currentY;

  late double xStepDistance = 0 ;
  late double yStepDistance = 0 ;

  @override
  void initState(){
    super.initState();
    xStepDistance = animationGridHeight / totalXStates;
    yStepDistance = animationGridWidth / totalYStates;

  }

  List<double> calculateNewLocation(int state){
    print("State received in calculate new location $state");
    int xGridLocation = (state / totalXStates).floor();
    int yGridLocation = state.remainder(totalXStates);

    double newXLocation = xGridLocation * xStepDistance;
    double newYLocation = yGridLocation * yStepDistance;
    
    return [newXLocation, newYLocation];
  }

  // Future<void> runAnimation() async {
  //   List<int> agentPath = widget.animationPath;
  //   for(int state in agentPath){
  //     print(state);
  //     await Future.delayed(const Duration(seconds: 2), (){
  //       List<double> newLocation = calculateNewLocation(state);
  //       double newLocationX = newLocation[1];
  //       double newLocationY = newLocation[0];
  //       setState(() {
  //         currentY = newLocationY;
  //         currentX = newLocationX;
  //       });
  //     }
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context){
    List<double> newLocation = calculateNewLocation(widget.agentAnimationLocation);
    currentX = newLocation[1];
    currentY = newLocation[0];
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
      ],
    );
  }
}