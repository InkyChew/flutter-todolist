import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorDialog extends StatelessWidget {

  final Color currentColor;
  final Function(Color) changeColor;
  const ColorDialog({super.key, required this.currentColor, required this.changeColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: currentColor,
          onColorChanged: changeColor,
          availableColors: const [
            Colors.pink,
            Colors.deepOrange,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.deepPurple,
          ],
        ),
      ),
    );
  }
}