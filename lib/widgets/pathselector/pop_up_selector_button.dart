import 'package:flutter/material.dart';


class PopOutSelector extends StatelessWidget{
  const PopOutSelector({super.key});

  @override
  Widget build(BuildContext context){
    return RawMaterialButton(
        onPressed: () {},
        elevation: 2.0,
        fillColor: Colors.blue,
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.map_sharp,
          size: 35.0
        ),
    );
  }
}