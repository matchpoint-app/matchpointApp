import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:matchpoint/mixins/translations.dart';
import 'package:matchpoint/models/profile-information.dart';
import 'package:matchpoint/screens/profile/components/general.dart';
import 'package:matchpoint/screens/profile/settings.dart';
import 'package:matchpoint/services/userDatabase.dart';
import 'package:matchpoint/ui/full-card.dart';
import 'package:matchpoint/ui/loading-indicator.dart';
import 'package:matchpoint/ui/settings-list.dart';
import 'package:provider/provider.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({Key key}) : super(key: key);

  @override
  _ProfileContainerState createState() => new _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> with Translations {
  final userDatabase = UserDatabaseService();

  @override
  initState() {
    super.initState();
    setTranslationRoot('profile', context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if (user == null) return Container();

    return Scaffold(
        appBar: AppBar(
          title: Text(t('title')),
          centerTitle: true,
        ),
        body: StreamProvider<ProfileInformation>.value(
            // All children will have access to weapons data
            value: userDatabase.streamAccountInformation(user),
            child: buildConsumer()));
  }

  Widget buildConsumer() {
    return Consumer<ProfileInformation>(builder: (_, profile, __) {
      if (profile == null) {
        return Center(child: LoadingIndicator());
      }

      return ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: General(
                profile: profile,
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 4),
              child: settingTitle((t('titleLocation')))),
          SettingsList(
            settings: [
              Setting(
                  text: profile.location ?? t('locationMissing'),
                  showArrow: true,
                  onTap: () => _onLocationPress(profile))
            ],
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(12, 20, 12, 4),
              child: settingTitle((t('titleDescription')))),
          GestureDetector(
              onTap: () => _editDescription(profile),
              child: FullCard(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Text(
                        profile.description,
                        style: TextStyle(fontSize: 16),
                      )))),
          Padding(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 4),
              child: settingTitle((t('titleGeneral')))),
          SettingsContainer()
        ],
      );
    });
  }

  _editDescription(ProfileInformation profile) {
    TextEditingController _descriptionController =
        TextEditingController(text: profile.description);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            title: Text('Enter your description'),
            content: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
              controller: _descriptionController,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await userDatabase.setUserDescription(
                      profile, _descriptionController.text);
                  _descriptionController.dispose();
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

  Widget settingTitle(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, color: Colors.black38, fontWeight: FontWeight.bold),
    );
  }

  void _onLocationPress(ProfileInformation profile) async {
    Prediction pred = await PlacesAutocomplete.show(
        context: context,
        apiKey: "AIzaSyDwXHA1MmHgMGTZZ2IHM_sLHqQbz9LM0uU",
        onError: (error) => print(error));

    if (pred != null) {
      await userDatabase.setUserLocation(profile, pred.description);
    }
  }
}
