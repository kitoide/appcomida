import 'dart:convert';

import 'package:appcomida/Login/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  LoginModel login = new LoginModel();

  FirebaseAuth _auth;
  GoogleSignIn googleSignIn;

  _LoginControllerBase() {
    Firebase.initializeApp().then((value) {
      _auth = FirebaseAuth.instance;
      googleSignIn = GoogleSignIn();
    });
    _getLogin();
  }

  Future<bool> signInWithGoogle() async {
    // await Firebase.initializeApp();

    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        login.email = user.email;
        login.name = user.displayName;
        login.image = user.photoURL;
        login.token = user.uid;

        var dbLogin = await SharedPreferences.getInstance();
        dbLogin.setString("login", jsonEncode(login.toJson()));

        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    var dbInfo = await SharedPreferences.getInstance();
    dbInfo.clear();
    _getLogin();

    print("User Signed Out");
  }

  void _getLogin() async {
    var dbInfo = await SharedPreferences.getInstance();
    if (dbInfo.getString("login") != null)
      login = LoginModel.fromJson(jsonDecode(dbInfo.getString("login")));
    else {
      login = new LoginModel();
    }
  }
}
