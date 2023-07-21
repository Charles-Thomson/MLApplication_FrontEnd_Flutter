import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;

class MapConfigurationUIHero extends StatefulWidget{
  const MapConfigurationUIHero({super.key, required this.updateMazeMap, required this.heroTag});

  final Function(Map<String, String>) updateMazeMap;

  final String heroTag;

  @override
  State<MapConfigurationUIHero> createState() => _MapConfigurationUIHero();

}

class _MapConfigurationUIHero extends State<MapConfigurationUIHero>{
  final List<int> numberOfStateOptions = [3, 4, 5, 6, 7, 8, 9, 10];
  final List<double> tileSizeOptions = [30, 35, 40, 45, 50, 55, 60];


  late double tileSize;
  late int numberOfStatesX;
  late int numberOfStatesY;
  late double tileGridHeight;
  late double tileGridWidth;

  late Map<String, String > newMapData;

  late List<Widget> mapRepresentation;

  @override
  void initState() {
    super.initState();
    tileSize = maze_config.tileSize;

    numberOfStatesY = maze_config.totalXStates;
    numberOfStatesX = maze_config.totalYStates;

    newMapData = {
      "mazeSizeX": "",
      "mazeSizeY": "",
      "tileSize": "",
    };
    tileGridHeight = (tileSize * numberOfStatesX) + 10;
    tileGridWidth = (tileSize * numberOfStatesY) + 10;

  }


  void buildNewMapData(){
    newMapData["mazeSizeX"] = numberOfStatesY.toString();
    newMapData["mazeSizeY"] = numberOfStatesX.toString();
    newMapData["tileSize"] = tileSize.toString();
  }

  void submitNewMapData(){
    buildNewMapData();
    widget.updateMazeMap(newMapData);
  }

  void updateTileSize(double newValue){
    setState(() {
      tileSize = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor themePrimary = Theme.of(context).primaryColor as MaterialColor;
    tileGridHeight = (tileSize  + 10) * numberOfStatesY;
    tileGridWidth = (tileSize + 10) * numberOfStatesX;

    int  totalMapStates = numberOfStatesX * numberOfStatesY;
    mapRepresentation = List.generate(totalMapStates.toInt(), (index){
      return Container(
        height: tileSize,
        width: tileSize,
        decoration:  BoxDecoration(
          color: themePrimary.withOpacity(0.8),
          border: Border.all(
              width: 1,
              color: themePrimary.shade900
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      );
    });

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, kBottomNavigationBarHeight),
        child: SingleChildScrollView(
          child: Hero(
              tag: widget.heroTag,
              child: Material(
                color: Colors.transparent,
                child: Container(

                    height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              flex: 1,
                              child: Text("Map Configuration",
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                              ),
                            ),

                            Expanded(
                              flex: 12,
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      height: tileGridHeight ,
                                      width: tileGridWidth ,
                                      child: GridView.count(
                                          padding: EdgeInsets.zero,
                                          crossAxisCount: numberOfStatesX,
                                          crossAxisSpacing: 2,
                                          mainAxisSpacing: 2,
                                          children: mapRepresentation
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex:2,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Expanded(
                                        flex: 1,
                                        child:  Text("No* of States: ",
                                            style: TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InputDecorator(
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                              errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                          isEmpty: numberOfStatesY == 0,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              isExpanded: true,
                                              value: numberOfStatesY,
                                              onChanged: (int? newValue) {
                                                setState(() {
                                                  numberOfStatesY = newValue!;
                                                });
                                              },
                                              isDense: true,
                                              items: numberOfStateOptions.map((int value){
                                                return DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text(value.toString()));
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InputDecorator(
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                              errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                          isEmpty: numberOfStatesX == 0,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              isExpanded: true,
                                              value: numberOfStatesX,
                                              onChanged: (int? newValue) {
                                                setState(() {
                                                  numberOfStatesX = newValue!;
                                                });
                                              },
                                              isDense: true,
                                              items: numberOfStateOptions.map((int value){
                                                return DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text(value.toString()));
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                  ]),
                            ),



                            
                            Expanded(
                              flex: 2,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const Expanded(

                                        child:  Text("Tile Size : ",
                                        style: TextStyle( fontWeight: FontWeight.bold)
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InputDecorator(
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                              errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),

                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                          isEmpty: tileSize == 0,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<double>(
                                              isExpanded: true,
                                              value: tileSize,
                                              onChanged: (double? newValue) {
                                                updateTileSize(newValue!);
                                              },
                                              isDense: true,
                                              items: tileSizeOptions.map((double value){
                                                return DropdownMenuItem<double>(
                                                    value: value,
                                                    child: Text(value.toString()));
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ]),
                            ),

                            const Expanded(
                                child: SizedBox(
                                    height: 5
                                )

                            ),


                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                    height: 10,
                                    width: 100 ,
                                    child: ElevatedButton(onPressed: () {submitNewMapData();} , child: const Text("Submit")))),

                            const Expanded(
                              child: SizedBox(
                                height: 5
                              )

                            )

                          ]),
                    )
                ),
              )
          ),
        ),
      ),
    );
  }
}





