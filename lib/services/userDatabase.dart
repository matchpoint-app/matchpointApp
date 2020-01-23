import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  String uid;
  UserDatabaseService(String uid) {
    this.uid = uid;
  }

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUser() async {
    final userSnapshot = await usersCollection.document(uid).get();
    var user = userSnapshot;

    if(user.data == null) {
        await usersCollection
        .document(uid)
        .setData({'userId': uid});
    }
  }

  Future getUser() async {
    return await usersCollection.document(uid).get();
  }
}
