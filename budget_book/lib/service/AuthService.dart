import 'package:budget_book/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  
  AuthService._internal() {
    // init things inside this
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  
  /// Creates the user model for a given firebase user
  User _createUserModel(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  // auth state change stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_createUserModel);
  }

  static Future<String> getUserUID() async {
    FirebaseUser user = await AuthService._instance._auth.currentUser();
    if (user != null) {
      return user.uid;
    }
    return "";
  }

    static Future<String> getUserEmail() async {
    FirebaseUser user = await AuthService._instance._auth.currentUser();
    if (user != null) {
      return user.email;
    }
    return "";
  }

  /// Performs a sign in with the given credentials
  Future<User> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    _user = _createUserModel(result.user);
    return _user;
  }

  /// Performs a sign in with the given credentials
  Future<User> signUp(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    _user = _createUserModel(result.user);
    return _user;
  }

  /// Signs out the current user
  Future signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }
}