import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({@required this.body, @required this.pageTitle, Key key})
      : super(key: key);

  final Widget body;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: body);
  }
}
