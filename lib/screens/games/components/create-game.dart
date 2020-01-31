import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/models/location.dart';
import 'package:matchpoint/services/eventDatabase.dart';
import 'package:matchpoint/ui/user-list-item.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({Key key, this.pageTitle}) : super(key: key);

  final String pageTitle;

  @override
  _CreateGameState createState() => new _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  double _sliderValue = 1;
  String _date;

  void _onAddFriendPressed() {
    // TODO: impl
  }

  void _onRemoveFriendPressed() {
    // TODO: impl
  }

  void _onDonePressed(BuildContext ctx) {
    final game = new Game(
        id: 'Test',
        title: 'Game time',
        type: 'Tennis',
        location: new Location(),
        time: DateTime.now(),
        players: [
          {'userId': 1},
          {'userId': 2}
        ],
        maxPlayers: 4);

    EventDatabaseService().updateEvent(game);

    Navigator.of(ctx).pop();
  }

  Future _selectDate(BuildContext context) async {
    var now = DateTime.now();
    DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(now.year, now.month, now.day + 1),
        firstDate: DateTime(now.year, now.month, now.day),
        lastDate: new DateTime(new DateTime.now().year + 1));

    if (selectedDate == null) return;

    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return;

    var selected = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);

    setState(() => this._date = selected.toIso8601String());
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: Text("Create"), actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => _onDonePressed(ctx),
            child: Text(
              "Done",
              style: TextStyle(fontSize: 16),
            ),
          )
        ]),
        body: ListView(children: <Widget>[
          Card(
              margin: EdgeInsets.all(12),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[title, date, location, skillText, slider],
              )),
          cardDescription,
          friends,
        ]));
  }

  Widget get title {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(widget.pageTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget get date {
    return ListTile(
      leading: Icon(Icons.calendar_today),
      title: Text(_date == null ? "Select date" : _date),
      onTap: () => _selectDate(context),
    );
  }

  Widget get location {
    return ListTile(
      leading: Icon(Icons.add_location),
      title: Text("Select location"),
      onTap: () async {
        LocationResult result = await showLocationPicker(
            context, "AIzaSyAIJTbnUWF1HJgLtsWbXDLGKGYZX4qs4z8");
        print("Selected location: " + result.toString());
      },
    );
  }

  Widget get skillText {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: RichText(
            text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(text: "Skill level: "),
            TextSpan(
                text: "${_sliderValue.toInt()}",
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        )));
  }

  Widget get slider {
    return Slider(
        min: 0.0,
        max: 10.0,
        value: _sliderValue,
        onChanged: (value) {
          setState(() => _sliderValue = value.roundToDouble());
        });
  }

  Widget get cardDescription {
    return Card(
        margin: EdgeInsets.all(12),
        elevation: 4,
        child: Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextFormField(
                maxLines: 2,
                decoration: InputDecoration(labelText: "Description"))));
  }

  Widget get friends {
    return Card(
        margin: EdgeInsets.all(12),
        elevation: 4,
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text("Invite friends"),
                trailing: FloatingActionButton(
                  child: Icon(Icons.add),
                  mini: true,
                  elevation: 0,
                  onPressed: _onAddFriendPressed,
                )),
            Divider(),
            UserListItem(
              name: 'Conny',
              rating: '3.5/5',
              onRemoveTap: _onRemoveFriendPressed,
            ),
            UserListItem(
              name: 'Berit',
              rating: '5.0/5',
              onRemoveTap: _onRemoveFriendPressed,
            ),
          ],
        ));
  }
}
