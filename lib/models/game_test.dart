import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matchpoint/models/game.dart';

void main() {
  String json = '''{
    "id": "test",
    "title": "a title",
    "location": "a location",
    "time": "some time",
    "players": 3,
    "invitedPlayers: 2,
    "maxPlayers": 4
    }''';

  test('Decode Json', () {
    Game s = Game.fromJson(jsonDecode(json));
    print(s);
    assert(s != null);
    expect(s.id, "test");
    expect(s.title, "a title");
    expect(s.location, "a location");
    expect(s.time, "some time");
    expect(s.players, 3);
    expect(s.invitedPlayers, 2);
    expect(s.usersMax, 4);
  });
}
