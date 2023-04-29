import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class DayView extends StatefulWidget {
  final String day;
  final String dayNumber;
  final Function onTap;
  final bool isChosen;
  final bool isAvailable;
  const DayView({
    super.key,
    required this.day,
    required this.dayNumber,
    required this.onTap,
    required this.isChosen,
    required this.isAvailable,
  });

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isAvailable
          ? () {
              setState(() {
                widget.onTap();
              });
            }
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isChosen ? ColorPallete.mainColor : Colors.white,
        ),
        child: Column(
          children: [
            Text(
              widget.day,
              style: TextStyle(
                color: !widget.isAvailable
                    ? ColorPallete.grey
                    : widget.isChosen
                        ? Colors.white
                        : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.dayNumber,
              style: TextStyle(
                color: !widget.isAvailable
                    ? ColorPallete.grey
                    : widget.isChosen
                        ? Colors.white
                        : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
