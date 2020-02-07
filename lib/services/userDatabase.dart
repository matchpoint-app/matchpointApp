import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matchpoint/models/AccountInformation.dart';

class UserDatabaseService {
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUser(String uid, AccountInformation updatedUser) async {
    final userSnapshot = await usersCollection.document(uid).get();
    if (userSnapshot.data == null) {
      var user = AccountInformation(id: uid);
      await usersCollection.document(uid).setData(user.toJson());
    } else {
      var result =
          await usersCollection.document(uid).setData(updatedUser.toJson());
    }
  }

  Future getUser(String uid) async {
    return await usersCollection.document(uid).get();
  }

  Future searchUser(String name) async {
    var result =
        await usersCollection.where("name", isEqualTo: name).getDocuments();

    return result.documents;
  }

  Future searchFriends(String name, List<dynamic> friends) async {
    var result = await usersCollection
        .where("id", whereIn: friends)
        .where("name", isEqualTo: name)
        .getDocuments();

    return result.documents;
  }
}
