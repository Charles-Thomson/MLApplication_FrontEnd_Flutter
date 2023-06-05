import 'package:flutter/material.dart';

class ActivationFunctionSelectionButton extends StatefulWidget{
  const ActivationFunctionSelectionButton({super.key});

  @override
  State<ActivationFunctionSelectionButton> createState() => _ActivationFunctionSelectionButton();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _ActivationFunctionSelectionButton extends State<ActivationFunctionSelectionButton>{
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

