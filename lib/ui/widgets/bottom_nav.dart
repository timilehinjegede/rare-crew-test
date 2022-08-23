import 'package:flutter/material.dart';
import 'package:rare_crew/utils/utils.dart';

class RareCrewBottomNav extends StatelessWidget {
  const RareCrewBottomNav({
    Key? key,
    required this.items,
    required this.onItemSelected,
    this.currentIndex = 0,
  }) : super(key: key);

  final List<BottomNavItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: rareCrewColors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          final index = items.indexOf(item);
          return InkWell(
            onTap: () {
              onItemSelected(index);
            },
            child: _BottomNavItemWidget(
              bottomNavItem: item,
              isSelected: index == currentIndex,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _BottomNavItemWidget extends StatelessWidget {
  const _BottomNavItemWidget({
    Key? key,
    required this.bottomNavItem,
    required this.isSelected,
  }) : super(key: key);

  final BottomNavItem bottomNavItem;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.centerRight,
      height: 50,
      width: isSelected ? 120 : 80,
      decoration: BoxDecoration(
        color: isSelected ? rareCrewColors.purple : rareCrewColors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            bottomNavItem.icon,
            color: isSelected
                ? rareCrewColors.background
                : rareCrewColors.darkGrey,
          ),
          if (isSelected) const XBox(6),
          if (isSelected)
            Text(
              bottomNavItem.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? rareCrewColors.background
                    : rareCrewColors.black,
              ),
            ),
        ],
      ),
    );
  }
}

enum BottomNavItem {
  home(label: 'Home', icon: Icons.home),
  profile(label: 'Profile', icon: Icons.person);

  const BottomNavItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}
