import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/models/appuser.dart';
import 'package:hello_world/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user based on fireBaseuser

  AppUser createUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // listen to auth changes

  Stream<AppUser> get user {
    return _auth.authStateChanges().map((User user) => createUser(user));
  }

  // sign in anonm

  Future signInAnon() async {
    try {
      dynamic result = await _auth.signInAnonymously();
      User user = result.user;
      return createUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and pass

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return createUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);

      return createUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
