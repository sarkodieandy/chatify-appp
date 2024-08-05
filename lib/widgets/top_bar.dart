import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String _barTitle;
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final double? fontsize;

  late double _deviceHeight;
  late double _deviceWidth;

  TopBar(
    this._barTitle, {
    this.primaryAction,
    this.secondaryAction,
    this.fontsize = 35,
  });

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
      height: _deviceHeight * 0.10,
      width: _deviceWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondaryAction != null) secondaryAction!,
          _titleBar(),
          if (primaryAction != null) primaryAction!,
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      _barTitle,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontsize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
