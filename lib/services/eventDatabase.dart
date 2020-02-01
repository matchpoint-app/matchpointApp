import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchpoint/models/game.dart';

class EventDatabaseService {
  final CollectionReference gamesCollection =
      Firestore.instance.collection('games');

  Future updateEvent(
      Game game) async {
    return await gamesCollection.document(game.id).setData(
      game.toJson()
    );
  }

  Future getEvents() async {
    final result = await gamesCollection.getDocuments();

  }
}
