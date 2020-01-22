import 'package:cloud_firestore/cloud_firestore.dart';

class EventDatabaseService {

  final CollectionReference gamesCollection = Firestore.instance.collection('games');

  Future updateEvent(String eventName) async {
    return await gamesCollection.document(eventName).setData({
      'eventName': 'lalala'
    });
  }

  Future getEvents() async {
    return await gamesCollection.getDocuments();
  }
}