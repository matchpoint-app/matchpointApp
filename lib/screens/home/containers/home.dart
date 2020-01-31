import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(child: Text("Home screen")),
    );
  }
}
