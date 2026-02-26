import 'package:flutter/material.dart';
import '../../../domain/entities/button_navigation_bar_entity.dart';
import 'custom_bottom_navigation_bari_tem.dart';

class HomeCustomBottomNavigationBar extends StatefulWidget {
  const HomeCustomBottomNavigationBar({super.key, required this.onItemTapped});
  final ValueChanged<int> onItemTapped;
  @override
  State<HomeCustomBottomNavigationBar> createState() =>
      _HomeCustomBottomNavigationBarState();
}

class _HomeCustomBottomNavigationBarState
    extends State<HomeCustomBottomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          const BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: getButtonNavigationBarItems(context).asMap().entries.map((e) {
          var index = e.key;
          var entity = e.value;

          return Expanded(
            flex: index == selectedIndex ? 3 : 2,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  widget.onItemTapped(index);
                });
              },
              child: CustomBottomNavigationBarItem(
                isSelected: selectedIndex == index,
                buttonNavigationBarEntity: entity,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
