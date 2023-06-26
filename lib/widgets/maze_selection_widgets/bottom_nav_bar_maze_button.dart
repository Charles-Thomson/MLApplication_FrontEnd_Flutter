import 'package:flutter/material.dart';
import 'package:ann_app/widgets/hero_route.dart';
import 'package:ann_app/widgets/maze_board/maze_board_config.dart' as maze_config;

const String _mappopouttag = "map-pop-out";

class MazeSettingsButton extends StatelessWidget{
  const MazeSettingsButton({super.key, required this.updateMazeMap});
  final Function(Map<String, String>) updateMazeMap;

  @override
  Widget build(BuildContext context){
    return  Padding(padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return MapSettingsButtonPopOut(updateMazeMap: updateMazeMap);
            }
            )
            );
          },

          child: Hero(
              tag: _mappopouttag,
              child: Material(

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  child:  Icon(
                      Icons.map_outlined,
                      size: 40,
                      color: Theme.of(context).primaryColor
                  )
              )
          ),
        )
    );
  }
}

class MapSettingsButtonPopOut extends StatefulWidget{
  const MapSettingsButtonPopOut({super.key, required this.updateMazeMap});

  final Function(Map<String, String>) updateMazeMap;

  @override
  State<MapSettingsButtonPopOut> createState() => _MapSettingsButtonPopOut();

}

class _MapSettingsButtonPopOut extends State<MapSettingsButtonPopOut>{
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
      "mapSizeX": "",
      "mazeSizeY": "",
      "tileSize": "",

    };
    tileGridHeight = (tileSize * numberOfStatesX) + 10;
    tileGridWidth = (tileSize * numberOfStatesY) + 10;

  }

    void buildNewMapData(){
      newMapData["mapSizeX"] = numberOfStatesY.toString();
      newMapData["mapSizeY"] = numberOfStatesX.toString();
      newMapData["tileSize"] = tileSize.toString();
    }

    void submitNewMapData(){
      print("Map update Called");
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

    return Center(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
          child: Hero(
              tag: _mappopouttag,
              child: Container(
                  height: 660,
                  width: 440,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0),
                    gradient: LinearGradient(
                      colors: [
                        themePrimary.shade700,
                        themePrimary.shade500,
                        themePrimary.shade300,
                        themePrimary.shade300,
                        themePrimary.shade400,
                        themePrimary.shade700,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 570,
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
                                child: SizedBox(
                                  height: tileGridHeight,
                                  width: tileGridWidth,
                                  child: GridView.count(
                                    //childAspectRatio: (tileWidth/ tileHeight),
                                    padding: EdgeInsets.zero,
                                      crossAxisCount: numberOfStatesX,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    children: mapRepresentation
                                  ),
                                ),
                              ),
                            ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                  const Text("No* of States: "),
                                  SizedBox(
                                    height: 60,
                                    width: 70,
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                          labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                          errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                          hintText: 'Testing hint text',
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
                                  SizedBox(
                                    height: 60,
                                    width: 70,
                                    child: InputDecorator(
                                      decoration: InputDecoration(

                                          labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                          errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                          hintText: 'Testing hint text',
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


                                ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      const Text("Tile Size : "),
                                      SizedBox(
                                        height: 60,
                                        width: 80,
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

                                    ]),

                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: ElevatedButton(onPressed: () {submitNewMapData();} , child: const Text("Submit")),
                                 )
                          ])
                      ),
                    ),
                  )
                )
          )
      ),
    ));
  }
}





