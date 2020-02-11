import 'package:flutter/material.dart';
import 'package:matchpoint/ui/full-card.dart';

class Setting {
  final String text;
  final VoidCallback onTap;
  final bool showArrow;

  const Setting(
      {@required this.text, @required this.onTap, this.showArrow = false});
}

class SettingsList extends StatelessWidget {
  const SettingsList({this.settings = const []});
  final List<Setting> settings;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: settings
            .asMap()
            .map((index, setting) {
              return MapEntry(
                  index,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [Expanded(child: buildCard(setting, index))],
                  ));
            })
            .values
            .toList());
  }

  Widget buildCard(Setting setting, int index) {
    bool topBorder = index == 0 || index < settings.length;
    bool bottomBorder = settings.length == 1 || index == settings.length - 1;

    return FullCard(
      includeTopBorder: topBorder,
      includeBottomBorder: bottomBorder,
      child: InkWell(
          onTap: setting.onTap,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      setting.text,
                      style: TextStyle(fontSize: 16),
                    ),
                    if (setting.showArrow)
                      Icon(Icons.arrow_forward_ios, color: Colors.black45),
                  ]))),
    );
  }

  BoxDecoration decoration({bool includeTop = false, includeBottom = false}) {
    return BoxDecoration(
        border: Border(
            left: BorderSide.none,
            right: BorderSide.none,
            top: includeTop
                ? BorderSide(color: Colors.black26)
                : BorderSide.none,
            bottom: includeBottom
                ? BorderSide(color: Colors.black26)
                : BorderSide.none));
  }
}
