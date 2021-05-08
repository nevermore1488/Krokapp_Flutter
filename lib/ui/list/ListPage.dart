import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final Widget appBar;
  final List<Widget> items;

  ListPage(
    this.items, {
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: ListView(
          children: items,
          padding: EdgeInsets.only(bottom: 32),
        ),
      ),
    );
  }
}
