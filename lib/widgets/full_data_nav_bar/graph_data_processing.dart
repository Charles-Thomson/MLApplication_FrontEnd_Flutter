import 'dart:convert';

void processJsonData(var dataSet){
  var data = json.decode(dataSet);

  int numberOfGenerations = int.parse(data["number_of_generations"]);
  int maxSteps = int.parse(data["max_steps"]);
  double maxFitness = double.parse(data["max_fitness"]);

  var payloadData = data["payloadData"];
  List<List<double>> graphPlotPoints = [];

  // this works
  for(int i = 0; i < numberOfGenerations; i++){

    // Current cast issue as it comes out of the payload as dynamic
    // need double
    // can take as dynamic and cast later
    var thisPlotPoints = payloadData["gen_$i"]["fitness_by_step"];
    print(thisPlotPoints.runtimeType);
    //graphPlotPoints.add(thisPlotPoints);
  }
  print(graphPlotPoints);


}



// TODO: Looking to convert the Json data into this format

// LineChartBarData get lineChartBarData1_1 => LineChartBarData(
//   curveSmoothness: 0.1,
//   isCurved: true,
//   color: Colors.white,
//   barWidth: 8,
//   isStrokeCapRound: true,
//   dotData:  FlDotData(show: false),
//   belowBarData: BarAreaData(show: false),
//   spots: const [
//     FlSpot(1, 6),
//     FlSpot(3, 1.5),
//     FlSpot(5, 1.4),
//     FlSpot(7, 3.4),
//     FlSpot(10, 2),
//     FlSpot(12, 2.2),
//     FlSpot(13, 1.8),
//   ],
// );