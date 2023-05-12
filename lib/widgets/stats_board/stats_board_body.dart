import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StatsBoardBody extends StatefulWidget{
  const StatsBoardBody({super.key});

  @override
  State<StatsBoardBody> createState() => _StatsBoardBody();
}

class _StatsBoardBody extends State<StatsBoardBody>{

  @override
  Widget build(BuildContext context){
    var items = [
      'Results',
      'Data',
      'New Run',
      '2D map',

    ];
    String dropdownvalue = items.first;



    return SizedBox(
      height: 200,
      width: 300,
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0
                ),
                gradient: LinearGradient(
                  colors:
                  [
                    Colors.grey.shade700,
                    Colors.grey.shade500,
                    Colors.grey.shade300,
                    Colors.grey.shade100,
                    Colors.grey.shade200,
                    Colors.grey.shade700,
                  ],
                  stops: const [0.01, 0.2, 0.49, 0.52, 0.6, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,

                ),

                color: Colors.blueGrey,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                      blurStyle: BlurStyle.solid
                  )
                ]
            ),
            child: Center(
              child:Container(
                height: 180,
                width: 280,
                color: Colors.white,

                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 100,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButton(
                            isExpanded: false,
                            value: dropdownvalue, // starting value
                            icon: const Icon(Icons.keyboard_arrow_down),

                            items: items.map((String items){
                              return DropdownMenuItem<String>(
                                  value: items,
                                  child: Text(items)
                              );
                            }).toList(),

                            onChanged: (String? newValue){
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            }
                          ),
                        ],
                      )
                    )
                  ],


                )
              )

            )
          ),

        ],

      ),
    );
  }
}