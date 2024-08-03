import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> pages = [
    Container(
      color: Colors.red[300]!,
    ),
    Container(
      color: Colors.pink[300]!,
    ),
    Container(
      color: Colors.green[300]!,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(Icons.chat_bubble_sharp),
            
          ),
          BottomNavigationBarItem(
            label: "Users",
            icon: Icon(Icons.supervised_user_circle_rounded),
          ),
          BottomNavigationBarItem(
            label: "Chatbot",
            icon: Icon(Icons.chat_bubble_outline_rounded),
          ),
        ],
      ),
    );
  }
}
