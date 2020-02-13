import 'package:flutter/material.dart';
import 'package:matchpoint/mixins/translations.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/services/auth-google.dart';
import 'package:matchpoint/ui/action-flat-button.dart';
import 'package:matchpoint/ui/settings-list.dart';

class SettingsContainer extends StatefulWidget {
  const SettingsContainer({Key key}) : super(key: key);

  @override
  _SettingsContainerState createState() => new _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer>
    with Translations {
  @override
  initState() {
    super.initState();
    setTranslationRoot('profile.settings', context);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(settings: [
      Setting(text: t('language'), showArrow: true, onTap: _languageSetting),
      Setting(
          text: t('privacySafety'), showArrow: true, onTap: _privacySetting),
      Setting(text: t('logOut'), textColor: Colors.red, onTap: _logOut),

      //Setting(id: 'LANG', text: 'Språk')
    ]);
  }

  void _languageSetting() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(t('language')),
              ),
              body: Center(child: Text("English")),
            )));
  }

  void _privacySetting() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(t('privacySafety')),
              ),
              body: Center(
                  child: Card(
                      child: Text(
                          "Important information about your account & GDPR"))),
            )));
  }

  void _logOut() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  t('confirmLogout'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ActionFlatButton(
                      text: t('confirmOk'),
                      onPressed: () async {
                        await GoogleAuth.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.Login);
                      }),
                  ActionFlatButton(
                      text: t('confirmCancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ])
          ]));
        });
  }
}
