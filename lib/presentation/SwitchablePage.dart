import 'package:flutter/material.dart';

class SwitchablePage extends StatefulWidget {
  final Widget title;
  final Widget firstPage;
  final Widget secondPage;
  final Widget firstIcon;
  final Widget secondIcon;

  SwitchablePage({
    @required this.title,
    @required this.firstPage,
    @required this.secondPage,
    @required this.firstIcon,
    @required this.secondIcon,
  });

  @override
  State<SwitchablePage> createState() => _SwitchablePageState();
}

class _SwitchablePageState extends State<SwitchablePage> {
  var _isFirstPage = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: widget.title,
          actions: [_createSwitchIcon()],
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _createCurrentPage(),
          transitionBuilder: _createCurrentSwitchAnimation,
        ),
      );

  Widget _createSwitchIcon() => IconButton(
        icon: _isFirstPage ? widget.firstIcon : widget.secondIcon,
        onPressed: _onSwitchIconClick,
      );

  void _onSwitchIconClick() {
    setState(() {
      _isFirstPage = !_isFirstPage;
    });
  }

  Widget _createCurrentPage() => _isFirstPage ? widget.firstPage : widget.secondPage;

  Widget _createCurrentSwitchAnimation(Widget child, Animation<double> animation) =>
      SlideTransition(
        child: child,
        position: Tween(
          begin: Offset(_isFirstPage ? -1.0 : 1.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(animation),
      );
}
