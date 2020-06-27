import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    return await _firebaseAuth.currentUser() != null;
  }

  Stream<bool> isSignedInStream() {
    return _firebaseAuth.onAuthStateChanged.map((currentUser) {
      return currentUser != null;
    });
  }

  Future<CurrentUserModel> getUserDetails() async {
    FirebaseUser _firebaseUser = await _firebaseAuth.currentUser();
    return CurrentUserModel(
        email: _firebaseUser.email,
        profilePhoto: _firebaseUser.photoUrl,
        userID: _firebaseUser.uid,
        name: _firebaseUser.displayName);
  }
}
