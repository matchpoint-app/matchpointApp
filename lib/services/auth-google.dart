import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matchpoint/models/profile-information.dart';
import 'package:matchpoint/services/userDatabase.dart';

class GoogleAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final UserDatabaseService _db = UserDatabaseService();
  static final GoogleSignIn _googleAuth = GoogleSignIn();

  static Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleAuth.signIn();
    // cancelled
    if (googleUser == null) return null;

    final GoogleSignInAuthentication auth = await googleUser.authentication;
    final AuthCredential creds = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken, idToken: auth.idToken);

    final AuthResult result = await _auth.signInWithCredential(creds);
    assert(result != null);

    final FirebaseUser user = result.user;
    assert(!user.isAnonymous);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);

    await _createUser(currentUser);
    return currentUser;
  }

  static _createUser(FirebaseUser user) async {
    final doc = await _db.getUser(user.uid);
    if (!doc.exists || doc.data == null || doc.data.isEmpty) {
      print("saving default profile info");
      var data = ProfileInformation(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          photoUrl: user.photoUrl,
          description: null,
          location: null,
          rating: null,
          sports: [],
          groups: [],
          friends: []);

      return _db.updateUser(user.uid, data);
    }
  }

  static Future signOut() {
    return Future.wait([_googleAuth.signOut(), _auth.signOut()]);
  }
}
