import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/profile-information.dart';
import 'package:matchpoint/screens/profile/components/profile.dart';
import 'package:matchpoint/services/userDatabase.dart';
import 'package:provider/provider.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({Key key}) : super(key: key);

  @override
  _ProfileContainerState createState() => new _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  final userDatabase = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if (user == null) return Container();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: StreamProvider<ProfileInformation>.value(
        // All children will have access to weapons data
        value: userDatabase.streamAccountInformation(user),
        child: Profile(),
      ),
    );
  }
}
