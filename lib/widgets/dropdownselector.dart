import 'package:flutter/material.dart';


class CustomDropDownMenu extends StatefulWidget{
  const CustomDropDownMenu(this.updateConfigData, this.menuItems, this.configKey,{super.key});

  final Function(String, String) updateConfigData;
  final List<String> menuItems;
  final String configKey;


  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenu();
}

class _CustomDropDownMenu extends State<CustomDropDownMenu>{
  get selectorTitleName => widget.configKey;
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
              color: Colors.blueGrey.withOpacity(0),
              child: Text(
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white
                  ),
                  "Select a $selectorTitleName"),
            ),
          ]
      ),

      Material(
        color: Colors.blueGrey.withOpacity(0),
        child:  SizedBox(
          height: 55,
          child: InputDecorator(
              decoration: InputDecoration(
                  labelStyle:  TextStyle( color: Colors.redAccent, fontSize: 16, backgroundColor: Colors.blueGrey.withOpacity(0)),
                  errorStyle:  TextStyle( color: Colors.redAccent, fontSize: 16, backgroundColor: Colors.blueGrey.withOpacity(0)),
                  hintText: 'Testing hint text',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
              isEmpty: currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.blueGrey,
                    isExpanded: true,
                    value: currentSelectedValue,
                    onChanged: (String? newValue) {
                      widget.updateConfigData(widget.configKey, newValue!);
                      setState(() {
                        currentSelectedValue = newValue;
                      });
                    },
                    isDense: true,
                    items: widget.menuItems.map((String value){
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: Colors.white),)
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