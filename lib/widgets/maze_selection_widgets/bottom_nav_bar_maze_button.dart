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
  late String? currentSelectedStateValue;
  late String? currentSelectedMazeSizeValue;
  final String configKey = "";
  final List<String> numberOfStateOptions = ["Select number of states","3x3", "4x4", "5x5", "6x6", "7x7", "8x8", "9x9", "10x10"];
  final List<String> mazSizeOptions = ["Select a Maze size","100x100", "200x200", "300x300", "400x400", "500x500", "600x600"];


  double tileGridHeight = 100;
  double tileGridWidth = 100;
  int mapDimensionAsStates = 4;

  @override
  void initState(){
    super.initState();
    currentSelectedStateValue = numberOfStateOptions[0];
    currentSelectedMazeSizeValue = mazSizeOptions[0];

  }

  void changeMapSize(){

    setState(() {
      tileGridWidth = 300;
      tileGridHeight = 300;
      mapDimensionAsStates = 7;
    });
  }

  @override
  Widget build(BuildContext context) {
    int  totalMapStates = mapDimensionAsStates * mapDimensionAsStates;
    List<Widget> mapRepresentation = List.generate(totalMapStates.toInt(), (index){
      return Container(
        decoration:  BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.4),
          border: Border.all(
            width: 1,
            color: Colors.black
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      );
    });

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
                child: Center(
                  child:Material(
                    color: Colors.white.withOpacity(0.2),
                    child: SizedBox(
                      height: 540,
                      width: 340,
                        child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          const Text("Map Selection",
                              style: TextStyle(fontSize: 20)
                          ),
                          const SizedBox(
                            height: 20
                          ),
                          Container(
                            height: 300,
                            width: 300,
                            color: Colors.blue.withOpacity(0.2),
                            child: Center(
                              child: Container(
                                color: Colors.red.withOpacity(0.2),
                                height: tileGridHeight,
                                width: tileGridWidth,
                                child: GridView.count(
                                  padding: EdgeInsets.zero,
                                    crossAxisCount: mapDimensionAsStates,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  children: mapRepresentation
                                ),
                              ),
                            ),
                          ),
                              SizedBox(
                                height: 70,
                                width: 200,
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                    errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                    hintText: 'Testing hint text',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                  isEmpty: currentSelectedStateValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: currentSelectedStateValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          currentSelectedStateValue = newValue;
                                        });
                                      },
                                      isDense: true,
                                      items: numberOfStateOptions.map((String value){
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value));
                                      }).toList(),
                                    ),
                                  ),
                                  ),
                              ),

                              SizedBox(
                                height: 100,
                                width: 200,
                                child: InputDecorator(
                                  decoration: InputDecoration(

                                      labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                      errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                      hintText: 'Testing hint text',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                  isEmpty: currentSelectedMazeSizeValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: currentSelectedMazeSizeValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          currentSelectedMazeSizeValue = newValue;
                                        });
                                      },
                                      isDense: true,
                                      items: mazSizeOptions.map((String value){
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value));
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),

                              // ElevatedButton(onPressed: () {changeMapSize();} , child: const Text("Change size"))
                        ])
                    ),
                  )
                )
          )
      ),
    ));
  }
}





