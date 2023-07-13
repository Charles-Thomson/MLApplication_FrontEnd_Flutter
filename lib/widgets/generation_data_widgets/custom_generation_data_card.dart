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
        color: Theme.of(context).primaryColor.withOpacity(0.2),
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
                                    selectedAnimationPath = animationPaths[index];
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
                        print("SYSTEM - ANIMATION: Card $cardIndex - Path: $selectedAnimationPath");
                        widget.runAnimationCallBack(selectedAnimationPath);
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