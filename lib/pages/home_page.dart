import 'package:flutter/material.dart';
import 'package:gee/pages/ai_page.dart';
import '../pages/chats_page.dart';
import '../pages/Users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> pages = [
    const ChatsPage(),
    const AiPage(),
    const UsersPage(),
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
