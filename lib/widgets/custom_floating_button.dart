import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget{
  const CustomFloatingButton({super.key, required this.loadingValue, required this.floatingActionButtonLocationHandling});

  final double loadingValue;
  final Function floatingActionButtonLocationHandling;


  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButton();
}

class _CustomFloatingButton extends State<CustomFloatingButton>{

  late Color buttonColor;
  late Color iconColor;
  late Color progressIndicatorColor;

  @override
  void initState(){
    super.initState();
    buttonColor = Colors.white;
    progressIndicatorColor = Colors.blue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    iconColor = Theme.of(context).primaryColor;
  }

  void checkCurrentElementColors(){
    if(widget.loadingValue > 0.9){
        buttonColor = Theme.of(context).primaryColor;
        iconColor = Colors.white;
        progressIndicatorColor = Theme.of(context).primaryColor;
    }
  }
  @override
  Widget build(BuildContext context){
    checkCurrentElementColors();
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
                    color: progressIndicatorColor,
                    value: widget.loadingValue
                ),
              ),
            ),
             Center(
               child: Icon(
                      Icons.start,
                 color: iconColor

               ),
             )

          ]


        ),
      )

    );
  }
}