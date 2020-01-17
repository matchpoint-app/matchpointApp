class Game {
  final String id;
  final String title;
  final String location;
  final String time;
  final int usersJoined;
  final int usersMax;

  Game(
      {this.id,
      this.title,
      this.location,
      this.time,
      this.usersJoined,
      this.usersMax});

  factory Game.fromJson(dynamic json) {
    return Game(
        id: json['id'] as String,
        title: json['title'] as String,
        location: json['location'] as String,
        time: json['time'] as String,
        usersJoined: json['usersJoined'] as int,
        usersMax: json['usersMax'] as int);
  }

  @override
  String toString() {
    return "$id - $title - $location";
  }
}
