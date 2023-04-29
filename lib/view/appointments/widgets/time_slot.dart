import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class TimeSlot extends StatefulWidget {
  final bool isSelected;
  final bool isActive;
  final TimeOfDay time;
  final Function onChange;
  const TimeSlot({
    super.key,
    required this.isSelected,
    required this.time,
    required this.onChange,
    required this.isActive,
  });

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      padding: const EdgeInsets.all(7),
      label: Text(
          "${widget.time.hour.toString().padLeft(2, "0")}:${widget.time.minute.toString().padLeft(2, "0")}"),
      selected: widget.isSelected,
      onSelected: widget.isActive ? (value) => widget.onChange() : null,
      selectedColor: ColorPallete.mainColor,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: !widget.isActive
            ? Colors.black
            : widget.isSelected
                ? Colors.white
                : ColorPallete.mainColor,
        fontFamily: "roboto",
        fontSize: 17,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: !widget.isActive ? ColorPallete.grey : ColorPallete.mainColor,
        ),
      ),
      disabledColor: Colors.white,
    );
  }
}
