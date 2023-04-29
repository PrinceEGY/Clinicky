import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

//! Navigation Button
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

//! Navigation Bar
class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabChange,
  });

  final List<NavButton> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      // shape: const CircularNotchedRectangle(),
      // notchMargin: 10,
      child: Row(
        children: getTabs(),
      ),
    );
  }

  List<Flexible> getTabs() {
    List<Flexible> tabs = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      tabs.add(Flexible(
        fit: FlexFit.tight,
        flex: i == 1 || i == 2 ? 5 : 3,
        child: NavButton(
          icon: widget.tabs[i].icon,
          text: widget.tabs[i].text,
          onPressed: () {
            setState(() {
              selectedIndex = widget.tabs.indexOf(widget.tabs[i]);
            });
            widget.tabs[i].onPressed?.call();
            widget.onTabChange?.call(selectedIndex);
          },
          active: selectedIndex == widget.tabs.indexOf(widget.tabs[i]),
        ),
      ));
    }
    return tabs;
  }
}
