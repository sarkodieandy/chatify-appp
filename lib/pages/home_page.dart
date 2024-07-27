import 'package:flutter/material.dart';
import 'package:gee/pages/ai_page.dart';
import 'package:gee/pages/users_page.dart';
import '../pages/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    ChatsPage(),
    UsersPage(),
    AiPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (_index) {
          setState(
            () {
              _currentPage = _index;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            label: "chats",
            icon: Icon(Icons.chat_sharp),
          ),
          BottomNavigationBarItem(
            label: "users",
            icon: Icon(Icons.supervised_user_circle_sharp),
          ),
          BottomNavigationBarItem(
            label: "AI",
            icon: Icon(Icons.chat_bubble_rounded),
          ),
        ],
      ),
    );
  }
}
