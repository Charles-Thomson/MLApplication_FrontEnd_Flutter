import 'package:flutter/material.dart';

class FunctionSelectionNavBar extends StatelessWidget{
  const FunctionSelectionNavBar({super.key, required this.changeVisableCardCallBack});

  final Function(String) changeVisableCardCallBack;
  @override
  Widget build(BuildContext context){
    return Material(
      color: Colors.blue.withOpacity(0),
      child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 110,
              child: TextButton.icon(
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed:
                changeVisableCardCallBack("WeightCard") , icon: Column(
                children: const [
                  Icon(
                    Icons.balance_outlined,
                    color: Colors.black,
                    size: 30
                  ),
                  Text("Weight\n Heuristic",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12)
                  )
                ]
              ),
                label: const Text("",//''),
              ),
            ),
            ),

            SizedBox(
              width: 110,
              child: TextButton.icon(
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {}, icon: Column(
                  children: const [
                    Icon(
                        Icons.functions_sharp,
                        color: Colors.black,
                        size: 30
                    ),
                    Text("Activation\n Functions",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12)
                    )
                  ]
              ),
                label: const Text("",//''),
                ),
              ),
            ),

            SizedBox(
              width: 110,
              child: TextButton.icon(
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {}, icon: Column(
                  children: const [
                    Icon(
                        Icons.mediation_rounded,
                        color: Colors.black,
                        size: 30
                    ),
                    Text("Generation \n Concatenation",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12)
                    )
                  ]
              ),
                label: const Text("",//''),
                ),
              ),
            ),

          ]
      )

    );
  }
}