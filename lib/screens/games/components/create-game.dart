import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/accountInformation.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/models/location.dart';
import 'package:matchpoint/models/sport.dart';
import 'package:matchpoint/services/eventDatabase.dart';
import 'package:matchpoint/services/userDatabase.dart';
import 'package:matchpoint/ui/loading-indicator.dart';
import 'package:matchpoint/ui/user-list-item.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:matchpoint/globals.dart' as globals;

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
  List<AccountInformation> invitedPlayers;
  String _selectedSport;
  int _maxPlayers = 20;
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
            name: _location.address != null
                ? _location.address
                : "Unknown address",
            latitude: _location.latLng.latitude,
            longitude: _location.latLng.longitude),
        time: Timestamp.fromDate(_date),
        owner: globals.userInformation.id,
        players: ['1', '2'],
        invitedPlayers: [],
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
        appBar: AppBar(
            title: Text("Create event"),
            centerTitle: true,
            actions: <Widget>[
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
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(10),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  type,
                  maxPlayers,
                  date,
                  location,
                  skillText,
                  slider
                ],
              )),
          cardGameDescription,
          friends,
        ]));
  }

  Widget get type {
    return ListTile(
      leading: Text("Sport"),
      trailing: Container(
          margin: EdgeInsets.all(8),
          child: StreamBuilder(
              stream: Firestore.instance.collection("sports").snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot == null || snapshot.data == null)
                  return Text("Error");
                return DropdownButton<String>(
                  value: _selectedSport,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedSport = newValue;
                    });
                  },
                  items: snapshot.data.documents
                      .map<DropdownMenuItem<String>>((sport) {
                    var sportObject = Sport.fromJson(sport.data);
                    return DropdownMenuItem<String>(
                      child: Text(sportObject.name),
                      value: sportObject.name,
                    );
                  }).toList(),
                );
              })),
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
    return Container(
      width: 400,
      child: ListTile(
        leading:
            Icon(Icons.add_location, color: Color.fromRGBO(221, 110, 66, 1)),
        title: (_location != null && _location.address != null)
            ? Text(_location.address, overflow: TextOverflow.ellipsis)
            : Text("Select location"),
        onTap: () async {
          _location = await showLocationPicker(
              context, "AIzaSyDwXHA1MmHgMGTZZ2IHM_sLHqQbz9LM0uU");
        },
      ),
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
      trailing: Container(
        margin: EdgeInsets.all(8),
        child: DropdownButton<int>(
            value: _selectedMaxPlayers,
            onChanged: (int newValue) {
              setState(() {
                _selectedMaxPlayers = newValue;
              });
            },
            items: getMaxPlayerList()),
      ),
    );
  }

  getMaxPlayerList() {
    List<DropdownMenuItem<int>> maxPlayerList = List<DropdownMenuItem<int>>();

    for (var i = 1; i <= _maxPlayers; i++) {
      maxPlayerList.add(DropdownMenuItem(
        value: i,
        child: Container(padding: EdgeInsets.all(8), child: Text(i.toString())),
      ));
    }

    return maxPlayerList;
  }

  Widget get cardGameDescription {
    return Card(
      color: Color.fromRGBO(234, 234, 234, 1),
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Column(children: <Widget>[
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
        color: Color.fromRGBO(234, 234, 234, 1),
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text("Invite friends"),
                trailing: FloatingActionButton(
                  backgroundColor: Color.fromRGBO(234, 234, 234, 1),
                  child: Icon(Icons.add, color: Color.fromRGBO(43, 59, 67, 1)),
                  mini: true,
                  elevation: 4,
                  onPressed: () => searchFriendDialog,
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

  Future<Widget> get searchFriendDialog {
    TextEditingController _textFieldController = TextEditingController();
    List<AccountInformation> searchResultList = List<AccountInformation>();
    return showDialog(
        context: context,
        builder: (context) {
          Column friendSearchResult = Column();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              title: Text('Search among your friends'),
              content: Container(
                width: double.maxFinite,
                height: 150,
                child: ListView(children: <Widget>[
                  TextField(
                    maxLines: 1,
                    controller: _textFieldController,
                    onChanged: (searchTerm) async {
                      searchResultList.clear();
                      var searchResult =
                          await UserDatabaseService().searchUser(searchTerm);
                      setState(() {
                        for (var document in searchResult) {
                          searchResultList
                              .add(AccountInformation.fromJson(document.data));
                        }
                        friendSearchResult = Column(
                          children: <Widget>[
                            for (var user in searchResultList)
                              UserListItem(
                                  name: user.name,
                                  rating:
                                      user.rating != null ? user.rating : "0")
                          ],
                        );
                      });
                    },
                  ),
                  friendSearchResult
                ]),
              ),
            );
          });
        });
  }
}
