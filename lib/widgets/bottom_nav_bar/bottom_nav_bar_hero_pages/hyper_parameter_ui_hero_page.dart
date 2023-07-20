import 'package:flutter/material.dart';

import 'package:ann_app/widgets/navigation_widgets/hyper_parameter_selection_custom_scrollable.dart';

class HyperParameterSelectionUIHero extends StatefulWidget{
  const HyperParameterSelectionUIHero({super.key, required this.updateConfigData, required this.heroTag});

  final Function(String, String) updateConfigData;
  final String heroTag;

  @override
  State<HyperParameterSelectionUIHero> createState() => _HyperParameterSelectionUIHero();
}

class _HyperParameterSelectionUIHero extends State<HyperParameterSelectionUIHero>{

  get updateConfigData => widget.updateConfigData;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 60),
          child: Hero(
            tag: widget.heroTag,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollAbleParameterSelection(updateConfigData: updateConfigData),
            ),
          ),
        )
    );
  }
}