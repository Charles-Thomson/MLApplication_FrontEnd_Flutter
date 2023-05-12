import 'package:flutter/material.dart';
import 'package:ann_app/widgets/maze_board/maze/built_maze.dart';
import 'package:ann_app/widgets/pathselector/pop_up_selector_button.dart';
import 'package:ann_app/widgets/stats_board/stats_board_body.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children:  [
          const SizedBox(height: 100),
          const Center(
            child: BuiltMaze()
            ),
          const SizedBox(height: 100),
          const StatsBoardBody(),
          const SizedBox(height: 50),

          Row(
            children: const [
              SizedBox(width: 300),
              PopOutSelector()
            ],
          )

        ],
      ),
      );
     // This trailing comma makes auto-formatting nicer for build methods.
  }
}