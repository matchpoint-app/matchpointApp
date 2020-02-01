import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/models/location.dart';
import 'package:matchpoint/services/eventDatabase.dart';
import 'package:matchpoint/ui/user-list-item.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:uuid/uuid.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({Key key, this.pageTitle}) : super(key: key);

  final String pageTitle;

  @override
  _CreateGameState createState() => new _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  double _sliderValue = 1;
  DateTime _date;
  LocationResult _location;
  List<String> _sports = ['Tennis', 'Football', 'Running', 'Golf'];
  String _selectedSport;
  List<int> _maxPlayers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int _selectedMaxPlayers;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _onAddFriendPressed() {
    // TODO: impl
  }

  void _onRemoveFriendPressed() {
    // TODO: impl
  }

  void _onDonePressed(BuildContext ctx) {
    final game = new Game(
        id: new Uuid().v1(),
        title: titleController.text,
        description: descriptionController.text,
        type: _selectedSport,
        skillLevel: _sliderValue,
        private: false,
        location: new Location(
        name: _location.address != null ? _location.address : "Unknown address", 
        latitude: _location.latLng.latitude, 
        longitude: _location.latLng.longitude),
        time: Timestamp.fromDate(_date),
        players: [
          {'userId': 1},
          {'userId': 2}
        ],
        usersMax: _selectedMaxPlayers);

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

    setState(() => this._date = selected.toUtc());
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Create event"), centerTitle: true, actions: <Widget>[
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
              margin: EdgeInsets.all(10),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[type, maxPlayers, date, location, skillText, slider],
              )),
          cardGameDescription,
          friends,
        ]));
  }

  Widget get type {
    return ListTile(
          title: Text('Sport'),
                  trailing: DropdownButton<String>(
            value: _selectedSport,
            onChanged: (String newValue) {
              setState(() {
                _selectedSport = newValue;
              });
            },
            items: _sports.map((sport) {
              return DropdownMenuItem(
                child: new Text(sport),
                value: sport,
              );
            }).toList(),
          ),
        );
  }

  Widget get date {
    return ListTile(
      leading:
          Icon(Icons.calendar_today, color: Color.fromRGBO(221, 110, 66, 1)),
      title: Text(_date == null ? "Select date" : _date.toString()),
      onTap: () => _selectDate(context),
    );
  }

  Widget get location {
    return ListTile(
      leading: Icon(Icons.add_location, color: Color.fromRGBO(221, 110, 66, 1)),
      title: _location.address != null ? Text(_location.address) : Text("Select location"),
      onTap: () async {
        _location = await showLocationPicker(
            context, "AIzaSyDwXHA1MmHgMGTZZ2IHM_sLHqQbz9LM0uU");
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

   Widget get maxPlayers {
    return ListTile(
          title: Text('Max players'),
                  trailing: DropdownButton<int>(
            value: _selectedMaxPlayers,
            onChanged: (int newValue) {
              setState(() {
                _selectedMaxPlayers = newValue;
              });
            },
            items: _maxPlayers.map((maxPlayer) {
              return DropdownMenuItem(
                child: new Text(maxPlayer.toString()),
                value: maxPlayer,
              );
            }).toList(),
          ),
        );
  }

  Widget get cardGameDescription {
    return Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Column(
                children: <Widget>[
                   Container(
                     padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                     child: TextFormField(
                       controller: titleController,
                          maxLines: 1,
                          decoration: InputDecoration(labelText: "Title")),
                   ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: TextFormField(
                      controller: descriptionController,
                          maxLines: 2,
                          decoration: InputDecoration(labelText: "Description")),
                  ),
                ]),
        );
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
