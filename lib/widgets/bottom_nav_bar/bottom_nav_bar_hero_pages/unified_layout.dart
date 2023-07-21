// Expanded(
//   flex: 2,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children:  [
//       Expanded(
//         child: Wrap(
//             spacing: 5,
//             children: List<Widget>.generate(chipTitles.length, (int index){
//               return ChoiceChip(
//                 label: Text(chipTitles[index]),
//                 avatar: CircleAvatar(
//                     child: Icon(selectedValue == index ? Icons.check : Icons.circle)
//                 ),
//                 selected: selectedValue == index,
//                 onSelected: (bool selected){
//                   setState(() {
//                     selectedValue = selected ? index : null;
//                     selectedAnimationPath = animationPaths[index];
//                   });
//                 },
//               );
//             }
//             ).toList()
//         ),
//       )
//     ],
//   ),
// ),
// Expanded(
//   flex: 1,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       ElevatedButton(onPressed: () {
//         print("SYSTEM - ANIMATION: Card $cardIndex - Path: $selectedAnimationPath");
//         widget.runAnimationCallBack(selectedAnimationPath);
//         }, child: const Text("Run Selected Animation")),
//     ],
//   ),
// )