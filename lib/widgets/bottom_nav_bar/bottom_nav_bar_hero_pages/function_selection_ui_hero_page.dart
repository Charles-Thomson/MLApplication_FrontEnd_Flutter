import 'package:flutter/material.dart';
import 'package:ann_app/widgets/navigation_widgets/function_selection_custom_scrollable.dart';


class FunctionSelectionUIHero extends StatefulWidget{
  const FunctionSelectionUIHero({super.key, required this.updateConfigData, required this.heroTag});

  final Function(String, String) updateConfigData;
  final String heroTag;

  @override
  State<FunctionSelectionUIHero> createState() => _FunctionSelectionUIHero();

}

class _FunctionSelectionUIHero extends State<FunctionSelectionUIHero>{
  get updateConfigData => widget.updateConfigData;

  @override
  Widget build(BuildContext context) {
    MaterialColor themePrimary = Theme.of(context).primaryColor as MaterialColor;
    return Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 100, 5, 60),
            child: Hero(
                tag: widget.heroTag,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScrollAbleFunctionSelection(updateConfigData: updateConfigData,),
                ))));
  }
}