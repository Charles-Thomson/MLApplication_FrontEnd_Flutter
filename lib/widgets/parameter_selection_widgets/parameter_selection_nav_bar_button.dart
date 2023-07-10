

import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';
import 'package:ann_app/widgets/parameter_selection_widgets/scrollable_selection.dart';

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

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 60),
          child: Hero(
              tag: _parameterpopouttag,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ScrollAbleParameterSelection(updateConfigData: updateConfigData),
                          ),
                        ),
          )
    );
  }
}


