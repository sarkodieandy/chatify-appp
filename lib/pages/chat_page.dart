import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gee/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_list_view_tiles.dart';

// Import your TopBar widget here
import '../widgets/top_bar.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);

    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight * 0.03,
        horizontal: _deviceWidth * 0.02,
      ),
      height: _deviceHeight * 0.98,
      width: _deviceWidth * 0.97,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Uncomment the TopBar widget here
          TopBar(
            'Chats',
            primaryAction: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Color.fromRGBO(0, 82, 218, 1.0),
              ),
              onPressed: _auth.logout,
            ),
          ),
          CustomListViewTileWithActivity(
              height: _deviceHeight * 0.10,
              title: "Sarkodie Andrews",
              subtitle: "hello",
              imagePath: "https://i.pravatar.cc/150?img=65",
              isActive: false,
              isActivity: false,
              onTap: () {})
        ],
      ),
    );
  }
}
