import 'package:flutter/material.dart';

class FullCard extends StatelessWidget {
  const FullCard(
      {@required this.child,
      this.includeTopBorder = true,
      this.includeBottomBorder = true});

  final bool includeTopBorder;
  final bool includeBottomBorder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: decoration(includeTopBorder, includeBottomBorder),
        margin: EdgeInsets.all(0),
        child: Material(
          type: MaterialType.card,
          borderRadius: BorderRadius.all(Radius.circular(0)),
          child: child,
        ));
  }

  BoxDecoration decoration(bool includeTop, bool includeBottom) {
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
