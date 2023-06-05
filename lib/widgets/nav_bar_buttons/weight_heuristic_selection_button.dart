import 'package:flutter/material.dart';


class HeuristicSelectionButton extends StatefulWidget{
  const HeuristicSelectionButton({super.key});

  @override
  State<HeuristicSelectionButton> createState() => _HeuristicSelectionButton();

}

enum SampleItem { itemOne, itemTwo, itemThree }

class _HeuristicSelectionButton extends State<HeuristicSelectionButton>{
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context){
    return PopupMenuButton(
        initialValue: selectedMenu,
        onSelected: (SampleItem item) {
          setState(() {
            selectedMenu = item;
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.abc))
          ),

          const PopupMenuItem<SampleItem>(
              value: SampleItem.itemTwo,
              child: Text("Test 2")),

          const PopupMenuItem<SampleItem>(
              value: SampleItem.itemThree,
              child: Text("Test 3")),

        ]
    );
  }
}