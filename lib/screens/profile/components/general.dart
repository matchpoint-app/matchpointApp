import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:matchpoint/models/profile-information.dart';
import 'package:matchpoint/screens/profile/components/meta-row.dart';

class General extends StatelessWidget {
  const General({this.profile, this.onLocationPress, Key key})
      : super(key: key);

  final ProfileInformation profile;
  final VoidCallback onLocationPress;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Card(
          color: Color.fromRGBO(234, 234, 234, 1),
          elevation: 6,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildName()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      buildAvatar(),
                      Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: buildMeta())
                    ],
                  )
                ],
              ))),
    ]);
  }

  Widget buildName() {
    return Text(profile.name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget buildAvatar() {
    var initials = profile.name
        .split(' ')
        .take(2)
        .map((str) => str.substring(0, 1).toUpperCase())
        .join();

    double size = 36;

    return ClipOval(
        child: TransitionToImage(
      image: AdvancedNetworkImage(
        profile.photoUrl,
      ),
      fit: BoxFit.contain,
      loadingWidget: iconAvatarReplacement(size),
      placeholder: iconAvatarReplacement(size),
      width: size * 2,
      height: size * 2,
    ));
  }

  Widget iconAvatarReplacement(double size) {
    var initials = profile.name
        .split(' ')
        .take(2)
        .map((str) => str.substring(0, 1).toUpperCase())
        .join();

    return Container(
        height: size * 2,
        width: size * 2,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(size))),
        child: Center(
            child: Text(initials,
                style: TextStyle(fontSize: 28, letterSpacing: 2))));
  }

  Widget buildMeta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MetaRow(icon: Icons.star, text: profile.rating?.toString() ?? 'N/A'),
        MetaRow(
            icon: Icons.group, text: profile.friends?.length.toString() ?? '0'),
        MetaRow(icon: Icons.location_on, text: profile.location ?? 'N/A')
      ],
    );
  }
}
