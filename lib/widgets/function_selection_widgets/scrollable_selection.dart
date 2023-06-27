import 'package:flutter/material.dart';
import 'package:ann_app/widgets/function_selection_widgets/card_data.dart';

import 'package:ann_app/widgets/dropdownselector.dart';
class ScrollAbleFunctionSelection extends StatefulWidget{
  const ScrollAbleFunctionSelection({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  @override
  State<ScrollAbleFunctionSelection> createState() => _ScrollAbleFunctionSelection();

  }

  class _ScrollAbleFunctionSelection extends State<ScrollAbleFunctionSelection>{
    get updateConfigData => widget.updateConfigData;

    var dataSet = cardData;

  @override
    Widget build(BuildContext context){


    MaterialColor themePrimary = Theme.of(context).primaryColor as MaterialColor;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,

          title: const Text("Function Selection", style: TextStyle(fontSize: 24),),
          backgroundColor: Theme.of(context).primaryColor,
          floating: true,
          snap: true,
          toolbarHeight: 40,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
              var data = dataSet[index.toString()];
              List<String> menuItems = data!["dropDownMenuItems"]!.split(",");
              String configKey = data!["configKey"]!;
              return Card(
                color: Colors.blueGrey.withOpacity(0.9),
                elevation: 5,
                borderOnForeground: false,
                child: Column(
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data!["title"]!, style:  TextStyle(
                        backgroundColor: Colors.blueGrey.withOpacity(0),
                        fontSize: 18
                      ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomDropDownMenu(updateConfigData, menuItems, configKey),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data!["associatedText"]!)
                    )

                  ]
                ),
              );
            },
            childCount: 4
          ),
        ),
      ],
    );


  }

  }