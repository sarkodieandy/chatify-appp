import 'package:flutter/material.dart';

class AiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AisPageState();
  }
}

class _AisPageState extends State<AiPage> {
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}
