import 'package:flutter/material.dart';

class ActivationFunctionsLandingCard extends StatelessWidget{
  const ActivationFunctionsLandingCard({super.key});

  @override
  Widget build(BuildContext context){
    return Container(

        color: Colors.white,
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   const [
              SizedBox(
                  height: 40,
                  child: Material(
                    child: Text(
                        style: TextStyle(fontSize: 20)
                        ,"ActivationFunctionsLandingCard"),
                  )
              ),
              SizedBox(
                  height: 10
              ),

            ]
        )
    );
  }
}