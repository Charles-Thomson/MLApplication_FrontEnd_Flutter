import 'package:flutter/material.dart';
import 'package:ann_app/widgets/nav_bar_buttons/hero_route.dart';

const String _parameterpopouttag = "parameter-pop-out";

class ParameterSettingsButton extends StatelessWidget{
  const ParameterSettingsButton({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return ParameterSettingsPopOut(updateConfigData: updateConfigData);
            }
            )
            );
          },

          child: Hero(
              tag: _parameterpopouttag,
              child: Material(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child: const Icon(
                      Icons.data_object,
                      size: 40,
                      color: Colors.white
                  )
              )
          ),
        )
    );
  }
}

class ParameterSettingsPopOut extends StatefulWidget{
  const ParameterSettingsPopOut({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;



  @override
  State<ParameterSettingsPopOut> createState() => _ParameterSettingsPopOut();

}

class _ParameterSettingsPopOut extends State<ParameterSettingsPopOut>{

  get updateConfigData => widget.updateConfigData;
  final _formKey = GlobalKey<FormState>();


  final maxGenerationSizeController = TextEditingController();
  final startingFitnessThresholdController  = TextEditingController();
  final desiredFitGenerationSizeController = TextEditingController();
  final maxEpisodeDurationController = TextEditingController();
  final numberOfGenerationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Hero(
              tag: _parameterpopouttag,
              child: Container(
                  height: 600,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueGrey.shade700,
                        Colors.blueGrey.shade500,
                        Colors.blueGrey.shade300,
                        Colors.blueGrey.shade300,
                        Colors.blueGrey.shade400,
                        Colors.blueGrey.shade700,
                      ],
                      stops: const [0.01, 0.1, 0.49, 0.51, 0.6, 1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    color: Colors.grey.withOpacity(0.6),
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                        blurStyle: BlurStyle.solid
                    )],
                  ),

                  child: Center(child:
                  Container(
                      height: 560,
                      width: 340,
                      color: Colors.white.withOpacity(0.7),
                      child:
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children:    [
                            SizedBox(
                                height: 30,
                                child: Material(
                                  color: Colors.white.withOpacity(0),
                                  child: const Text(
                                      style: TextStyle(fontSize: 20)
                                      ,"PARAMETER SELECTION "),
                                )
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Center(
                                child: Form(
                                  key: _formKey,

                                  child: Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: maxGenerationSizeController,
                                          decoration: const InputDecoration(
                                            labelText: "Max Generation Size"
                                          ),
                                          validator: (maxGenerationSizeInputValue){
                                            if (maxGenerationSizeInputValue == null || maxGenerationSizeInputValue.isEmpty){
                                              return 'Please enter value';
                                            }
                                            return null;
                                          }
                                        ),
                                        TextFormField(
                                          controller: numberOfGenerationsController,
                                            decoration: const InputDecoration(
                                                labelText: "Number of Generations"
                                            ),
                                            validator: (numberOfGenerationsInputValue){
                                              if (numberOfGenerationsInputValue == null || numberOfGenerationsInputValue.isEmpty){
                                                return 'Please enter value';
                                              }
                                              return null;
                                            }
                                        ),

                                        TextFormField(
                                          controller: maxEpisodeDurationController,
                                            decoration: const InputDecoration(
                                                labelText: "Max* Episode duration"
                                            ),
                                            validator: (maxEpisodeDurationInputValue ){
                                              if (maxEpisodeDurationInputValue == null || maxEpisodeDurationInputValue.isEmpty){
                                                return 'Please enter value';
                                              }
                                              return null;
                                            }
                                        ),
                                        TextFormField(
                                          controller: desiredFitGenerationSizeController,
                                            decoration: const InputDecoration(
                                                labelText: "Desired Fit Generation Size"
                                            ),
                                            validator: (desiredFitGenerationSizeInputValue){
                                              if (desiredFitGenerationSizeInputValue == null || desiredFitGenerationSizeInputValue.isEmpty){
                                                return 'Please enter value';
                                              }
                                              return null;
                                            }
                                        ),

                                        TextFormField(
                                          controller: startingFitnessThresholdController,
                                            decoration: const InputDecoration(
                                                labelText: "Starting Fitness Threshold"
                                            ),
                                            validator: (startingFitnessThresholdInputValue){
                                              if (startingFitnessThresholdInputValue == null || startingFitnessThresholdInputValue.isEmpty){
                                                return 'Please enter value';
                                              }
                                              return null;
                                            }
                                        ),
                                         Center(
                                          child: ElevatedButton(onPressed: (){
                                            if(_formKey.currentState!.validate()) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text("DOING WORK")),
                                              );
                                              updateConfigData("MAX_GENERATION_SIZE",maxGenerationSizeController.text);
                                              updateConfigData("STARTING_FITNESS_THRESHOLD",startingFitnessThresholdController.text);
                                              updateConfigData("DESIRED_FIT_GENERATION_SIZE",desiredFitGenerationSizeController.text);
                                              updateConfigData("MAX_EPISODE_DURATION",maxEpisodeDurationController.text);
                                              updateConfigData("NUMBER_OF_GENERATIONS",numberOfGenerationsController.text);

                                            }
                                          },
                                              child: const Text("Submit ")
                                          )
                                        )
                                      ]
                                    ),
                                  )

                                ),
                              ),
                            )


                          ]
                      )
                  )
                  ))
          )
      ),
    );
  }
}


