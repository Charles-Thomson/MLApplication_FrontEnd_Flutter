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
  late int? currentSelectedStateValueX;
  late int? currentSelectedStateValueY;

  late double? currentSelectedMazeValueX;
  late double? currentSelectedMazeValueY;

  final String configKey = "";
  final List<int> numberOfStateOptions = [3, 4, 5, 6, 7, 8, 9, 10];
  final List<double> mazeSizeOptions = [100, 150, 200, 250, 300, 350];


  late double tileGridHeight;
  late double tileGridWidth;
  late int numberOfStatesX;
  late int numberOfStatesY;



  int mapDimensionAsStates = 4;


  void updateMazeSizeX(double value){
    setState(() {
      tileGridHeight = value;
    });
  }

  @override
  void initState(){
    super.initState();
    currentSelectedStateValueY = 4;
    currentSelectedStateValueX = 4;

    currentSelectedMazeValueY = 200;
    currentSelectedMazeValueX = 200;

    tileGridHeight = 200;
    tileGridWidth = 200;

    numberOfStatesX = 4;
    numberOfStatesY = 4;
  }
  @override
  Widget build(BuildContext context) {
    int  totalMapStates = numberOfStatesX * numberOfStatesY;
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
                                    isEmpty: currentSelectedStateValueX == 0,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        isExpanded: true,
                                        value: currentSelectedStateValueX,
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            currentSelectedStateValueX = newValue;
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
                                SizedBox(
                                  height: 60,
                                  width: 70,
                                  child: InputDecorator(
                                    decoration: InputDecoration(

                                        labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                        errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                        hintText: 'Testing hint text',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                    isEmpty: currentSelectedStateValueY == 0,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        isExpanded: true,
                                        value: currentSelectedStateValueY,
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            currentSelectedStateValueY = newValue;
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


                              ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    const Text("Maze Size : "),
                                    SizedBox(
                                      height: 60,
                                      width: 80,
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                            labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                            errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                            hintText: 'Testing hint text',
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                        isEmpty: currentSelectedMazeValueX == 0,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<double>(
                                            isExpanded: true,
                                            value: currentSelectedMazeValueX,
                                            onChanged: (double? newValue) {
                                              setState(() {
                                                currentSelectedMazeValueX = newValue;
                                                tileGridHeight = newValue!;
                                              });
                                            },
                                            isDense: true,
                                            items: mazeSizeOptions.map((double value){
                                              return DropdownMenuItem<double>(
                                                  value: value,
                                                  child: Text(value.toString()));
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      width: 80,
                                      child: InputDecorator(
                                        decoration: InputDecoration(

                                            labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                            errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                                            hintText: 'Testing hint text',
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                                        isEmpty: currentSelectedMazeValueY == 0,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<double>(
                                            isExpanded: true,
                                            value: currentSelectedMazeValueY,
                                            onChanged: (double? newValue) {
                                              setState(() {
                                                currentSelectedMazeValueY = newValue;
                                                tileGridWidth = newValue!;
                                              });
                                            },
                                            isDense: true,
                                            items: mazeSizeOptions.map((double value){
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
                                 child: ElevatedButton(onPressed: () {} , child: const Text("Submit")),
                               )
                        ])
                    ),
                  )
                )
          )
      ),
    ));
  }
}





