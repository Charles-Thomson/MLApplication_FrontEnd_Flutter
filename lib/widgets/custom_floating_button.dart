import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget{
  const CustomFloatingButton({super.key, required this.loadingValue});

  final double loadingValue;


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
        onPressed: () {},
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