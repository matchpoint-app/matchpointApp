import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SocialSearch extends StatelessWidget {
  final TextEditingController controller;
  const SocialSearch(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableSuggestions: false,
      decoration: InputDecoration(
          labelText: FlutterI18n.translate(context, "social.search"),
          hintText: FlutterI18n.translate(context, "social.search"),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0)))),
    );
  }
}
