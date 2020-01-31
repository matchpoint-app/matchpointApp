import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/models/location.dart';
import 'package:matchpoint/services/eventDatabase.dart';
import 'package:matchpoint/ui/user-list-item.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(43, 59, 67, 1),
      ),
      backgroundColor: Color.fromRGBO(234, 234, 234, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(12),
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
              margin: EdgeInsets.all(12),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[descriptionTitle, description],
              )),
          Card(
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(12),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[sportsHeader],
              )),
        ],
      ),
    );
  }

  Widget get name {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text('John Linder',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget get descriptionTitle {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text('About John',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget get description {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
          'Hej, jag heter John och jag gillar att spela fotboll om dagarna.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
    );
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
          color: Colors.orange,
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
          color: Colors.orange,
          size: 16,
        ),
        SizedBox(width: 10),
        Text('57')
      ],
    );
  }

  Widget get location {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: Colors.orange,
          size: 16,
        ),
        SizedBox(width: 10),
        Text('Stockholm, Sweden')
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
