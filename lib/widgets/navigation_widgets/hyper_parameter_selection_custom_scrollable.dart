import 'package:flutter/material.dart';
import 'package:ann_app/widgets/navigation_widgets/hyper_parameter_selection_custom_scrollable_card_data.dart';

class ScrollAbleParameterSelection extends StatefulWidget{
  const ScrollAbleParameterSelection({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  @override
  State<ScrollAbleParameterSelection> createState() => _ScrollAbleParameterSelection();

}

class _ScrollAbleParameterSelection extends State<ScrollAbleParameterSelection>{
  get updateConfigData => widget.updateConfigData;

  Map dataSet = cardData;

  final maxGenerationSizeController = TextEditingController();
  final startingFitnessThresholdController  = TextEditingController();
  final desiredFitGenerationSizeController = TextEditingController();
  final maxEpisodeDurationController = TextEditingController();
  final numberOfGenerationsController = TextEditingController();

  @override
  Widget build(BuildContext context){
    List<TextEditingController> textControllers = [
      maxGenerationSizeController,
      startingFitnessThresholdController,
      desiredFitGenerationSizeController,
      maxEpisodeDurationController,
      numberOfGenerationsController
    ];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: const Text("Parameter Selection", style: TextStyle(fontSize: 24),),
          backgroundColor: Theme.of(context).primaryColor,
          floating: true,
          snap: true,
          toolbarHeight: 40,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index){
                var data = dataSet[index.toString()];
                String configKey = data["configKey"]!;
                return Card(
                  color: Colors.white.withOpacity(0.8),
                  elevation: 5,
                  borderOnForeground: false,
                  child: Column(
                    children: [
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data["title"], style:  TextStyle(
                      backgroundColor: Colors.blueGrey.withOpacity(0),
                      fontSize: 18
                  ),),
                ),
                      Padding(padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          onEditingComplete: () {updateConfigData(configKey,textControllers[index].text);},
                          controller: textControllers[index],
                          decoration: InputDecoration(
                            labelText: data["labelText"],
                          ),
                          validator: (maxGenerationSizeInputValue){
                            if (maxGenerationSizeInputValue == null || maxGenerationSizeInputValue.isEmpty){
                              return 'Please enter value';
                            }
                            return null;
                          }
                      )

                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data["associatedText"]!)
                      ),

                       Padding(padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {updateConfigData(configKey,textControllers[index].text);},
                        child: const Text("Submit")
                      )
                      )
                    ],
                  )
                );
              },
            childCount: textControllers.length
          ),
        )
      ]
    );

  }
}