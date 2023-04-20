import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  final IconData? icon;
  final String text;
  final Function? onPressed;
  final bool active;
  const NavButton({
    this.icon,
    this.text = '',
    this.onPressed,
    super.key,
    this.active = false,
  });

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  late bool active;

  @override
  void initState() {
    super.initState();
    active = widget.active;
  }

  @override
  void didUpdateWidget(NavButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active != oldWidget.active) {
      active = widget.active;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        debugPrint("${widget.text} $active");
        widget.onPressed?.call();
      },
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: active ? ColorPallete.mainColor : ColorPallete.grey,
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: active ? ColorPallete.mainColor : ColorPallete.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
