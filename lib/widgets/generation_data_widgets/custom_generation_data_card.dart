import 'package:flutter/material.dart';

class GenerationDataCard extends StatefulWidget{
  const GenerationDataCard({super.key, required this.index});
  final int index;
  @override
  State<GenerationDataCard> createState() => _GenerationDataCard();

}

class _GenerationDataCard extends State<GenerationDataCard>{
  int? selectedValue = 0;
  get cardIndex => widget.index;

  @override
  Widget build(BuildContext context){
    return Card( // turning into a custom card
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        elevation: 0,
        child: SizedBox(
          width: 300,
          height: 180,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex:2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Generation $cardIndex",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                          )
                      ),
                      const Text("Successful: true",
                        style: TextStyle(
                            fontSize: 14
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
                          const Text("Fitness", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Highest: ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text("Lowest: ",
                                  style: TextStyle(fontSize: 14),
                                )

                              ])
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const Text("Path",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          Column(children: const <Widget>[
                            Text("Shortest path:  ", style: TextStyle(fontSize: 14),),

                            Text("Longest path:  ", style: TextStyle(fontSize: 14),)

                          ]),
                        ],
                      ),
                    ),

                  ]
                  ),
                ),

                const Expanded(
                  flex:1,
                    child: Text("Select An Animation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),

                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Wrap(
                          spacing: 5,
                          children: List<Widget>.generate(3, (int index){
                            return ChoiceChip(
                              label: Text("Item $index"),
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
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () {print("SYSTEM - ANIMATION: Card $cardIndex - animation $selectedValue");}, child: const Text("Run Selected Animation")),
                    ],
                  ),
                )
              ]
          ),
        )
    );

  }
}