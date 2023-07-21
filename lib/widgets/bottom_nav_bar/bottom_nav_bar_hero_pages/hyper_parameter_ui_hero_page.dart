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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, kBottomNavigationBarHeight),
        child: Hero(
          tag: widget.heroTag,
          child: ScrollAbleParameterSelection(updateConfigData: updateConfigData),
        ),
      ),
    );
  }
}