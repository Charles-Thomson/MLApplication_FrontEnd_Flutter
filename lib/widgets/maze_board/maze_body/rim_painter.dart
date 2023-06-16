import 'package:flutter/material.dart';

class RimContainer extends StatelessWidget{
    const RimContainer({super.key, required this.mazeHeight, required this.mazeWidth, required this.edgeRadius });

    final double mazeHeight;
    final double mazeWidth;
    final double edgeRadius;

    @override
    Widget build(BuildContext context){
        return Container(
            height: mazeHeight ,
            width: mazeWidth  ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(edgeRadius),
                gradient: LinearGradient(
                    colors: <Color>[
                        Colors.grey.shade600,
                        Colors.grey.shade500,
                        Colors.grey.shade300,
                        Colors.grey.shade500
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: const [0.01, 0.40, 0.50, 0.9],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 6,
                    offset: const Offset(1,1 ),
                    blurStyle: BlurStyle.solid
                  )
                ]
            )
            );
    }
}

class RimContainerCutout extends StatelessWidget{
  const RimContainerCutout({super.key, required this.mazeHeight, required this.mazeWidth, required this.rimOffSet});

  final double mazeHeight;
  final double mazeWidth;
  final double rimOffSet;

  @override
  Widget build(BuildContext context){
    return Container(
        height: mazeHeight - rimOffSet,
        width: mazeWidth - rimOffSet,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 1,
                  blurStyle: BlurStyle.solid
              )
            ]
        )
    );

  }
}

// class BodyClipper extends CustomClipper<Path>{
//
//     @override
//     Path getClip(Size size){
//       double edgeOffSet = 2;
//       final path = Path();
//       return path;
//
//     }
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
//
//
//
// }