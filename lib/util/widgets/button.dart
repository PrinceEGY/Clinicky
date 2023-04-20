import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.text,
    this.onPressed,
    this.textColor = Colors.white,
    this.color = ColorPallete.mainColor,
    this.width = 50,
    this.isBordered = false,
  });

  final Text? text;
  final Function? onPressed;
  final Color textColor, color;
  final bool isBordered;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: isBordered
          ? OutlinedButton(
              onPressed: () {
                onPressed!();
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: color,
                  minimumSize: Size(double.infinity, width),
                  side: BorderSide(color: color),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0))),
              child: text)
          : ElevatedButton(
              onPressed: () {
                onPressed!();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, width),
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0))),
              child: text,
            ),
    );
  }
}
