import 'package:clinkcy_local/home_handler/util/nav_button.dart';
import 'package:flutter/material.dart';

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
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.tabs
                  .map((e) => NavButton(
                        icon: e.icon,
                        text: e.text,
                        onPressed: () {
                          setState(() {
                            selectedIndex = widget.tabs.indexOf(e);
                          });
                          e.onPressed?.call();
                          widget.onTabChange?.call(selectedIndex);
                        },
                        active: selectedIndex == widget.tabs.indexOf(e),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
