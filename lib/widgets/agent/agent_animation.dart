import 'package:flutter/material.dart';
import 'package:ann_app/widgets/agent/agent_body.dart';

class AgentAnimation extends StatefulWidget{
  const AgentAnimation({super.key});

  @override
  State<AgentAnimation> createState() => _AgentAnimation();

}

class _AgentAnimation extends State<AgentAnimation>{
  // will need to be passed
  final int nrow = 4;
  final int ncol = 4;

  // will need to be passed
  final double mazeX = 200;
  final double mazeY = 200;

  final List<int> agentPath = [0, 1 , 2, 3 ];
  int listIndex = 0;

  double currentX = 0;
  double currentY = 0;

  double xStep = 0 ;
  double yStep = 0 ;

  var locations = {};

  void setStepDistance(){
    xStep = mazeX / ncol;
    yStep = mazeY / nrow;
  }

  List<double> calculateNewLocation(int state){
    int xGridLocation = (state / ncol).floor();
    int yGridLocation = state.remainder(ncol);

    double newXLocation = xGridLocation * xStep;
    double newYLocation = yGridLocation * yStep;
    print(newXLocation);
    print(newYLocation);

    return [newXLocation, newYLocation];
  }


  @override
  Widget build(BuildContext context){
    setStepDistance();
    return Stack(children: [
      Container(
        height: 200,
        width: 200,
        color: Colors.black,
      ),
      AnimatedPositioned(
          left: currentX,
          top: currentY,
          duration: const Duration(seconds: 2),
          child: GestureDetector(
            onTap: (){
              setState(() {
                List newLocation = calculateNewLocation(agentPath[listIndex]);
                currentX = newLocation[1];
                currentY = newLocation[0];
                listIndex += 1;
              });
            },
            child: CustomPaint(
                painter: AgentBody(),
                size: const Size(40, 40)
            ),
          )
      )
    ]
    );
  }
}