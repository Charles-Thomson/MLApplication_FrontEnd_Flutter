import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget{
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context){
    
    return Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   const [
              SizedBox(
                  height: 40,
                  child: Material(
                    child: Text(
                        style: TextStyle(fontSize: 20)
                        ,"INFO CARD"),
                  )
              ),
              SizedBox(
                  height: 10
              ),
              SizedBox(
                height: 100,
                width: 300,
                // child: DropDownMenu(updateConfigData, menuItems, configKey)
              )
            ]
        )
    );
  }
}