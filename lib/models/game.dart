class Game {
  final String id;
  final String title;
  final String location;
  final String time;
  final int usersJoined;
  final int usersMax;

  Game(this.id, this.title, this.location, this.time, this.usersJoined,
      this.usersMax);

  factory Game.fromJson(dynamic json) {
    return Game(
        json['id'] as String,
        json['title'] as String,
        json['location'] as String,
        json['time'] as String,
        json['usersJoined'] as int,
        json['usersMax'] as int);
  }

  @override
  String toString() {
    return "$id - $title - $location";
  }
}
