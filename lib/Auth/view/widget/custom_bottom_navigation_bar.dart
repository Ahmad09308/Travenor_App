import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({required this.onTabSelected, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavTheme = theme.bottomNavigationBarTheme;

    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      backgroundColor: bottomNavTheme.backgroundColor ?? theme.canvasColor, // Use theme color
      color: bottomNavTheme.unselectedItemColor ?? Colors.grey, // For inactive items
      activeColor: bottomNavTheme.selectedItemColor ?? theme.primaryColor, // For active items
      curveSize: 800,
      top: -30,
      items: const [
        TabItem(
          icon: Icons.home_outlined,
          //  ImageIcon(
          //   AssetImage('assets/images/homeIcon.png'), 
          //   size: 24,
          // ),
          title: 'Home',
        ),
        TabItem(
          icon: Icons.bookmark_border,
          title: 'Home',
        ),
        TabItem(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        TabItem(icon: Icons.message_outlined, title: 'Messages'),
        TabItem(icon: Icons.person_3_outlined, title: 'Profile'),
      ],
      initialActiveIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.onTabSelected(index);
      },
      height: 60,
      elevation: 2.0,
    );
  }
}
