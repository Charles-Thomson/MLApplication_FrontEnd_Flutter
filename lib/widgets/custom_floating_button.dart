import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget{
  const CustomFloatingButton({super.key});

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButton();
}

class _CustomFloatingButton extends State<CustomFloatingButton>{

  double loadingValue = 0.0;

  void updateValue(){
    setState(() {
      loadingValue += 0.1;
    });

  }
  @override
  Widget build(BuildContext context){
    return FloatingActionButton(

        backgroundColor: loadingValue > 0.9 ? Colors.blue : Colors.white,
        onPressed: () {updateValue();},
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Center(
          child: Stack(
            children: <Widget>[
              CircularProgressIndicator(
                  color: Colors.blue,
                  value: loadingValue
              ),
               const Icon(
                      Icons.start)

            ]


          ),
        )
      )

    );
  }
}