import 'package:flutter/material.dart';
import 'package:ann_app/widgets/nav_bar_buttons/hero_route.dart';

const String _mappopouttag = "map-pop-out";

class MazeSettingsButton extends StatelessWidget{
  const MazeSettingsButton({super.key, required this.updateConfigData});
  final Function(String, String) updateConfigData;

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return MapSettingsButtonPopOut(updateConfigData: updateConfigData);
            }
            )
            );
          },

          child: Hero(
              tag: _mappopouttag,
              child: Material(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child: const Icon(
                      Icons.map_outlined,
                      size: 40,
                      color: Colors.white
                  )
              )
          ),
        )
    );
  }
}

class MapSettingsButtonPopOut extends StatefulWidget{
  const MapSettingsButtonPopOut({super.key, required this.updateConfigData});

  final Function(String, String) updateConfigData;

  @override
  State<MapSettingsButtonPopOut> createState() => _MapSettingsButtonPopOut();

}

class _MapSettingsButtonPopOut extends State<MapSettingsButtonPopOut>{


  @override
  Widget build(BuildContext context) {



    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Hero(
              tag: _mappopouttag,
              child: Container(
                  height: 600,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueGrey.shade700,
                        Colors.blueGrey.shade500,
                        Colors.blueGrey.shade300,
                        Colors.blueGrey.shade300,
                        Colors.blueGrey.shade400,
                        Colors.blueGrey.shade700,
                      ],
                      stops: const [0.01, 0.1, 0.49, 0.51, 0.6, 1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    color: Colors.grey.withOpacity(0.6),
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                        blurStyle: BlurStyle.solid
                    )],
                  ),


          )
      ),
    ));
  }
}





