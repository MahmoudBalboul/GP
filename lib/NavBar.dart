// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFD6CBBB),
      items: [
        buildBottomNavigationBarItem(Icons.home, 'Home', 0),
        buildBottomNavigationBarItem(Icons.chat, 'Chat', 1),
        buildBottomNavigationBarItem(Icons.person, 'Profile', 2),
      ],
      currentIndex: currentIndex,
      onTap: (index) {},
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          if (index == currentIndex)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF9CF93),
                ),
                child: const Text(''),
              ),
            ),
        ],
      ),
      label: label,
    );
  }
}
