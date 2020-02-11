import 'package:flutter/material.dart';
import 'package:matchpoint/mixins/translations.dart';
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
}
