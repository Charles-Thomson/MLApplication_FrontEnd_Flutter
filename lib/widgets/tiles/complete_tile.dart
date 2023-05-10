import 'package:flutter/material.dart';
import 'package:ann_app/widgets/tiles/tile_top.dart';
import 'package:ann_app/widgets/tiles/tile_body_painter.dart';


class NewCompleteTile extends StatefulWidget{
  const NewCompleteTile({super.key,
    required this.callback,
    required this.tileHeight,
    required this.tileWidth,
    required this.tileIndex,
    });

  final int Function(int, int) callback;
  final double tileHeight;
  final double tileWidth;
  final int tileIndex;


  @override
  State<NewCompleteTile> createState() => _NewCompleteTile();
}

class _NewCompleteTile extends State<NewCompleteTile>{
  final redrawNotifier = ValueNotifier<int>(0);
  int tileStateValue = 1;
  double offSetX = 0;
  double offSetY = 0;
  double depth = 10;
  Color primaryColor = Colors.blueGrey;
  Color secondaryColor = Colors.red;
  Color selectedColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context){
    final redrawNotifier = ValueNotifier<int>(0);

    void checkForRedraw(int newTileStateVale) {
      print("Value in check $newTileStateVale");
      if (newTileStateVale == 1) {
        setState(() {
          //redrawNotifier.value++;
          tileStateValue = newTileStateVale;
          offSetX = 0;
          offSetY = 0;
          depth = 10;
          selectedColor = Colors.blueGrey;
        });
      } else if (newTileStateVale == 2) {
        setState(() {
          //redrawNotifier.value++;
          tileStateValue = newTileStateVale;
          offSetX = 10;
          offSetY = 10;
          depth = 2;
          selectedColor = Colors.red;
        });
      } else if (newTileStateVale == 3) {
        setState(() {
          //redrawNotifier.value++;
          tileStateValue++;
          offSetX = 0;
          offSetY = 0;
          depth = 10;
          selectedColor = Colors.orange;
        });
      } else {
        setState(() {
          //redrawNotifier.value++;
          tileStateValue++;
          offSetX = 0;
          offSetY = 0;
          depth = 10;
          selectedColor = Colors.blueGrey;
        });
      }
    }

    return Transform.translate(
      offset: Offset(offSetX, offSetY),
      child: SizedBox(
          height: widget.tileHeight,
          width: widget.tileWidth,
          child: Stack(
              children: [
          CustomPaint(
          size: Size(widget.tileHeight, widget.tileWidth),
          painter: TilePainter(tileState: tileStateValue, depth: depth, repaint: redrawNotifier)
          ),
                TileTop(
                  myOnPressed: (index,tileStateValue) {
                    int returnVal = widget.callback(index, tileStateValue);
                    print("Returned val $returnVal ");
                    checkForRedraw(returnVal); // this is on this level
                    return returnVal; // passed -> tile_top
                  },
                  tileHeight: widget.tileHeight,
                  tileWidth: widget.tileWidth,
                  tileIndex: widget.tileIndex,
                  primaryColor: selectedColor,
                )
              ]
          )
      ),
    );

  }
}


// class CompleteTile extends StatelessWidget{
//   const CompleteTile({required Key key,
//     required this.callback,
//     required this.tileHeight,
//     required this.tileWidth,
//     required this.tileOffSet,
//     required this.tileIndex,
//     required this.primaryColor}): super(key: key);
//
//   final int Function(int, int) callback;
//   final double tileHeight;
//   final double tileWidth;
//   final double tileOffSet;
//   final int tileIndex;
//   final Color primaryColor;
//
//   @override
//   Widget build(BuildContext context){
//     final redrawNotifier = ValueNotifier<int>(0);
//     int tileStateValue = 0;
//
//     void checkRedrawNotifier(int thisStateValue){
//       if(thisStateValue == 2) {
//         redrawNotifier.value++;
//         print("Notifier value $redrawNotifier");
//       }
//     }
//
//     double offSetX = 0;
//     double offSetY = 0;
//
//
//       if (tileStateValue == 2) {
//         offSetX = 10;
//         offSetY = 10;
//       }
//
//
//     return Transform.translate(
//       offset: Offset(offSetX, offSetY),
//       child: SizedBox(
//           height: tileHeight,
//           width: tileWidth,
//
//           child: Stack(
//               children: [
//                 CustomPaint(
//                     size: Size(tileHeight, tileWidth),
//                     painter: TilePainter(tileState: tileStateValue, repaint: redrawNotifier)
//                 ),
//
//                 TileTop(
//                   myOnPressed: (index,tileStateValue) {
//                     int returnVal = callback(index, tileStateValue);
//                     tileStateValue = returnVal;
//                     checkRedrawNotifier(returnVal);
//
//                     return returnVal;
//                   },
//                   tileHeight: tileHeight,
//                   tileWidth: tileWidth,
//                   tileOffSet: tileOffSet,
//                   tileIndex: tileIndex,
//                   primaryColor: primaryColor,
//                 )
//               ]
//           )
//       ),
//     );
//   }
// }