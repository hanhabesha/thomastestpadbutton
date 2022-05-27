import 'dart:core';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: PadButton(),
      );
}

class PadButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      scrollDirection: Axis.vertical,
      itemCount: 7,
      itemBuilder: (_, index) => PadButtonTile(),
    );
  }
}

class PadButtonTile extends StatefulWidget {
  @override
  _PadButtonTileState createState() => _PadButtonTileState();
}

class _PadButtonTileState extends State<PadButtonTile> {
  bool applied = false;

  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        //width: double.infinity,
        decoration: BoxDecoration(
          color: dialogPickerColor,
          borderRadius: BorderRadius.circular(36.0),
        ),
        child: Expanded(
          child: applied ? padButtonMethode() : frontButton(),
        ),
      ),
    );
    //);
  }

  ElevatedButton frontButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() => applied = !applied);
      },
      /**
       * HELP HERE !!!!!!!!!!!!!!!
       * I COULDNT MANAGE TO MAKE THE BUTTON SMALL AS THE PLAY RECORD BUTTON
       */
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size(10, 40)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          CircleBorder(
            side: BorderSide(width: 2),
          ),
        ),
      ),
      // style: ElevatedButton.styleFrom(
      //   shape: const CircleBorder(),
      //   padding: const EdgeInsets.all(4),
      //   fixedSize: const Size(20, 20),
      //   primary: Colors.grey, // <-- Button color
      //   onPrimary: Colors.red, // <-- Splash color
      // ),
      child: const Icon(
        Icons.add,
      ),
    );
  }

  Column padButtonMethode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Here i wanted to use the stack for a better UI
        //but the positioned iconbutton can not be clicked becouse of clipBehavior of the stack
        // although the overflow button is visible, but it's overflow part will not be clickable.
        //and this gaved me hard time, and for the test i used the Ply button to change the color as
        //neded and pleas help here !!!!!!, i didnt wanted to make it row b/c the UI will not best as the stack one.
        Stack(
          alignment: AlignmentDirectional.topEnd,
          clipBehavior: Clip.none,
          //fit: StackFit.loose,
          children: [
            Positioned(
              left: 140,
              top: -60,
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                iconSize: 50,
                color: Colors.green,
                splashColor: Colors.purple,
                onPressed: () {
                  colorPickerDialog();
                },
              ),
            ),
            const Text(
              'Title',
              style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 40),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            colorPickerDialog();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            primary: dialogPickerColor, // <-- Button color
            onPrimary: Colors.red, // <-- Splash color
          ),
          child: const Icon(
            Icons.play_arrow_outlined,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Date detail',
          style: TextStyle(
            // changing the color of the text makes it non readeble so it can be done this way but i commented
            //this purposely and the same for the title !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // remove the const of the Text widget if you enabled the color

            //color: dialogPickerColor,
            fontSize: 24.0,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(dialogPickerColor),
              ),
              onPressed: () {},
              child: const Text('View'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(dialogPickerColor),
              ),
              onPressed: () {},
              child: const Text('Record'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(dialogPickerColor),
              ),
              onPressed: () {},
              child: const Text('Debug'),
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> colorPickerDialog() async {
    var colorsNameMap;
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: dialogPickerColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.caption,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      //customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}




































/*****
 *  I DONT DELETE CODES WICH LEAD ME TO THE FINAL OUT PUT 
 * SO ALL COMMENTED CODES ARE WICH I TRIED TO UNDERSTAND MY 
 * PROBLEMS, PERSONALEY I DIDNT DELETE CODE
 * 
 */


// class PadButtonWidget extends StatelessWidget {
//   final String title, date, button1, button2, button3;
//   PadButtonWidget(
//       {Key? key,
//       required this.title,
//       required this.date,
//       required this.button1,
//       required this.button2,
//       required this.button3})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 100,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.grey,
//           //border: Border.all(width: 8),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Text('Title'),
//                 IconButton(
//                   iconSize: 24,
//                   icon: const Icon(Icons.color_lens),
//                   onPressed: () {},
//                 )
//               ],
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               child: Icon(Icons.play_arrow_outlined, color: Colors.redAccent),
//               style: ElevatedButton.styleFrom(
//                 shape: CircleBorder(),
//                 padding: EdgeInsets.all(20),
//                 primary: Colors.blue, // <-- Button color
//                 onPrimary: Colors.red, // <-- Splash color
//               ),
//             ),
//             const Text('Date detail'),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Text'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Text'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Text'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// showDialog(
//   context: context,
//   child: AlertDialog(
//     title: const Text('Pick a color!'),
//     content: SingleChildScrollView(
//       child: ColorPicker(
//         pickerColor: pickerColor,
//         onColorChanged: changeColor,
//       ),
//       // Use Material color picker:
//       //
//       // child: MaterialPicker(
//       //   pickerColor: pickerColor,
//       //   onColorChanged: changeColor,
//       //   showLabel: true, // only on portrait mode
//       // ),
//       //
//       // Use Block color picker:
//       //
//       // child: BlockPicker(
//       //   pickerColor: currentColor,
//       //   onColorChanged: changeColor,
//       // ),
//       //
//       // child: MultipleChoiceBlockPicker(
//       //   pickerColors: currentColors,
//       //   onColorsChanged: changeColors,
//       // ),
//     ),
//     actions: <Widget>[
//       ElevatedButton(
//         child: const Text('Got it'),
//         onPressed: () {
//           setState(() => currentColor = pickerColor);
//           Navigator.of(context).pop();
//         },
//       ),
//     ],
//   ),
// )
