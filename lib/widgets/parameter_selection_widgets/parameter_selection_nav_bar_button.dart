

import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';

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
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child:  Icon(
                      Icons.data_object,
                      size: 40,
                      color: Theme.of(context).primaryColor
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

  final List<String> textFormLabelTexts = [
    "Max Generation Size",
    "Number of Generations",
    "Max* Episode duration",
    "Desired Fit Generation Size",
    "Starting Fitness Threshold"
  ];

  final maxGenerationSizeController = TextEditingController();
  final startingFitnessThresholdController  = TextEditingController();
  final desiredFitGenerationSizeController = TextEditingController();
  final maxEpisodeDurationController = TextEditingController();
  final numberOfGenerationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MaterialColor themePrimary = Theme.of(context).primaryColor as MaterialColor;
    List<TextEditingController> textControllers = [
      maxGenerationSizeController,
      startingFitnessThresholdController,
      desiredFitGenerationSizeController,
      maxEpisodeDurationController,
      numberOfGenerationsController
    ];

    List builtTextFormFields = List<Widget>.generate(textControllers.length, (int index){
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(

              controller: textControllers[index],
              decoration: InputDecoration(
                labelText: textFormLabelTexts[index],
              ),
              validator: (maxGenerationSizeInputValue){
                if (maxGenerationSizeInputValue == null || maxGenerationSizeInputValue.isEmpty){
                  return 'Please enter value';
                }
                return null;
              }
            ),
      );
      }
    );

    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 60),
          child: Hero(
              tag: _parameterpopouttag,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0),
                    gradient: LinearGradient(
                      colors: [
                        themePrimary.shade700,
                        themePrimary.shade500,
                        themePrimary.shade300,
                        themePrimary.shade300,
                        themePrimary.shade400,
                        themePrimary.shade700,
                      ],
                      stops: const [0.01, 0.1, 0.49, 0.51, 0.6, 1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    color: themePrimary.withOpacity(0.6),
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                        blurStyle: BlurStyle.solid
                    )],
                  ),

                  child: Center(child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                        color: themePrimary.withOpacity(0.4),
                        child:
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                            children:    [
                              SizedBox(
                                  height: 40,
                                  child: Material(
                                    color: Colors.white.withOpacity(0),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          style: TextStyle(fontSize: 20)
                                          ,"PARAMETER SELECTION "),
                                    ),
                                  )
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                      child: Column(
                                        children:
                                        [
                                          ...builtTextFormFields,
                                        ]
                                      ),
                                    )
                                  ),
                                ),
                              ),

                              Center(
                                  child: ElevatedButton(onPressed: (){
                                    if(_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text("DOING WORK")),
                                      );
                                      // lazy but works - may find better solution
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
                        )
                    ),
                  )
                  ))
          )
      ),
    );
  }
}


