import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget{
  const CustomFloatingButton({super.key, required this.loadingValue, required this.floatingActionButtonLocationHandling});

  final double loadingValue;
  final Function floatingActionButtonLocationHandling;


  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButton();
}

class _CustomFloatingButton extends State<CustomFloatingButton>{

  Color buttonColor = Colors.white;

  void checkBttnColor(){
    if(widget.loadingValue > 0.9){
      buttonColor = Colors.blue.withOpacity(0.5);
    }
  }
  @override
  Widget build(BuildContext context){
    checkBttnColor();
    return FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {widget.floatingActionButtonLocationHandling();},
      child: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CircularProgressIndicator(
                    color: Colors.blue,
                    value: widget.loadingValue
                ),
              ),
            ),
            const Center(
               child: Icon(
                      Icons.start,
                 color: Colors.blue,

               ),
             )

          ]


        ),
      )

    );
  }
}