import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget{
  const CustomFloatingButton({super.key, required this.loadingValue, required this.updateFloatingActionButtonStateCallBack, required this.floatingActionButtonState, required this.resetAllCallBack, required this.apiSubmissionCallBack});

  final double loadingValue;
  final int floatingActionButtonState;

  final Function() updateFloatingActionButtonStateCallBack;
  final Function() resetAllCallBack;
  final Function() apiSubmissionCallBack;

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

    AlertDialog submissionDialog = AlertDialog(
      title: const Text("Start Environment"),
      content: const Text('This wil start the environment'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context, 'Cancel');
          print("Closing alert");
        },
            child: const Text("Close")),

        TextButton(onPressed: (){
          widget.updateFloatingActionButtonStateCallBack();
          widget.apiSubmissionCallBack();
          Navigator.pop(context, 'OK');
          print("Start");
          },
            child: const Text("Accept"))
      ],

    );

    AlertDialog resetDialog = AlertDialog(
      title: const Text("Rest Environment ?"),
      content: const Text('his will fully reset the environment'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context, 'Cancel');
          print("Closing alert");
        },
            child: const Text("Close")),
        TextButton(onPressed: (){
          widget.resetAllCallBack();
          Navigator.pop(context, 'OK');
          print("Reset Environment");},
            child: const Text("Accept"))
      ],
    );

    return FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {showDialog<String>(
            context: context,
            builder: (BuildContext context) => widget.floatingActionButtonState == 1 ? resetDialog : submissionDialog);
          },
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
                   widget.floatingActionButtonState == 1 ? Icons.restart_alt_sharp : Icons.start ,
                 color: iconColor

               ),
             )

          ]


        ),
      )

    );
  }
}