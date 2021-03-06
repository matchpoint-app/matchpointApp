import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/social/components/search.dart';
import 'package:matchpoint/screens/social/components/social-card-item.dart';

class SocialContainer extends StatefulWidget {
  const SocialContainer({Key key}) : super(key: key);

  @override
  _SocialContainerState createState() => _SocialContainerState();
}

class _SocialContainerState extends State<SocialContainer> {
  final TextEditingController searchControl = TextEditingController();
  Timer _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      print("search: " + searchControl.value.toString());
    });
  }

  void _onSearchClear() {
    searchControl.clear();
  }

  void _onChatSelect() {
    Navigator.of(context).pushNamed(Routes.Chat);
    print("click chat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(FlutterI18n.translate(context, 'social.social')),
        ),
        body: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20)),
          Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: SocialSearch(
                controller: searchControl,
                onClear: _onSearchClear,
              )),
          Expanded(
              child: ListView.builder(
            itemCount: 20,
            itemBuilder: _buildListCard,
          ))
        ]));
  }

  Widget _buildListCard(BuildContext context, int index) {
    return SocialCardItem(
      tag: index.toString(),
      title: "johnny",
      subtitle: "some data",
      onTap: _onChatSelect,
    );
  }

  @override
  void initState() {
    searchControl.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    searchControl.dispose();
    super.dispose();
  }
}
