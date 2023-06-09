import 'package:flutter/material.dart';


class DropDownMenu extends StatefulWidget{
  const DropDownMenu(this.updateSelectedValue, this.menuItems, this.selectorTitleName, {super.key});

  final Function(String) updateSelectedValue;
  final List<String> menuItems;
  final String selectorTitleName;


  @override
  State<DropDownMenu> createState() => _DropDownMenu();

}

class _DropDownMenu extends State<DropDownMenu>{

  get selectorTitleName => widget.selectorTitleName;
  late String? currentSelectedValue;


  @override
  void initState(){
    super.initState();
    currentSelectedValue = widget.menuItems[0];
  }

  @override
  Widget build(BuildContext context){
    return Column( children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              child: Text(
                  style: const TextStyle(fontSize: 12),
                  "Select a $selectorTitleName"),
            ),
          ]
      ),

      Material(
        child:  SizedBox(
          child: InputDecorator(
              decoration: InputDecoration(
                  labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                  errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                  hintText: 'Testing hint text',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
              isEmpty: currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: currentSelectedValue,
                    onChanged: (String? newValue) {
                      widget.updateSelectedValue(newValue!);
                      setState(() {
                        currentSelectedValue = newValue;
                      });
                    },
                    isDense: true,
                    items: widget.menuItems.map((String value){
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value)
                      );
                    }
                    ).toList(),

                  )
              )


          ),
        ),
      )



    ]
    );
  }





}