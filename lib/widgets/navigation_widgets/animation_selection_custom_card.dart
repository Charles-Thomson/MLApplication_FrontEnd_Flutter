import 'package:flutter/material.dart';

class GenerationDataCard extends StatefulWidget{
  const GenerationDataCard({super.key, required this.index, required this.runAnimationCallBack, required this.payloadData});
  final int index;

  final Function(List<int>) runAnimationCallBack;
  final List payloadData;
  @override
  State<GenerationDataCard> createState() => _GenerationDataCard();

}

class _GenerationDataCard extends State<GenerationDataCard>{
  int? selectedValue = 0;
  late List<int> selectedAnimationPath;
  late List<List> animationPaths;
  get cardIndex => widget.index;

  get highestFitness => widget.payloadData[0].toStringAsFixed(2);
  get highestFitnessPath => widget.payloadData[1].cast<int>();
  get lowestFitness => widget.payloadData[3].toStringAsFixed(2);
  get lowestFitnessPath => widget.payloadData[4];
  get gradientValue => double.parse(highestFitness) / 10;

  List<String> chipTitles = ["Fittest"]; // add additional chips here
  @override
  void initState(){
    super.initState();
    selectedAnimationPath = highestFitnessPath; // Hard coding a default
    animationPaths = [highestFitnessPath];
  }

  @override
  Widget build(BuildContext context){
    List animationPaths = [highestFitnessPath];
    return Card(
        color: Colors.white,
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            // Leaving the border on for now
            border: Border.all(
              width: 1,
              style: BorderStyle.solid
            ),

            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Colors.blue.shade800,
                Colors.blue.shade100,
              ],
              stops: [0.0, gradientValue]

            )
          ),
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Generation $cardIndex",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Highest Fitness: $highestFitness",
                            style: const TextStyle(
                                fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Path: $highestFitnessPath",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )

                  ],
                ),
              ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                  print("SYSTEM - ANIMATION: Card $cardIndex - Path: $selectedAnimationPath");
                 widget.runAnimationCallBack(selectedAnimationPath); },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.red)
                            )
                        )
                    ),

                    child: Row(
                      children: const [
                        Text("Run"),
                        Icon(Icons.play_arrow_sharp)
                      ],
                    )),
              ),
            )
            ],
          ),
        )
    );
  }
}