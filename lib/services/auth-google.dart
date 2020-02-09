import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matchpoint/services/userDatabase.dart';

class GoogleAuth {
  static GoogleSignIn _googleAuth = GoogleSignIn();

  static Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleAuth.signIn();
    // cancelled
    if (googleUser == null) return null;

    final GoogleSignInAuthentication auth = await googleUser.authentication;
    final AuthCredential creds = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken, idToken: auth.idToken);

    final AuthResult result =
        await FirebaseAuth.instance.signInWithCredential(creds);
    assert(result != null);

    if (result.additionalUserInfo.isNewUser) {
      final UserDatabaseService userDatabaseService = UserDatabaseService();
      userDatabaseService.updateUser(result.user.uid, null);
    }

    final FirebaseUser user = result.user;
    assert(!user.isAnonymous);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    return currentUser;
  }

  static signOut() {
    return _googleAuth.signOut();
  }
}
