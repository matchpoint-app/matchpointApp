import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchpoint/services/userDatabase.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final userInformation = UserDatabaseService(result.user.uid).getUser();

      return userInformation;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      final UserDatabaseService userDatabaseService =
          UserDatabaseService(user.uid);
      userDatabaseService.updateUser();
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
