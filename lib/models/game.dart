import 'package:matchpoint/models/location.dart';

class Game {
  final String id;
  final String title;
  final String type;
  final Location location;
  final DateTime time;
  final List<Map<String, dynamic>> players;
  final List<Map<String, dynamic>> invitedPlayers;
  final int maxPlayers;

  Game(
      {this.id,
      this.title,
      this.type,
      this.location,
      this.time,
      this.players,
      this.invitedPlayers,
      this.maxPlayers});

  factory Game.fromJson(dynamic json) {
    return Game(
        id: json['id'] as String,
        title: json['title'] as String,
        type: json['type'] as String,
        location: json['location'] as Location,
        time: json['time'] as DateTime,
        players: json['usersJoined'] as dynamic,
        invitedPlayers: json['invitedPlayers'] as dynamic,
        maxPlayers: json['maxPlayers'] as int);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'location': location.toJson(),
        'time': time,
        'players': players,
        'invitedPlayers': invitedPlayers,
        'maxPlayers': maxPlayers
      };

  @override
  String toString() {
    return "$id - $title - $location";
  }
}
