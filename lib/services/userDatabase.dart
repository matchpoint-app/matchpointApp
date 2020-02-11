import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchpoint/models/profile-information.dart';

class UserDatabaseService {
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUser(String uid, ProfileInformation updatedUser) async {
    final userSnapshot = await usersCollection.document(uid).get();
    if (userSnapshot.data == null) {
      var user = updatedUser;
      user.id = uid;
      await usersCollection.document(uid).setData(user.toJson());
    } else {
      await usersCollection.document(uid).setData(updatedUser.toJson());
    }
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return usersCollection.document(uid).get();
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

  Future getPlayers(List<dynamic> players) async {
    var result =
        await usersCollection.where("id", whereIn: players).getDocuments();

    return result.documents;
  }

  Stream<ProfileInformation> streamAccountInformation(FirebaseUser user) {
    return usersCollection
        .document(user.uid)
        .snapshots()
        .map((snapshot) => ProfileInformation.fromJson(snapshot));
  }

  Future setUserDescription(ProfileInformation profile, String value) async {
    var data = {'description': value};
    await usersCollection.document(profile.id).updateData(data);
  }
}
