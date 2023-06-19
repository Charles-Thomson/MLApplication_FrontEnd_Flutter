import 'package:flutter/material.dart';


class CustomDropDownMenu extends StatefulWidget{
  const CustomDropDownMenu(this.updateConfigData, this.menuItems, this.configKey, {super.key});

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
              child: Text(
                  style: const TextStyle(fontSize: 12),
                  "Select a $selectorTitleName"),
            ),
          ]
      ),

      Material(
        child:  SizedBox(
          height: 55,
          child: InputDecorator(
              decoration: InputDecoration(
                  labelStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                  errorStyle: const TextStyle( color: Colors.redAccent, fontSize: 16),
                  hintText: 'Testing hint text',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
              isEmpty: currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
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