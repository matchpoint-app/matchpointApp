import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/ui/layout.dart';

class CreateGame extends StatelessWidget {
  final String pageTitle;

  const CreateGame(this.pageTitle);

  @override
  Widget build(BuildContext ctx) {
    return Layout(
        pageTitle: "Create $pageTitle",
        body: ListView(children: <Widget>[
          Card(
              margin: EdgeInsets.all(12),
              elevation: 4,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextFormField(
                      decoration: InputDecoration(labelText: "Description")))),
          Card(
              margin: EdgeInsets.all(12),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(pageTitle,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text("Select date"),
                  ),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title: Text("Select location"),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child:
                          Text("Skill level", style: TextStyle(fontSize: 16))),
                  Slider(
                      min: 0.0, max: 10.0, onChanged: (value) => {}, value: 4)
                ],
              ))
        ]));
  }
}
