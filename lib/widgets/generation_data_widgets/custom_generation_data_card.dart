import 'package:flutter/material.dart';

class GenerationDataCard extends StatefulWidget{
  const GenerationDataCard({super.key, required this.index, required this.generationData, required this.runAnimationCallBack, required this.payloadData});
  final int index;
  final Map generationData;
  final Function(List<int>) runAnimationCallBack;
  final List payloadData;
  @override
  State<GenerationDataCard> createState() => _GenerationDataCard();

}

class _GenerationDataCard extends State<GenerationDataCard>{
  int? selectedValue = 0;
  get cardIndex => widget.index;

  get highestFitness => widget.payloadData[0].toStringAsFixed(2);
  get highestFitnessPath => widget.payloadData[1];
  get lowestFitness => widget.payloadData[2].toStringAsFixed(2);
  get lowestFitnessPath => widget.payloadData[3];

  get thisAnimationPath => widget.payloadData[1].cast<int>(); // currently just showing highest fitness path

  // get shortestPath => widget.generationData["shortest_path"];
  // get longestPath => widget.generationData["longest_path"];
  // get lowestFitness => widget.generationData["lowest_fitness"];
  // get highestFitness => widget.generationData["total_fitness"];
  // get animationPath => widget.generationData["path"];
  // get thisAnimationPath => animationPath.map((item) => item.toInt()).cast<int>().toList();

  List<String> chipTitles = ["Shortest", "Longest","Fittest", "Un-Fittest"];


  @override
  Widget build(BuildContext context){
    return Card(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        elevation: 0,
        child: SizedBox(
          width: 300,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex:2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text("Generation $cardIndex",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                            )
                        ),
                      ),

                      const Expanded(
                        child:  Text("Successful: true",
                          style: TextStyle(
                              fontSize: 14
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Row( children: <Widget>[

                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: Text("Fitness", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  Expanded(
                                    child: Text("Highest: $highestFitness",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text("Lowest: $lowestFitness",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  )

                                ]),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const Expanded(
                            child:  Text("Path",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          ),
                          Expanded(
                            child: Column(children:  const <Widget>[
                              Expanded(child: Text("Shortest path:  holder", style: TextStyle(fontSize: 14),)),

                              Expanded(child: Text("Longest path:  holder", style: TextStyle(fontSize: 14),))

                            ]),
                          ),
                        ],
                      ),
                    ),

                  ]
                  ),
                ),

                const Expanded(
                  flex:1,
                    child: Text("Select A Path", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),

                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Expanded(
                        child: Wrap(
                            spacing: 5,
                            children: List<Widget>.generate(chipTitles.length, (int index){
                              return ChoiceChip(
                                label: Text(chipTitles[index]),
                                avatar: CircleAvatar(
                                    child: Icon(selectedValue == index ? Icons.check : Icons.circle)
                                ),
                                selected: selectedValue == index,
                                onSelected: (bool selected){
                                  setState(() {
                                    selectedValue = selected ? index : null;
                                  });
                                },
                              );
                            }
                            ).toList()
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      ElevatedButton(onPressed: () {
                        print("SYSTEM - ANIMATION: Card $cardIndex - Path: $thisAnimationPath");
                        widget.runAnimationCallBack(thisAnimationPath);

                        }, child: const Text("Run Selected Animation")),
                    ],
                  ),
                )
              ]
          ),
        )
    );
  }
}