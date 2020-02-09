import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:matchpoint/models/AccountInformation.dart';
import 'package:matchpoint/services/userDatabase.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  Prediction p;
  AccountInformation _accInfo;

  @override
  Widget build(BuildContext context) {
    _accInfo = Provider.of<AccountInformation>(context);
    // TODO: remove this
    if (_accInfo == null) return Container();

    return ListView(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(10),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  name,
                  Row(
                    children: <Widget>[picture, profileInformation],
                  )
                ],
              )),
          Card(
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(10),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[descriptionTitle, description],
              )),
          Card(
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(10),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[sportsHeader],
              )),
        ],
      ),
    ]);
  }

  Widget get name {
    return ListTile(
      title: Text(_accInfo.name != null ? _accInfo.name : '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.grey[700]),
        onPressed: () => {_displayNameInputDialog(context)},
      ),
    );
  }

  _displayNameInputDialog(BuildContext context) async {
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            title: Text('Enter your name'),
            content: TextField(
              controller: _textFieldController,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  setState(() {
                    _accInfo.name = _textFieldController.text;
                  });
                  UserDatabaseService().updateUser(_accInfo.id, _accInfo);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget get descriptionTitle {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text('About ${_accInfo.name}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget get description {
    return ListTile(
      title: Text(_accInfo.description != null ? _accInfo.description : '',
          style: TextStyle(fontSize: 16)),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.grey[700]),
        onPressed: () => {_displayDescriptionInputDialog(context)},
      ),
    );
  }

  _displayDescriptionInputDialog(BuildContext context) async {
    TextEditingController _textFieldController =
        TextEditingController(text: _accInfo.description ?? "");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            title: Text('Enter your description'),
            content: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              controller: _textFieldController,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  setState(() {
                    _accInfo.description = _textFieldController.text;
                  });
                  UserDatabaseService().updateUser(_accInfo.id, _accInfo);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget get picture {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/Login.PNG')));
  }

  Widget get profileInformation {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        rating,
        SizedBox(height: 5),
        friendCount,
        SizedBox(height: 5),
        location
      ],
    );
  }

  Widget get rating {
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
          size: 16,
        ),
        SizedBox(width: 10),
        Text('4.7')
      ],
    );
  }

  Widget get friendCount {
    return Row(
      children: <Widget>[
        Icon(
          Icons.group,
          size: 16,
        ),
        SizedBox(width: 10),
        Text(
            _accInfo.friends != null ? _accInfo.friends.length.toString() : "0")
      ],
    );
  }

  Widget get location {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          size: 16,
        ),
        SizedBox(width: 10),
        Text(_accInfo.location ?? "Unknown"),
        SizedBox(width: 10),
        Container(
          width: 20,
          height: 20,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.edit,
              size: 16,
              color: Colors.grey[700],
            ),
            onPressed: () async => {
              p = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: "AIzaSyDwXHA1MmHgMGTZZ2IHM_sLHqQbz9LM0uU"),
              setState(() {
                _accInfo.location =
                    p.description != null ? p.description : "Unknown address";
              }),
              UserDatabaseService().updateUser(_accInfo.id, _accInfo)
            },
          ),
        ),
      ],
    );
  }

  Widget get sportsHeader {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Favourite sports',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          FloatingActionButton(
              backgroundColor: Color.fromRGBO(234, 234, 234, 1),
              foregroundColor: Color.fromRGBO(43, 59, 67, 1),
              child: Icon(Icons.add),
              onPressed: () {}),
        ],
      ),
    );
  }
}
