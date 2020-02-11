import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

typedef String Translation(String key);

class Translations {
  Translation t;

  setTranslationRoot(String root, BuildContext context) {
    t = (String key) => FlutterI18n.translate(context, '$root.$key');
  }
}
