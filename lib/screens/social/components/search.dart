import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SocialSearch extends StatelessWidget {
  const SocialSearch({this.controller, this.onClear});

  final TextEditingController controller;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableSuggestions: false,
      decoration: InputDecoration(
          labelText: FlutterI18n.translate(context, "social.search"),
          hintText: FlutterI18n.translate(context, "social.search"),
          prefixIcon: Icon(Icons.search),
          suffixIcon:
              IconButton(icon: Icon(Icons.highlight_off), onPressed: onClear),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)))),
    );
  }
}
