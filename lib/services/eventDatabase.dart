import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchpoint/models/game-information.dart';

class EventDatabaseService {
  final CollectionReference gamesCollection =
      Firestore.instance.collection('games');

  Future updateEvent(GameInformation game) async {
    return await gamesCollection.document(game.id).setData(game.toJson());
  }

  Stream<GameInformation> streamGameInformation(GameInformation game) {
    return gamesCollection
        .document(game.id)
        .snapshots()
        .map((snapshot) => GameInformation.fromJson(snapshot));
  }

  Future joinGame(String uid, String gameId) async {
    await gamesCollection.document(gameId).updateData({
      "invitedPlayers": FieldValue.arrayRemove([uid])
    });

    return await gamesCollection.document(gameId).updateData({
      "players": FieldValue.arrayUnion([uid])
    });
  }

  Future requestToJoinGame(String uid, String gameId) async {
    return await gamesCollection.document(gameId).updateData({
      "playerRequests": FieldValue.arrayUnion([uid])
    });
  }
}
