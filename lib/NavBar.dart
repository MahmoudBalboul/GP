import 'package:agarly/ChatsScreen.dart';
import 'package:agarly/HomeScreen.dart';
import 'package:agarly/profile.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFD6CBBB),
      items: [
        buildBottomNavigationBarItem(Icons.home, 'Home', 0),
        buildBottomNavigationBarItem(Icons.chat, 'Chat', 1),
        buildBottomNavigationBarItem(Icons.person, 'Profile', 2),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        rentBuyOption: '',
                        title: '',
                      )),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ChatsScreen()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
            break;
          default:
            break;
        }
      },
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
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF9CF93),
                ),
                child: Text(''),
              ),
            ),
        ],
      ),
      label: label,
    );
  }
}
